-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
--Wiget Library
require("vicious")
-- awesoMPD Widget
--require("awesompd/awesompd")
--awful.util.spawn_with_shell("xcompmgr -cF &")
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
beautiful.init("/usr/share/awesome/themes/blind-alien/theme.lua")

-- This is used later as the default terminal and editor to run.
--terminal = "urxvt"
terminal = "konsole"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

screencount = screen.count()

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.magnifier,
  awful.layout.suit.max
}
-- }}}

-- {{{ Tags

-- Define a tag table which will hold all screen tags.
--tags = {
--  --names = { "1", "2", "3", "4", "5", "6"},
--  --names  = { "⌘", "♐", "⌥", "ℵ"},
--  --names  = { "⠪", "⠫", "⠬", "⠭", "⠮", "⠳"},
--  names = { "⠐", "⠡", "⠲", "⠵", "⠻", "⠿" },
--  --names  = { "∙", "⠡", "⠲", "⠵", "⠻", "⠿"},
--  --names  = { "⠐", " ⠡ ", " ⠲ ", " ⠵ ", " ⠾ ", " ⠿ "},
--  --names  = { "⢷", "⣨", "⡪", "⣌", "⣪", "⡝"},
--  layout = {
--    layouts[8], layouts[8], layouts[8], layouts[8], layouts[8], layouts[8]
--  }
--}
tags = {
 names  = { "Workstation", "Browsing", "Email", "Music", "PlayGround" },
 layout = { layouts[2], layouts[1], layouts[1], layouts[9], layouts[1], layouts[1] }}
for s = 1, screen.count() do
  tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
  { "restart", awesome.restart },
  { "quit", awesome.quit }
}

mymainmenu = awful.menu({
  items = {
    { "awesome", myawesomemenu, beautiful.awesome_icon },
    { "open terminal", terminal }
  }
})

mylauncher = awful.widget.launcher({
  image = image(beautiful.awesome_icon),
  menu = mymainmenu
})
-- }}}

-- Separators

spacer = widget({ type = "textbox" })
space = widget({ type = "textbox" })
separator = widget({ type = "textbox" })
vertline = widget({ type = "textbox" })
dash = widget({ type = "textbox" })
spacer.text = "  "
space.text = " "
separator.text = "||"
vertline.text = "|"
dash.text = "-"

