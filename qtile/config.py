# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import hook
import os
import  subprocess
import re

from libqtile.widget import base



mod = "mod4"
terminal = "kitty" 
color_barra = "#282a36"
tamano_barra = 30
letra = "Ubuntu Mono Nerd Font"
tamano_fuente=16
color_icono_activo="#f1fa8c"
tamano_icon = 10
fg_color = "#fff"
color_inactivo = "#6272a4"
color_oscuro = "#44475a"
color_claro = "#bd93f9"
color_urgent = "#ff5555"
color_texto1 = "#bd93f9"
color_bg = ["#282a36"]
mymargin = 5  # ajusta el valor según sea necesario
tamano_iconos = 20
grupo_1 = "#ff7f00"
grupo_2 = "#bb33ff"
grupo_3 = "#007bff"
grupo_4 = "#f30202"
grupo_5 = "#ff00f0"
opacidad = 1



def separador():
    return widget.Sep(
        linewidth = 0,
        padding = 25,
        foreground = fg_color,
        background = color_bg,
    )

def estilo (vColor, tipo):

    if tipo == 0:
        text = ""
        tamano_estilo = 52
        separacion = 0
    elif tipo == 1:
        text = ""
        tamano_estilo = 40
        separacion = -3
    elif tipo == 2:
        text = "  "
        tamano_estilo = 50
        separacion = -10
    elif tipo == 3:
        text = "󱎕"
        tamano_estilo = 45
        separacion = -2  
    elif tipo == 4:
        text = ""
        tamano_estilo = 45
        separacion = -2  

    return  widget.TextBox(
            text = text,
            fontsize = tamano_estilo,
            foreground = vColor,
            background = color_bg,
            padding = separacion,
        )

def fc_icono(icono, color_grupo):
    return widget.TextBox(
        text = icono,
        foreground = fg_color,
        background = color_grupo,
        fontsize = tamano_iconos,
    )

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "Left", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "Right", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("kitty"), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "m", lazy.spawn("rofi -show drun"), desc="Abrir Rofi"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),

    #volumen
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
    #Brillo
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),


    Key([mod], "p", lazy.spawn("/home/gladoncio/.config/qtile/pantalla.sh")),
    Key([mod], "n", lazy.spawn("nm-connection-editor")),

    
]

icono_comun = "  "  # Cambia esto al ícono que desees usar para todos los grupos

groups = [Group(str(i+1), label=icono_comun) for i in range(9)]

for i, group in enumerate(groups):
    numeroEscritorio = str(i+1)
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key([mod], numeroEscritorio, lazy.group[group.name].toscreen(), desc="Switch to group {}".format(group.name)),
            # mod1 + shift +  letter of group = switch to & move focused window to group
            Key([mod, "shift"], numeroEscritorio, lazy.window.togroup(group.name, switch_group=True), desc="Switch to & move focused window to group {}".format(group.name)),
        ]
    )


layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=2,num_stacks=1,margin=5),
    layout.Max(margin=15),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

class CapsNumLockIndicator(base.ThreadPoolText):
    """Really simple widget to show the current Caps/Num Lock state."""

    defaults = [("update_interval", 0.5, "Update Time in seconds.")]

    def __init__(self, **config):
        base.ThreadPoolText.__init__(self, "", **config)
        self.add_defaults(CapsNumLockIndicator.defaults)

    def get_indicators(self):
        """Return a list with the current state of the keys."""
        try:
            output = self.call_process(["xset", "q"])
        except subprocess.CalledProcessError as err:
            output = err.output
            return []
        if output.startswith("Keyboard"):
            indicators = re.findall(r"(Caps|Num)\s+Lock:\s*(\w*)", output)
            return indicators
        
    def poll(self):
        """Poll content for the text box."""
        indicators = self.get_indicators()

        # Personaliza el texto según el estado de las teclas Caps Lock y Num Lock
        caps_lock_on = any(indicator[0] == "Caps" and indicator[1] == "on" for indicator in indicators)
        num_lock_on = any(indicator[0] == "Num" and indicator[1] == "on" for indicator in indicators)

        if caps_lock_on and num_lock_on:
            return "󰪛  ON 󰎧  ON"
        elif caps_lock_on:
            return "󰪛  ON 󰎧  OFF"
        elif num_lock_on:
            return "󰪛  OFF 󰎧  ON"
        else:
            return "󰪛  OFF 󰎧  OFF"

    

