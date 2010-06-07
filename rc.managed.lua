--local rc, err = loadfile(os.getenv("HOME").."/.config/awesome/rc.lua"); -- the path to your file
--local rc, err = loadfile("/etc/xdg/awesome/rc.lua")
local rc, err = loadfile(os.getenv("HOME").."/.config/awesome/awesome.lua")
if rc then
	rc, err = pcall(rc);
	if rc then
		-- All ok, return.
		return;
	end
end
 
-- Problems, load fallback rc.lua
 
dofile("/etc/xdg/awesome/rc.lua");
--dofile("/usr/local/etc/xdg/awesome/rc.lua");
 
-- Display the error in the promptbox on all screens
for s = 1,screen.count() do
	mypromptbox[s].text = awful.util.escape(err:match("[^\n]*"));
end
 
-- Write full error (plus traceback) to a file
local f = io.open(os.getenv("HOME").."/.config/awesome/log/startup.err", "w+")
f:write("Awesome error during startup on ", os.date("%c:\n\n"))
f:write(err, "\n");
f:close();
