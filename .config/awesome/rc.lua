pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

terminal = "alacritty"
browser = "firefox"
run_desktop = "rofi -show drun"
run = "rofi -show run"
screenshot = "flameshot gui"

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

mytextclock = wibox.widget.textclock()

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
        },
        s.mytasklist,
        {
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            wibox.widget.systray(),
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(
    awful.key({ modkey, }, "j", function() awful.client.focus.byidx(1) end),
    awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey, "Shift" }, "Return", function() awful.spawn(terminal) end),
    awful.key({ modkey }, "r", function() awful.spawn.with_shell(run) end),
    awful.key({ modkey }, "p", function() awful.spawn.with_shell(run_desktop) end),
    awful.key({ modkey }, "w", function() awful.spawn.with_shell(browser) end),
    awful.key({ modkey }, "s", function() awful.spawn.with_shell(screenshot) end),
    awful.key({ modkey, "Control", "Shift" }, "q", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "i", function() awful.tag.incnmaster(1, nil, true) end),
    awful.key({ modkey, "Shift" }, "d", function() awful.tag.incnmaster(-1, nil, true) end),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end)
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift" }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end),
    awful.key({ modkey, "Shift" }, "space", awful.client.floating.toggle),
    awful.key({ modkey }, "Return", function(c) c:swap(awful.client.getmaster()) end)
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end)
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }
}

client.connect_signal("manage", function(c)
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "autostart.sh")
