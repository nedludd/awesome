-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
theme_path       = awful.util.getdir("config").."/theme/theme.lua"
beautiful.init(theme_path)

-- Notification library
require("naughty")

-- Extra widgets
require("vicious")

-- Drop down terminal
require("teardrop")

-- require("obvious.lib.mpd")

require("obvious.volume_alsa")
-- obvious.volume_alsa(0,"Master")

require("obvious.basic_mpd")
obvious.basic_mpd.set_format("$artist - $title")

require("obvious.clock")
obvious.clock.set_editor("/usr/bin/emacsclient -n -c ")
obvious.clock.set_shortformat("%I:%M %p | ")
obvious.clock.set_longformat("%A %d %B %Y | ")

require("obvious.popup_run_prompt")
obvious.popup_run_prompt.set_opacity(0.7)
obvious.popup_run_prompt.set_slide(true)
obvious.popup_run_prompt.set_height(20)
obvious.popup_run_prompt.set_prompt_string("<span color='orange' font_desc='Tahoma 10'>Run: </span>")

--focus_trans = true
--opacity_normal = 0.8
--opacity_focus = 1
--opacity_toggle = 0.6
--opacity_step = 0.05

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
-- theme_path = "/usr/share/awesome/themes/aurantium/theme.lua"

--theme_path       = awful.util.getdir("config").."/zenburn.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme.lua"

-- Actually load theme
--beautiful.init(theme_path)