-- {{{ Wibox

-- Status Labels
c1 = widget({ type = "textbox" })
c1.text = "Core 1"
c2 = widget({ type = "textbox" })
c2.text = "Core 2"
rlabel = widget({ type = "textbox" })
rlabel.text = "Root:"
hlabel = widget({ type = "textbox" })
hlabel.text = "Home:"

------Create a Volume Widget
--volicon = widget({ type = "imagebox" })
----volicon.image = image("/usr/share/awesome/themes/astromouse/icons3/vol.png")
--volicon.image = image("beautiful.widget_vol")
----Initialize widget
--volbar = awful.widget.progressbar()
----Progressbar settings
--  volbar:set_width(8)
-- volbar:set_height(18)
-- volbar:set_vertical(true)
-- volbar:set_ticks(true)
-- volbar:set_ticks_gap(1)
-- volbar:set_ticks_size(2)
-- volbar:set_background_color("#000000")
-- volbar:set_border_color("#000000")
-- volbar:set_color("#D9D9D9")
-- volbar:set_gradient_colors({ "#D9D9D9", "#D9D9D9", "#D9D9D9" })
----Register widget
--vicious.register(volbar, vicious.widgets.volume, "$1", 2, "Master")


-- OS info
sys = widget({ type = "textbox" })
vicious.register(sys, vicious.widgets.os, "$1 $2")

-- Pacman updates
-- Widget
-- Icon
-- picon = widget({ type = "imagebox" })
-- picon.image = image(beautiful.widget_pacnew)
-- Use the Pacman icon as launcher to update the package list (change to fit your package-management system)



-- MPD Widget
--mpdicon = widget({ type = "imagebox" })
--mpdicon.image = image(beautiful.widget_mpd)
---- Initialize widget
--mpdwidget = widget({ type = "textbox" })
---- Register Widget
----vicious.register(mpdwidget, vicious.widgets.mpd, "<span color='#D8D9DA'> </span> ${Artist} - ${Title}", 13)
--vicious.register(mpdwidget, vicious.widgets.mpd, "[${state}] : ${Artist} - ${Title}", 13)
--
---- PLAY, STOP, PREV/NEXT Buttons
---- requires modification of /usr/share/awesome/lib/awful/widget/launcher.lua
----  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn(args.command) end)) 
----  to:
----  b = util.table.join(w:buttons(), button({}, 1, nil, function () util.spawn_with_shell(args.command) end))
--music_play = awful.widget.launcher({
--  image = beautiful.widget_play,
--  command = "mpc toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
--})
--
--music_stop = awful.widget.launcher({
--  image = beautiful.widget_stop,
--  command = "mpc stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
--})
--
--music_prev = awful.widget.launcher({
--  image = beautiful.widget_prev,
--  command = "mpc prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
--})
--
--music_next = awful.widget.launcher({
--  image = beautiful.widget_next,
--  command = "mpc next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
--})



-- Wifiwidget
wifiwidget = widget({ type = "textbox" })
-- Register Widget
-- change to the desired network adapter if needed
vicious.register(wifiwidget, vicious.widgets.wifi, "~ ${link}%", 5, "wlan0")



--separator
--spicon = widget({ type = "imagebox" })
--spicon.image = image("/usr/share/awesome/themes/astromouse/icons/separator.png")



-- Create a netwidget (usage)
dnicon = widget({ type = "imagebox" })
upicon = widget({ type = "imagebox" })
dnicon.image = image(beautiful.widget_down)
upicon.image = image(beautiful.widget_up)
-- Initialize widget
netdnwidget = widget({ type = "textbox" })
netdnwidget.width = 66
netdnwidget.align = "right"

netupwidget = widget({ type = "textbox" })
netupwidget.width = 66
netupwidget.align = "right"
-- Register widget
-- change to the desired network adapter if needed
vicious.register(netdnwidget, vicious.widgets.net, "${wlan0 down_kb} kB/s", 1)
vicious.register(netupwidget, vicious.widgets.net, "${wlan0 up_kb} kB/s", 1)



-- Create a battery widget
baticon = widget({ type = "imagebox" })
baticon.image = image(beautiful.widget_batfull)
--Initialize widget
batwidget = widget({ type = "textbox" })
--Register widget
vicious.register(batwidget, vicious.widgets.bat, "$1$2", 31, "BAT0")




-- {{{ CPU 
-- Core Temp
tempwidget = widget({ type = "textbox" })
--vicious.register(tempwidget, vicious.widgets.thermal, "$1°C", 5, { "coretemp.0", "core" })
vicious.register(tempwidget, vicious.widgets.thermal, "$1 °C", 19, "thermal_zone0")
-- Icon
tempicon = widget({ type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)

-- Readout
-- Icon
cpuicon = widget({ type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
-- Percentage
--cpu1 = widget({ type = "textbox" })
--vicious.register(cpu1, vicious.widgets.cpu, "(1): $1%")
--cpu2 = widget ({ type = "textbox" })
--vicious.register(cpu2, vicious.widgets.cpu, "(2): $2%")

-- Core 1 Meter
cpubar = awful.widget.progressbar()
cpubar:set_width(50)
cpubar:set_height(6)
cpubar:set_vertical(false)
cpubar:set_background_color("#434343")
--cpubar:set_color(beautiful.fg_normal)
--cpubar:set_gradient_colors({ "#5fa496", "#878bff" })
cpubar:set_gradient_colors({ beautiful.fg_normal,  beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
cpubar.layout = awful.widget.layout.horizontal.rightleft
vicious.register(cpubar, vicious.widgets.cpu, "$1", 1)
awful.widget.layout.margins[cpubar.widget] = { top = 7 }

-- Core 2 Meter
cpubar2 = awful.widget.progressbar()
cpubar2:set_width(50)
cpubar2:set_height(6)
cpubar2:set_vertical(false)
cpubar2:set_background_color("#434343")
--cpubar2:set_color(beautiful.fg_normal )
--cpubar2:set_gradient_colors({ "#5fa496", "#878bff" })
cpubar2:set_gradient_colors({ beautiful.fg_normal,  beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })
cpubar2.layout = awful.widget.layout.horizontal.rightleft
vicious.register(cpubar2, vicious.widgets.cpu, "$2", 1)
awful.widget.layout.margins[cpubar2.widget] = { top = 7 }


-- Frequency
-- Core 1
freq1 = widget({ type = "textbox" })
vicious.register(freq1, vicious.widgets.cpufreq, "$2 GHz", 9, "cpu0")
-- Core 2
freq2 = widget({ type = "textbox" })
vicious.register(freq2, vicious.widgets.cpufreq, "$2 GHz", 9, "cpu1")
-- Cache that shit
vicious.cache(vicious.widgets.cpu)

-- }}} CPU



-- {{{ MEM

-- Icon
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
-- Percentage
--mem = widget({ type = "textbox" })
--vicious.register(mem, vicious.widgets.mem, "$1%")

-- Meter
membar = awful.widget.progressbar()
membar:set_width(50)
membar:set_height(6)
membar:set_vertical(false)
membar:set_background_color("#434343")
--membar:set_color(beautiful.fg_normal )
membar:set_gradient_colors({ beautiful.fg_normal,  beautiful.fg_normal, beautiful.fg_normal, beautiful.bar })

--This bar should be placed on the right side of the wibox unless
--it's a dual-screen config in which case the default (leftright)
--layout is used... change that if you need!
if screen.count() ~= 2 then
  membar.layout = awful.widget.layout.horizontal.rightleft
end

--Register the widget
vicious.register(membar, vicious.widgets.mem, "$1", 7)

-- Align progressbars
awful.widget.layout.margins[membar.widget] = { top = 7 }

-- Usage
--mem_total = widget({ type = "textbox" })
--vicious.register(mem_total, vicious.widgets.mem, "$3 MB", 9)
--mem_used = widget({ type = "textbox" })
--vicious.register(mem_total, vicious.widgets.mem, "$2 MB", 9,)

-- Cache that shit
vicious.cache(vicious.widgets.mem)

-- }}} MEM


-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" }, "%H:%M")

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(awful.button({}, 1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev))
mytasklist = {}
mytasklist.buttons = awful.util.table.join(awful.button({}, 1, function(c)
  if not c:isvisible() then
    awful.tag.viewonly(c:tags()[1])
  end
  client.focus = c
  c:raise()
end),
  awful.button({}, 3, function()
    if instance then
      instance:hide()
      instance = nil
    else
      instance = awful.menu.clients({ width = 250 })
    end
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end))


for s = 1, screencount do
  -- Set a screen margin for borders
  awful.screen.padding(screen[s], { top = 0 })
  -- Create a promptbox for each screen
  mypromptbox[s] = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
    awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
    awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
  -- Create a taglist widget
  mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- WARNING: In order to properly view the tasklist some lua files have been modified. For the
  -- tasklist_floating_icon icon to be placed on the left side of the task name instead of the
  -- right alignment, /usr/share/awesome/lib/awful/widget/tasklist.lua in function new(label, buttons) the
  -- variable widgets.textbox has to be modified like this:
  -- remove bg_align = "right" and
  -- modify the left margin from 2 to icon width + 2 (i.e.: 18).

  -- Create a tasklist widget
  mytasklist[s] = awful.widget.tasklist(function(c)
    return awful.widget.tasklist.label.currenttags(c, s,
      -- WARNING: Requires modified /usr/share/awesome/lib/awful/widget/tasklist.lua !!!
      -- This basically hides the application icons on the tasklist. If you don't want this or
      -- prefer not to change your tasklist.lua remove the following line!
      { hide_icon = true })
  end, mytasklist.buttons)


  -- Here we create the wiboxes if it's not a dual-screen layout
  --if screencount ~= 2 then
    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 20 })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
      {
        space,
        mytaglist[s],
        spacer,
        mypromptbox[s],
        layout = awful.widget.layout.horizontal.leftright
      },

      spacer,
      mytextclock,
      space,
      mylayoutbox[s],
      spacer,
      mysystray,
      mytasklist[s],
      layout = awful.widget.layout.horizontal.rightleft
    }

    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })

    mybottomwibox[s].widgets = {
      --{
      --  space,
      --  music_play,
      --  music_stop,
      --  music_prev,
      --  music_next,
      --  space,
      --  mpdwidget,
      --  spacer,
      --  layout = awful.widget.layout.horizontal.leftright
      --},
--
      spacer,
      sys,
      spacer,
      separator,
      spacer,
      batwidget,
      spacer,
      baticon,
      spacer,
      separator,
      spacer,
      tempwidget,
      spacer,
      tempicon,
      -- CPU core 2
      spacer,
      separator,
      spacer,
      freq2,
      spacer,
      cpubar2,
      spacer,
      c2,
      spacer,
      cpuicon,
      -- CPU core 1
      spacer,
      separator,
      spacer,
      freq1,
      spacer,
      cpubar,
      spacer,
      c1,
      spacer,
      cpuicon,
      spacer,
      separator,
      spacer,
      membar,
      spacer,
      memicon,
      spacer,
      separator,
      spacer,
      wifiwidget,
      spacer,
      upicon,
      spacer,
      netupwidget,
      --spacer,
      separator,
      spacer,
      dnicon,
      spacer,
      netdnwidget,
      --volbar,
      --volicon,
      layout = awful.widget.layout.horizontal.rightleft
    }
  end
--end

--if screencount == 2 then
--  -- Here we create the wiboxes if it is a dual screen configuration:
--  mywibox[1] = awful.wibox({ position = "top", screen = 1, border_width = 0, height = 20 })
--  -- Add widgets to the wibox - order matters
--  mywibox[1].widgets = {
--    {
--      space,
--      mytaglist[1],
--      spacer,
--      mypromptbox[1],
--      layout = awful.widget.layout.horizontal.leftright
--    },
--
--    spacer,
--    mytextclock,
--    space,
--    mylayoutbox[1],
--    spacer,
--    mytasklist[1],
--    layout = awful.widget.layout.horizontal.rightleft
--  }
--
--  mybottomwibox[1] = awful.wibox({ position = "bottom", screen = 1, border_width = 0, height = 20 })
--
--  mybottomwibox[1].widgets = {
--    {
--      space,
--      music_play,
--      music_stop,
--      music_prev,
--      music_next,
--      space,
--      mpdwidget, spacer,
--      layout = awful.widget.layout.horizontal.leftright
--    },
--
--    spacer,
--    mysystray,
--    layout = awful.widget.layout.horizontal.rightleft
--  }
--  mywibox[2] = awful.wibox({ position = "top", screen = 2, border_width = 0, height = 20 })
--
--  mywibox[2].widgets = {
--    {
--      space,
--      mytaglist[2],
--      spacer,
--      mypromptbox[2],
--      layout = awful.widget.layout.horizontal.leftright
--    },
--
--    spacer,
--    mytextclock,
--    space,
--    mylayoutbox[2],
--    spacer,
--    mytasklist[2],
--    layout = awful.widget.layout.horizontal.rightleft
--  }
--
--  mybottomwibox[2] = awful.wibox({ position = "bottom", screen = 2, border_width = 0, height = 20 })
--
--  mybottomwibox[2].widgets = {
--    {
--      spacer,
--      sys,
--      spacer,
--      separator,
--      spacer,
--      picon,
--      spacer,
--      pacup,
--      spacer,
--      separator,
--      spacer,
--      dnicon,
--      spacer,
--      netdnwidget,
--      spacer,
--      separator,
--      spacer,
--      upicon,
--      spacer,
--      netupwidget,
--      spacer,
--      separator,
--      spacer,
--      memicon, spacer,
--      membar, spacer,
--      layout = awful.widget.layout.horizontal.leftright
--    },
--
--    spacer,
--    tempwidget,
--    spacer,
--    tempicon,
--    spacer,
--    separator,
--    spacer,
--    freq2,
--    spacer,
--    cpubar2,
--    spacer,
--    c2,
--    spacer,
--    cpuicon,
--    spacer,
--    separator,
--    spacer,
--    freq1,
--    spacer,
--    cpubar,
--    spacer,
--    c1,
--    spacer,
--    cpuicon,
--    spacer,
--    layout = awful.widget.layout.horizontal.rightleft
--  }
--end

-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(awful.key({ modkey, }, "Left", awful.tag.viewprev),
  awful.key({ modkey, }, "Right", awful.tag.viewnext),
  awful.key({ modkey, }, "Escape", awful.tag.history.restore),

  awful.key({ modkey, }, "j",
    function()
      awful.client.focus.byidx(1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "k",
    function()
      awful.client.focus.byidx(-1)
      if client.focus then client.focus:raise() end
    end),
  awful.key({ modkey, }, "w", function() mymainmenu:show({ keygrabber = true }) end),

  --Volume manipulation
  --awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 5+") end),
  --awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 5-") end),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
  awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
  awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey, }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then
        client.focus:raise()
      end
    end),

  -- Standard program
  awful.key({ modkey, }, "Return", function() awful.util.spawn(terminal) end),
  awful.key({ modkey, "Control" }, "r", awesome.restart),
  awful.key({ modkey, "Shift" }, "q", awesome.quit),

  awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end),
  awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
  awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
  awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1) end),
  awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),
  awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),
  awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(layouts, -1) end),
  awful.key({ modkey, "Control" }, "n", awful.client.restore),

  -- Prompt
  awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end),

  awful.key({ modkey }, "x",
    function()
      awful.prompt.run({ prompt = "Run Lua code: " },
        mypromptbox[mouse.screen].widget,
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
    end))