widget_defaults = dict(
    font=letra,
    fontsize=tamano_fuente,
    padding=1,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                separador(),

                estilo(grupo_1,3),
                fc_icono("󰔏",grupo_1),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 0",
                    fmt = 'T1: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 1",
                    fmt = ' T2: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 2",
                    fmt = ' T3: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 3",
                    fmt = ' T4: {}',
                ),
                fc_icono(" 󰍛 ",grupo_1),
                widget.Memory(
                    foreground = fg_color,
                    background = grupo_1,
                ),

                estilo(grupo_1,4),
                

                widget.Spacer(length=bar.STRETCH),  # Ajuste dinámico a la izquierda
                widget.GroupBox(
                    active=color_icono_activo,
                    center_aligned=True,
                    border_width=1,
                    disable_drag=True,
                    fontsize=tamano_icon,
                    foreground=fg_color,
                    highlight_method="block",
                    inactive=color_inactivo,
                    margin_x=0,
                    margin_y=5,
                    other_current_screen_border=color_oscuro,
                    other_screen_border=color_oscuro,
                    padding_x=5,  # Ajusta este valor según sea necesario para centrar visualmente el ícono
                    padding_y=10,  # Ajusta este valor según sea necesario para centrar visualmente el ícono
                    this_current_screen_border=color_claro,
                    this_screen_border=color_claro,
                    urgent_alert_method='block',
                    urgent_border=color_urgent,
                ),
                widget.Spacer(length=bar.STRETCH),
                
                #temperaturas


                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Systray(
                    icon_size = tamano_iconos,
                    background = color_bg
                    ),
                separador(),

                estilo(grupo_5,0),
                CapsNumLockIndicator(
                    foreground = fg_color,
                    background = grupo_5,
                ),
                estilo(grupo_5,1),

                estilo(grupo_2,0),
                widget.Clock(format="  %Y-%m-%d %a %I:%M %p",
                             background = grupo_2,
                             foreground = fg_color,
                             ),
                estilo(grupo_2,1),
                            

                estilo(grupo_3,0),
                widget.QuickExit(
                    foreground = fg_color,
                    background = grupo_3,
                ),
                estilo(grupo_3,1),

                estilo(grupo_4,0),
                widget.CurrentLayout(
                    foreground = fg_color,
                    background = grupo_4,
                ),
                estilo(grupo_4,1),
            ],
            tamano_barra,
            background=color_barra,
            opacity=opacidad,  # Ajusta la opacidad según tus preferencias
            
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),




    Screen(
        top=bar.Bar(
            [
                separador(),

                estilo(grupo_1,3),
                fc_icono("󰔏",grupo_1),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 0",
                    fmt = 'T1: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 1",
                    fmt = ' T2: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 2",
                    fmt = ' T3: {}',
                ),
                widget.ThermalSensor(
                    foreground = fg_color,
                    background = grupo_1,
                    threshold = 50,
                    tag_sensor = "Core 3",
                    fmt = ' T4: {}',
                ),
                fc_icono(" 󰍛 ",grupo_1),
                widget.Memory(
                    foreground = fg_color,
                    background = grupo_1,
                ),
                estilo(grupo_1,4),

                widget.Spacer(length=bar.STRETCH),  # Ajuste dinámico a la izquierda
                widget.GroupBox(
                    active=color_icono_activo,
                    center_aligned=True,
                    border_width=1,
                    disable_drag=True,
                    fontsize=tamano_icon,
                    foreground=fg_color,
                    highlight_method="block",
                    inactive=color_inactivo,
                    margin_x=0,
                    margin_y=5,
                    other_current_screen_border=color_oscuro,
                    other_screen_border=color_oscuro,
                    padding_x=5,  # Ajusta este valor según sea necesario para centrar visualmente el ícono
                    padding_y=10,  # Ajusta este valor según sea necesario para centrar visualmente el ícono
                    this_current_screen_border=color_claro,
                    this_screen_border=color_claro,
                    urgent_alert_method='block',
                    urgent_border=color_urgent,
                ),
                widget.Spacer(length=bar.STRETCH),

                estilo(grupo_2,0),
                widget.Clock(format="  %Y-%m-%d %a %I:%M %p",
                             background = grupo_2,
                             foreground = fg_color,
                             ),
                estilo(grupo_2,1),

                estilo(grupo_3,0),
                widget.QuickExit(
                    foreground = fg_color,
                    background = grupo_3,
                ),
                estilo(grupo_3,1),
                estilo(grupo_4,0),
                widget.CurrentLayout(
                    foreground = fg_color,
                    background = grupo_4,
                ),
                estilo(grupo_4,1),
            ],
            tamano_barra,
            background=color_barra,
            opacity= opacidad, 

        ),
    ),


]



# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/inicio.sh')
    subprocess.Popen([home])