naughty.config.width            = 200

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = "/usr/bin/emacsclient -n -c"
browser = "/home/thermans/bin/start_firefox.sh"
imclient = "/usr/bin/pidgin"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod3"
ctrlkey = "Caps_Lock"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,             -- 1 
    awful.layout.suit.tile.left,        -- 2
    awful.layout.suit.tile.bottom,      -- 3
    awful.layout.suit.tile.top,         -- 4
    awful.layout.suit.fair,             -- 5
    awful.layout.suit.fair.horizontal,  -- 6
    awful.layout.suit.spiral,           -- 7
    awful.layout.suit.spiral.dwindle,   -- 8
    awful.layout.suit.max,              -- 9
    awful.layout.suit.max.fullscreen,   -- 10
    awful.layout.suit.magnifier,        -- 11
    awful.layout.suit.floating          -- 12
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{

-- Weather 
weatherwidget = widget({
                          type = 'textbox',
                          name = 'weatherwidget',
                          align = 'right'
})

vicious.register(weatherwidget, vicious.widgets.weather, "${sky} ${tempf}° | ", 180, "KIAD")

-- Pacman
pacmanwidget = widget({ type = 'textbox' })
vicious.register(pacmanwidget, vicious.widgets.pacman, "<span color='orange'>$1</span>", 3600, nil)

-- CPU
cpuwidget = awful.widget.graph()
cpuwidget:set_width(20)
cpuwidget:set_background_color('#222222')
cpuwidget:set_color('#FF5656')
cpuwidget:set_gradient_colors({ '#FF5656', '#88A175', '#AECF96' })
vicious.register(cpuwidget, vicious.widgets.cpu, '$1', 3)

-- Memory
memwidget = widget({ type = 'textbox' })
vicious.enable_caching(vicious.widgets.mem)
vicious.register(memwidget, vicious.widgets.mem, ' Mem: $1% ', 13)

-- {{{ Tags

tag.properties   = {{ name    = "main",
                      layout  = layouts[1]
                    },
                    { name    = "emacs",
                      layout  = layouts[1]
                    },
                    { name    = "www",
                      layout  = layouts[9]
                    },
                    { name    = "im",
                      layout  = layouts[2],
                      mwfact  = 0.2,
                      ncols   = 2
                    },
                    { name    = "mail",
                       layout = layouts[12]
                    },
                    { name    = "6",
                      hide    = true
                    },
                    { name    = "7",
                      hide    = true
                    },
                    { name    = "8",
                      hide    = true
                    },
                    { name    = "9",
                      hide    = true
                    }
                 }

-- Define a tag table which hold all screen tags.
tags = {}

for s = 1, screen.count() do
  -- Each screen has its own tag table.
  tags[s] = {}
  -- Create tags
  for i, v in ipairs(tag.properties) do
     tags[s][i] = tag({ name = v.name })
     tags[s][i].screen = s
     awful.tag.setproperty(tags[s][i], "layout", v.layout)
     awful.tag.setproperty(tags[s][i], "mwfact", v.mwfact)
     awful.tag.setproperty(tags[s][i], "nmaster", v.nmaster)
     awful.tag.setproperty(tags[s][i], "ncols", v.ncols)
     awful.tag.setproperty(tags[s][i], "hide", v.hide)
  end
  -- I'm sure you want to see at least one tag.
  tags[s][1].selected = true
end

-- }}}

-- {{{ Wibox

 -- applications menu
--require('freedesktop.utils')
--freedesktop.utils.terminal = terminal  -- default: "xterm"
--freedesktop.utils.icon_theme = 'gnome' -- look inside /usr/share/icons/, default: nil (don't use icon theme)
--require('freedesktop.menu')
--require("debian.menu")

--menu_items = freedesktop.menu.new()
--myawesomemenu = {
--   { "manual", terminal .. " -e man awesome", freedesktop.utils.lookup_icon({ icon = 'help' }) },
--   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/awesome.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
--   { "restart", awesome.restart, freedesktop.utils.lookup_icon({ icon = 'gtk-refresh' }) },
--   { "quit", awesome.quit, freedesktop.utils.lookup_icon({ icon = 'gtk-quit' }) }
--}
--table.insert(menu_items, { "awesome", myawesomemenu, beautiful.awesome_icon })
--table.insert(menu_items, { "open terminal", terminal, freedesktop.utils.lookup_icon({icon = 'terminal'}) })
--table.insert(menu_items, { "Debian", debian.menu.Debian_menu.Debian, freedesktop.utils.lookup_icon({ icon = 'debian-logo' }) })

--mymainmenu = awful.menu.new({ items = menu_items, width = 150, height = 20 })

--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     --menu = mymainmenu })


-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if not c:isvisible() then
                                                  awful.tag.viewonly(c:tags()[1])
                                              end
                                              client.focus = c
                                              c:raise()
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Create a table with widgets that go to the right
    right_aligned = {
      layout = awful.widget.layout.horizontal.rightleft
    }
    if s == 1 then table.insert(right_aligned, mysystray) end
    table.insert(right_aligned, mytextclock)
    table.insert(right_aligned, mylayoutbox[s])

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
      mytaglist[s],
      mylauncher,
      mypromptbox[s],
      right_aligned,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.leftright,
      height = mywibox[s].height
    }

  bottom_left = {
    layout = awful.widget.layout.horizontal.leftright
  }
    if s == 1 then table.insert(right_aligned, obvious.basic_mpd()) end
    table.insert(right_aligned, obvious.volume_alsa())

    -- Create the BOTTOM wibox
    mybottom[s] = awful.wibox({ screen = s, position = "bottom", height = 18 })
    mybottom[s].widgets = {
       bottom_right,
       s == 1 and mysystray or nil,
       s == 1 and obvious.clock() or nil,
       s == 1 and weatherwidget or nil,

       s == 2 and cpuwidget or nil,
       s == 2 and memwidget or nil,
       s == 2 and pacmanwidget or nil,
       layout = awful.widget.layout.horizontal.rightleft
    }
 end

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    --awful.key({ modkey,           }, "w", function () mymainmenu:show(true)        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    -- awful.key({ modkey,           }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end),
    -- Rotate clients (like "Alt-Tab" in windows
    awful.key({ modkey }, "Tab", function ()
                                     local allclients = awful.client.visible(client.focus.screen)
                                     
                                     for i,v in ipairs(allclients) do
                                        if allclients[i+1] then
                                           allclients[i+1]:swap(v)
                                        end
                                     end
                                     awful.client.focus.byidx(-1)
                                  end),

    -- ... the other way 'round!
    awful.key({ modkey, "Shift" }, "Tab", function ()
                                              local allclients = awful.client.visible(client.focus.screen)

                                              for i,v in ipairs(allclients) do
                                                 allclients[1]:swap(allclients[i])
                                              end
                                              awful.client.focus.byidx(1)
                                           end),

    -- Drop down terminal
    awful.key({ modkey,           }, "t",      function () teardrop("urxvtc", "top", "center", 0.5 ) end),

    -- Standard programs
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "w",      function () awful.util.spawn(browser) end),
    awful.key({ modkey,           }, "e",      function () awful.util.spawn(editor) end),
    awful.key({ modkey,           }, "i",      function () awful.util.spawn(imclient) end),
    awful.key({ modkey,           }, "x",      function () awful.util.spawn("/home/thermans/bin/putstring Y4naT6wZ") end),
    awful.key({ modkey,           }, "v",      function () awful.util.spawn("/home/thermans/bin/putstring utBjCxb7") end),

    -- Restart and Stop
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    -- Client manipulation
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey }, "r", obvious.popup_run_prompt.run_prompt),
    --    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Search prompt
    awful.key({ modkey }, "s", function ()
        awful.prompt.run({ prompt = "<span color='orange' font_desc='Tahoma 10'>Search: </span>" }, mypromptbox[mouse.screen].widget,
            function (command)
                awful.util.spawn("firefox 'http://yubnub.org/parser/parse?command="..command.."'", false)
                -- Switch to the web tag, where Firefox is, in this case tag 3
                if tags[mouse.screen][3] then awful.tag.viewonly(tags[mouse.screen][3]) end
            end)
    end),

    -- awful.key({ modkey }, "x",
    --           function ()
    --               awful.prompt.run({ prompt = "Run Lua code: " },
    --               mypromptbox[mouse.screen].widget,
    --               awful.util.eval, nil,
    --               awful.util.getdir("cache") .. "/history_eval")
    --           end),

    awful.key({ modkey }, "F2", function ()
                                   local class = ""
                                   local name = ""
                                   local instance = ""
                                   
                                   if client.focus.class then
                                      class = client.focus.class
                                   end
                                   if client.focus.name then
                                      name = client.focus.name
                                   end
                                   if client.focus.instance then
                                      instance = client.focus.instance
                                   end
                                   
                                   naughty.notify({
                                                     text="c: " .. class .. " i: " .. instance,
                                                     title=name,
                                                     timeout=10
                                                  })
                                end)

)

-- Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),

    -- MPD Keys
    awful.key({ modkey }, "p", obvious.lib.mpd.toggle_play),

    -- Plus and minus to increase and decrease volume
    awful.key({ modkey, "Shift" }, "=",     obvious.volume_alsa.raise(0,"Master",5)),
                                        
    awful.key({}, "XF86AudioRaiseVolume",   obvious.volume_alsa.raise(0,"Master",5)),
    awful.key({}, "XF86AudioMute",   obvious.volume_alsa.mute(0,"Master")),
    awful.key({ modkey }, "-", function () obvious.lib.mpd.volume_down(5) end),
    -- > and < to go to next and previous song
    awful.key({ modkey, "Shift" }, ",", function ()
                                            obvious.lib.mpd.previous()
                                            obvious.basic_mpd.update()
                                        end),
    awful.key({ modkey, "Shift" }, ".", function ()
                                            obvious.lib.mpd.next()
                                            obvious.basic_mpd.update()
                                        end),


    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)


)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
      properties = { border_width = beautiful.border_width,
         border_color = beautiful.border_normal,
         focus = true,
         keys = clientkeys,
         buttons = clientbuttons } },
   -- Floaters
   { rule = { class = "Amarok" },
      properties = { floating = true } },
   { rule = { class = "Audacity" },
      properties = { floating = true } },
   { rule = { class = "MPlayer" },
      properties = { floating = true } },
   { rule = { class = "Boincmgr" },
      properties = { floating = true } },
   { rule = { class = "Vlc" },
      properties = { floating = true } },
   { rule = { class = "gimp" },
      properties = { floating = true } },
   { rule = { class = "sonata" },
      properties = { floating = true } },
   { rule = { class = "Meld" },
      properties = { floating = true } },
   { rule = { class = "Midori" },
      properties = { floating = true } },
   { rule = { class = "freemind*" },
      properties = { floating = true } },
   { rule = { class = "Squeeze" },
      properties = { floating = true } },
   { rule = { class = "Nmapfe" },
      properties = { floating = true } },
   { rule = { class = "Thunar" },
      properties = { floating = true } },
   { rule = { class = "Gconf-editor" },
      properties = { floating = true } },
   { rule = { class = "gcalctool" },
      properties = { floating = true } },
   { rule = { class = "Evince" },
      properties = { floating = true } },
   { rule = { class = "padre" },
      properties = { floating = true } },
   { rule = { class = "SQLite.*" },
      properties = { floating = true } },
   { rule = { class = "Sqliteman" },
      properties = { floating = true } },
   { rule = { class = "Qsvn" },
      properties = { floating = true } },
   { rule = { class = "emelFM2" },
      properties = { floating = true } },
   { rule = { class = "esvn" },
      properties = { floating = true } },
   { rule = { class = "gvim" },
      properties = { floating = true } },
   { rule = { class = "Eog" },
      properties = { floating = true } },
   { rule = { class = "Inkscape" },
      properties = { floating = true } },
   { rule = { class = "feh" },
      properties = { floating = true } },
   { rule = { class = "java" },
      properties = { floating = true } },
   { rule = { class = "wireshark" },
      properties = { floating = true } },
   { rule = { class = "Gvim" },
      properties = { floating = true } },
   { rule = { class = "boinc_gui" },
      properties = { floating = true } },
   { rule = { class = "Xnmap" },
      properties = { floating = true } },
   { rule = { class = "IEXPLORE.EXE" },
      properties = { floating = true } },
   { rule = { class = "nvidia-settings" },
      properties = { floating = true } },
   { rule = { class = "ploticus-graphic" },
      properties = { floating = true } },
   { rule = { class = "Multixterm" },
      properties = { floating = true } },
   { rule = { class = "Gummi" },
      properties = { floating = true } },
   { rule = { class = "Gitk" },
      properties = { floating = true } },
   { rule = { class = "Git-gui" },
      properties = { floating = true } },
   { rule = { class = "Skype" },
      properties = { floating = true } },
   { rule = { class = "Sonata" },
      properties = { floating = true } },
   { rule = { class = "Nvidia-settings" },
      properties = { floating = true } },
   { rule = { class = "d-feet" },
      properties = { floating = true } },
   { rule = { class = "Mound-data-manager" },
      properties = { floating = true } },
   { rule = { class = "Keepassx" },
      properties = { floating = true } },
   { rule = { class = "Kwalletmanager" },
      properties = { floating = true } },
   { rule = { class = "com-eviware-soapui-SoapUI" },
      properties = { floating = true } },
   { rule = { class = "Adl" },
      properties = { floating = true } },
   { rule = { class = "Xephyr" },
      properties = { floating = true, titlebar = true } },
   { rule = { class = "Wine" },
      properties = { floating = true, titlebar = true } },
   { rule = { class = "Xmessage" },
      properties = { floating = true } },
   { rule = { class = "Zathura" },
      properties = { floating = true } },
   { rule = { class = "Textadept" },
      properties = { floating = true } },
   { rule = { class = "lbe.ui.BrowserApp" },
      properties = { floating = true } },
   { rule = { class = "com-ca-directory-jxplorer-JXplorer" },
      properties = { floating = true } },
   { rule = { class = "org-apache-jmeter-NewDriver" },
      properties = { floating = true, titlebar = true } },
   { rule = { class = "Kile" },
      properties = { floating = true, titlebar = true } },
      -- RestClient
   { rule = { class = "org-wiztools-restclient-ui-Main" },
      properties = { floating = true } },
   -- These are Firefox
   { rule = { instance = "Extension" },
      properties = { floating = true } },
   { rule = { instance = "Places" },
      properties = { floating = true } },
   { rule = { class = "org-gjt-sp-jedit-jEdit" },
      properties = { floating = true, tag = tags[2][4] } },
   --  Assign apps to tags
   { rule = { class = "Uzbl-core" },
      properties = {  tag = tags[2][3], switchtotag = true } },
   { rule = { class = "Uzbl-tabbed" },
      properties = {  tag = tags[2][3], switchtotag = true } },
   { rule = { class = "Shaman" },
      properties = { floating = true, tag = tags[2][4] } },
   { rule = { class = "Conkeror" },
      properties = { floating = true, tag = tags[2][3] } },
   { rule = { class = "Google-chrome" },
      properties = { floating = true, tag = tags[2][3] } },
   { rule = { class = "Lyx" },
      properties = { tag = tags[2][4], floating = true, switchtotag = true } },
   { rule = { class = "Namoroka" },
      properties = { tag = tags[1][3], switchtotag = true } },
   { rule = { class = "Thunderbird" },
      properties = { tag = tags[2][5], switchtotag = true } },
   { rule = { class = "Huludesktop" },
      properties = { tag = tags[2][3], switchtotag = true } },
   { rule = { class = "Emacs" },
      properties = { tag = tags[1][2], switchtotag = true } },
   { rule = { class = "Pidgin" },
      properties = { tag = tags[1][4] } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    -- if not startup and awful.client.focus.filter(c) then
    --     c.screen = mouse.screen
    -- end

    -- Add a titlebar
--    awful.titlebar.add(c, { modkey = modkey })

    -- Add a titlebar to each client if enabled globaly
    -- if use_titlebar then
    --    awful.titlebar.add(c, { modkey = modkey })
    -- -- Floating clients always have titlebars
    -- elseif awful.client.floating.get(c)
    --    or awful.layout.get(c.screen) == awful.layout.suit.floating then
    --    if not c.fullscreen then
    --       if not c.titlebar and c.class ~= "Xmessage" then
    --          awful.titlebar.add(c, { modkey = modkey })
    --       end
    --       -- Floating clients are always on top
    --       -- c.above = true
    --    end
    -- end

    -- Setup Pidgin nicely
    if c.class == "Pidgin" and not c.role:find("buddy_list") then
       awful.client.setslave(c)
    end

    -- Handle Thunderbird windows
    -- if c.class == "Thunderbird" and not c.role:find("3pane") then
    --    awful.client.floating.toggle(c)
    -- end

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    c.size_hints_honor = false

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