clientkeys = awful.util.table.join(awful.key({ modkey, }, "f", function(c) c.fullscreen = not c.fullscreen end),
  awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
  awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
  awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),
  awful.key({ modkey, }, "o", awful.client.movetoscreen),
  awful.key({ modkey, "Shift" }, "r", function(c) c:redraw() end),
  awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),
  awful.key({ modkey, }, "n", function(c) c.minimized = not c.minimized end),
  awful.key({ modkey, }, "m",
    function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c.maximized_vertical = not c.maximized_vertical
    end))

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screencount do
  keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
  globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewonly(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Control" }, "#" .. i + 9,
      function()
        local screen = mouse.screen
        if tags[screen][i] then
          awful.tag.viewtoggle(tags[screen][i])
        end
      end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.movetotag(tags[client.focus.screen][i])
        end
      end),
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
      function()
        if client.focus and tags[client.focus.screen][i] then
          awful.client.toggletag(tags[client.focus.screen][i])
        end
      end))
end

clientbuttons = awful.util.table.join(awful.button({}, 1, function(c) client.focus = c; c:raise() end),
  awful.button({ modkey }, 1, awful.mouse.client.move),
  awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      size_hints_honor = false,
      focus = true,
      keys = clientkeys,
      buttons = clientbuttons
    }
  },
  {
    rule = { class = "MPlayer" },
    properties = { floating = true }
  },
  {
    rule = { class = "pinentry" },
    properties = { floating = true }
  },
  {
    rule = { class = "gimp" },
    properties = { floating = true }
  },
  { rule = { class = "Thunderbird" },   properties = { tag = tags[1][3] } },
  { rule = { class = "Spotify" },   properties = { tag = tags[1][4] } },
  -- Set Firefox to always map on tags number 2 of screen 1.
  -- { rule = { class = "Firefox" },
  --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function(c, startup)
-- Add a titlebar
 --awful.titlebar.add(c, { modkey = modkey })

-- Enable sloppy focus
  c:add_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
      client.focus = c
    end
  end)

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

-- {{{ Tag signal handler - selection
-- - ASCII tags 1 [2] 3 4...
--   - start with tag 1 named [1] in tag setup
--[[
for s = 1, screencount do
    for t = 1, #tags[s] do
        tags[s][t]:add_signal("property::selected", function ()
            if tags[s][t].selected then
                tags[s][t].name = "[" .. tags[s][t].name .. "]"
            else--]]
--tags[s][t].name = tags[s][t].name:gsub("[%[%]]", "")
--[[ end
        end)
    end
end
--]]
-- }}}



