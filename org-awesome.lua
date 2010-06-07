----------------------------------------------------------
-- @author Damien Leone <damien.leone@fensalir.fr>
-- @copyright 2009 Damien Leone, licensed under the GPLv2
----------------------------------------------------------

-- Grab environment we need
local table = table
local widget = widget
local os = os
local io = io
local string = string
local capi = { screen = screen, mouse = mouse }
local naughty = naughty
local print = print

-- Module org
module("org")

local agenda  = { }
local count   = { }
local options = { }
local files   = { }
local widget

local function basename(file)
   if options.show_basename then
      local f = string.gsub(file, "(.*/)(.*)", "%2") or file
      return string.gsub(f, "(.*)(%.org)", " %1:") or " " .. f .. ":"
   else
      return ""
   end
end

local function parse_agenda()
   -- Compute delays
   local today  = os.time{year=os.date("%Y"), month=os.date("%m"), day=os.date("%d")}
   local soon   = today+24*3600*options.delay_soon
   local future = today+24*3600*options.delay_future

   agenda = { }
   count  = { 
      past   = 0,
      today  = 0,
      soon   = 0,
      future = 0
   }

   for i = 1, #files do
      local fd = io.open(files[i], "r")
      if not fd then
         print("Could not open '" .. files[i] .. "'")
         break
      end

      -- Parse org file
      for l in fd:lines() do
         local scheduled = string.find(l, "SCHEDULED:")
         local closed    = string.find(l, "CLOSED:")
         local deadline  = string.find(l, "DEADLINE:")

         if (scheduled and not closed) or (deadline and not closed) then
            local b, e, y, m, d = string.find(l, "(%d%d%d%d)-(%d%d)-(%d%d)")

            -- If date found
            if b and maybe_task then
               local t = os.time{year=y, month=m, day=d}
               local flag

               -- Determine proper flag
               if t < today then
                  flag = options.color_past
                  count.past = count.past + 1
               elseif t == today then
                  flag = options.color_today
                  count.today = count.today + 1
               elseif t <= soon then
                  flag = options.color_soon
                  count.soon = count.soon + 1
               elseif t <= future then
                  flag = options.color_future
                  count.future = count.future + 1
               end

               if flag then
                  local task = string.gsub(maybe_task, "*", "")
                  local b, e, p = string.find(task, "%[#([ABC])%]")
                  local item = {
                     output = "<span color='" .. flag .. "'>" .. os.date("%d %b:", t) .. basename(files[i]) .. task .. "</span>",
                     when = t,
                     priority = p or "D"
                  }
                  table.insert(agenda, item)
               end
            end
         end
         maybe_task = l
      end
      fd:close()
   end

   -- Sort by date
   table.sort(agenda, function (a, b)
                         return (a.when == b.when and a.priority < b.priority) or (a.when < b.when)
                      end)
   return 0
end

local function colorize_format(flag, count)
   return options.format_colorize and "<span color='" .. flag .. "'>" .. count .. "</span>" or count
end

--- Register org to a widget
-- @param w The widget to register, must be a textbox
-- @param f A table containing the paths to the org files to parse
-- @param opt Options, this is an optional table which can have the following keys: format: textbox format ("$past/$today/$soon/$future" by default), format_colorize: a boolean to colorize the texbox or not (true, by default), width: naughty's width (400 by default), position: naughty position, see naughty documentation for available positions ("top_right" by default), timeout and hover_timeout: see naughty documentation, color_{past,today,soon,future}, delay_{soon,future}: in days (by default soon is 3 days, future is 7 days), show_basename: a boolean to show or not the org file basename in naughty when multiple files are used
function register(w, f, opt)
   widget = w
   files  = f

   options.format        = opt and opt.format        or "$past/$today/$soon/$future"
   options.width         = opt and opt.width         or 400
   options.timeout       = opt and opt.timeout       or 0
   options.hover_timeout = opt and opt.hover_timeout or 0
   options.position      = opt and opt.position      or "top_right"
   options.color_past    = opt and opt.color_past    or "#FF0000"
   options.color_today   = opt and opt.color_today   or "#DED200"
   options.color_soon    = opt and opt.color_soon    or "#00D225"
   options.color_future  = opt and opt.color_future  or "#00921A"
   options.delay_soon    = opt and opt.delay_soon    or 3
   options.delay_future  = opt and opt.delay_future  or 7
   if opt and opt.format_colorize ~= nil then
      options.format_colorize = opt.format_colorize
   else
      options.format_colorize = true
   end
   if opt and opt.show_basename ~= nil then
      options.show_basename = opt.show_basename
   else
      options.show_basename = false
   end

   update()
end

--- Update widgets
function update()
   if parse_agenda() ~= 0 then
      return 1
   end

   local format = options.format

   format = string.gsub(format, "$past",   colorize_format(options.color_past, count.past))
   format = string.gsub(format, "$today",  colorize_format(options.color_today, count.today))
   format = string.gsub(format, "$soon",   colorize_format(options.color_soon, count.soon))
   format = string.gsub(format, "$future", colorize_format(options.color_future, count.future))

   widget.text = format
end

--- Open naughty and display agenda
function naughty_open()
   if #agenda > 0 then
      local output = { }
      for i = 1, #agenda do
         table.insert(output, agenda[i].output)
      end

      n = naughty.notify({
                            text = table.concat(output, "\n"),
                            position = options.position,
                            timeout = options.timeout, hover_timeout = options.hover_timeout,
                            width = options.width, screen = capi.mouse.screen
                         })
   end
end

--- Close naughty
function naughty_close()
   if #agenda > 0 then
      naughty.destroy(n)
   end
end
