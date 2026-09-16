#!/bin/bash

# ====================================================
# Script de instalación y configuración de XFCE
# para Void Linux
# Repo: void_linux_xfce_configuration
# ====================================================

echo "=== Iniciando instalación y configuración de XFCE ==="

# ----------------------------------------------------
# Paso 1: Actualizar xbps y repositorios
# ----------------------------------------------------
echo "[Paso 1] Actualizando xbps y repositorios..."
sudo xbps-install -u xbps
if [ $? -ne 0 ]; then
    echo "[Paso 1] Error al actualizar xbps. Abortando."
    exit 1
fi

sudo xbps-install -Syu
if [ $? -ne 0 ]; then
    echo "[Paso 1] Error al sincronizar repositorios. Abortando."
    exit 1
fi
echo "[Paso 1] Repositorios actualizados correctamente."

# ----------------------------------------------------
# Paso 2: Verificar e instalar paquetes
# ----------------------------------------------------
echo "[Paso 2] Verificando paquetes..."

PACKAGES=(chromium htop fastfetch xournalpp okular git github-cli xfce4-screenshooter)

for pkg in "${PACKAGES[@]}"; do
    # CORRECCIÓN: 'xbps-query $pkg' verifica si está instalado correctamente
    if xbps-query "$pkg" >/dev/null 2>&1; then
        echo "[Paso 2] $pkg ya está instalado."
    else
        echo "[Paso 2] $pkg no está instalado. Instalando..."
        # CORRECCIÓN: Se elimina la 'S' para no resincronizar en cada iteración del bucle
        sudo xbps-install -y "$pkg"
        if [ $? -ne 0 ]; then
            echo "[Paso 2] Error durante la instalación de $pkg. Abortando."
            exit 1
        fi
        echo "[Paso 2] $pkg instalado correctamente."
    fi
done

# ----------------------------------------------------
# Paso 3: Verificar directorio de configuración de XFCE
# ----------------------------------------------------
echo "[Paso 3] Verificando $HOME/.config/xfce4/xfconf/xfce-perchannel-xml..."
if [ ! -d "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml" ]; then
    echo "[Paso 3] No existe. Creando..."
    mkdir -p "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml"
else
    echo "[Paso 3] Ya existe."
fi

# ----------------------------------------------------
# Paso 4: Verificar y crear xfce4-keyboard-shortcuts.xml
# ----------------------------------------------------
echo "[Paso 4] Verificando xfce4-keyboard-shortcuts.xml..."

if [ -f "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" ]; then
    echo "[Paso 4] xfce4-keyboard-shortcuts.xml ya existe. No se sobrescribirá."
else
    echo "[Paso 4] No existe. Creando xfce4-keyboard-shortcuts.xml..."
    cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" << 'EOF'
<?xml version="1.1" encoding="UTF-8"?>

<channel name="xfce4-keyboard-shortcuts" version="1.0">
  <property name="commands" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;F1" type="empty"/>
      <property name="&lt;Alt&gt;F2" type="empty">
        <property name="startup-notify" type="empty"/>
      </property>
      <property name="&lt;Alt&gt;F3" type="empty">
        <property name="startup-notify" type="empty"/>
      </property>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Delete" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;l" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;t" type="empty"/>
      <property name="XF86Display" type="empty"/>
      <property name="&lt;Super&gt;p" type="empty"/>
      <property name="&lt;Primary&gt;Escape" type="empty"/>
      <property name="XF86WWW" type="empty"/>
      <property name="HomePage" type="empty"/>
      <property name="XF86Mail" type="empty"/>
      <property name="Print" type="empty"/>
      <property name="&lt;Alt&gt;Print" type="empty"/>
      <property name="&lt;Shift&gt;Print" type="empty"/>
      <property name="&lt;Super&gt;e" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;f" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Escape" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;Escape" type="empty"/>
      <property name="&lt;Super&gt;r" type="empty">
        <property name="startup-notify" type="empty"/>
      </property>
      <property name="&lt;Alt&gt;&lt;Super&gt;s" type="empty"/>
    </property>
    <property name="custom" type="empty">
      <property name="&lt;Alt&gt;F2" type="string" value="xfce4-appfinder --collapsed">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="&lt;Alt&gt;Print" type="string" value="xfce4-screenshooter -w"/>
      <property name="&lt;Super&gt;r" type="string" value="xfce4-appfinder -c">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="XF86WWW" type="string" value="exo-open --launch WebBrowser"/>
      <property name="Print" type="string" value="xfce4-screenshooter"/>
      <property name="&lt;Shift&gt;Print" type="string" value="xfce4-screenshooter -r"/>
      <property name="&lt;Alt&gt;&lt;Super&gt;s" type="string" value="orca"/>
      <property name="&lt;Alt&gt;F1" type="string" value="xfce4-popup-applicationsmenu"/>
      <property name="&lt;Super&gt;p" type="string" value="xfce4-display-settings --minimal"/>
      <property name="HomePage" type="string" value="exo-open --launch WebBrowser"/>
      <property name="XF86Display" type="string" value="xfce4-display-settings --minimal"/>
      <property name="override" type="bool" value="true"/>
      <property name="&lt;Primary&gt;e" type="string" value="thunar"/>
      <property name="&lt;Primary&gt;d" type="string" value="xfce4-appfinder">
        <property name="startup-notify" type="bool" value="true"/>
      </property>
      <property name="&lt;Primary&gt;Return" type="string" value="exo-open --launch TerminalEmulator"/>
    </property>
  </property>
  <property name="xfwm4" type="empty">
    <property name="default" type="empty">
      <property name="&lt;Alt&gt;Insert" type="empty"/>
      <property name="Escape" type="empty"/>
      <property name="Left" type="empty"/>
      <property name="Right" type="empty"/>
      <property name="Up" type="empty"/>
      <property name="Down" type="empty"/>
      <property name="&lt;Alt&gt;Tab" type="empty"/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="empty"/>
      <property name="&lt;Alt&gt;Delete" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Down" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Left" type="empty"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Down" type="empty"/>
      <property name="&lt;Alt&gt;F4" type="empty"/>
      <property name="&lt;Alt&gt;F6" type="empty"/>
      <property name="&lt;Alt&gt;F7" type="empty"/>
      <property name="&lt;Alt&gt;F8" type="empty"/>
      <property name="&lt;Alt&gt;F9" type="empty"/>
      <property name="&lt;Alt&gt;F10" type="empty"/>
      <property name="&lt;Alt&gt;F11" type="empty"/>
      <property name="&lt;Alt&gt;F12" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Left" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;End" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Home" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Right" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Up" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_1" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_2" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_3" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_4" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_5" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_6" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_7" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_8" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_9" type="empty"/>
      <property name="&lt;Alt&gt;space" type="empty"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Up" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Right" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;d" type="empty"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;Up" type="empty"/>
      <property name="&lt;Super&gt;Tab" type="empty"/>
      <property name="&lt;Primary&gt;F1" type="empty"/>
      <property name="&lt;Primary&gt;F2" type="empty"/>
      <property name="&lt;Primary&gt;F3" type="empty"/>
      <property name="&lt;Primary&gt;F4" type="empty"/>
      <property name="&lt;Primary&gt;F5" type="empty"/>
      <property name="&lt;Primary&gt;F6" type="empty"/>
      <property name="&lt;Primary&gt;F7" type="empty"/>
      <property name="&lt;Primary&gt;F8" type="empty"/>
      <property name="&lt;Primary&gt;F9" type="empty"/>
      <property name="&lt;Primary&gt;F10" type="empty"/>
      <property name="&lt;Primary&gt;F11" type="empty"/>
      <property name="&lt;Primary&gt;F12" type="empty"/>
      <property name="&lt;Super&gt;KP_Left" type="empty"/>
      <property name="&lt;Super&gt;KP_Right" type="empty"/>
      <property name="&lt;Super&gt;KP_Down" type="empty"/>
      <property name="&lt;Super&gt;KP_Up" type="empty"/>
      <property name="&lt;Super&gt;KP_Page_Up" type="empty"/>
      <property name="&lt;Super&gt;KP_Home" type="empty"/>
      <property name="&lt;Super&gt;KP_End" type="empty"/>
      <property name="&lt;Super&gt;KP_Next" type="empty"/>
    </property>
    <property name="custom" type="empty">
      <property name="&lt;Super&gt;KP_Down" type="string" value="tile_down_key"/>
      <property name="&lt;Primary&gt;F6" type="string" value="workspace_6_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_9" type="string" value="move_window_workspace_9_key"/>
      <property name="&lt;Super&gt;KP_Up" type="string" value="tile_up_key"/>
      <property name="&lt;Primary&gt;F8" type="string" value="workspace_8_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Left" type="string" value="move_window_left_key"/>
      <property name="Right" type="string" value="right_key"/>
      <property name="Down" type="string" value="down_key"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Down" type="string" value="lower_window_key"/>
      <property name="&lt;Primary&gt;F9" type="string" value="workspace_9_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Right" type="string" value="move_window_right_key"/>
      <property name="&lt;Alt&gt;F6" type="string" value="stick_window_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_5" type="string" value="move_window_workspace_5_key"/>
      <property name="&lt;Alt&gt;Delete" type="string" value="del_workspace_key"/>
      <property name="&lt;Super&gt;Tab" type="string" value="switch_window_key"/>
      <property name="&lt;Super&gt;KP_Page_Up" type="string" value="tile_up_right_key"/>
      <property name="&lt;Alt&gt;F7" type="string" value="move_window_key"/>
      <property name="Up" type="string" value="up_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_6" type="string" value="move_window_workspace_6_key"/>
      <property name="&lt;Alt&gt;F11" type="string" value="fullscreen_key"/>
      <property name="&lt;Alt&gt;space" type="string" value="popup_menu_key"/>
      <property name="&lt;Super&gt;KP_Home" type="string" value="tile_up_left_key"/>
      <property name="Escape" type="string" value="cancel_key"/>
      <property name="&lt;Super&gt;KP_Next" type="string" value="tile_down_right_key"/>
      <property name="&lt;Shift&gt;&lt;Alt&gt;Page_Up" type="string" value="raise_window_key"/>
      <property name="&lt;Alt&gt;&lt;Shift&gt;Tab" type="string" value="cycle_reverse_windows_key"/>
      <property name="&lt;Alt&gt;F12" type="string" value="above_key"/>
      <property name="&lt;Primary&gt;&lt;Shift&gt;&lt;Alt&gt;Up" type="string" value="move_window_up_key"/>
      <property name="&lt;Primary&gt;F5" type="string" value="workspace_5_key"/>
      <property name="&lt;Alt&gt;F8" type="string" value="resize_window_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_7" type="string" value="move_window_workspace_7_key"/>
      <property name="&lt;Super&gt;KP_End" type="string" value="tile_down_left_key"/>
      <property name="&lt;Alt&gt;F9" type="string" value="hide_window_key"/>
      <property name="&lt;Primary&gt;F7" type="string" value="workspace_7_key"/>
      <property name="Left" type="string" value="left_key"/>
      <property name="&lt;Primary&gt;&lt;Alt&gt;KP_8" type="string" value="move_window_workspace_8_key"/>
      <property name="&lt;Alt&gt;Insert" type="string" value="add_workspace_key"/>
      <property name="override" type="bool" value="true"/>
      <property name="&lt;Primary&gt;Up" type="string" value="maximize_window_key"/>
      <property name="&lt;Primary&gt;Tab" type="string" value="cycle_windows_key"/>
      <property name="&lt;Primary&gt;Left" type="string" value="tile_left_key"/>
      <property name="&lt;Primary&gt;Right" type="string" value="tile_right_key"/>
      <property name="&lt;Primary&gt;q" type="string" value="close_window_key"/>
      <property name="&lt;Alt&gt;1" type="string" value="move_window_workspace_1_key"/>
      <property name="&lt;Alt&gt;2" type="string" value="move_window_workspace_2_key"/>
      <property name="&lt;Alt&gt;3" type="string" value="move_window_workspace_3_key"/>
      <property name="&lt;Alt&gt;4" type="string" value="move_window_workspace_4_key"/>
      <property name="&lt;Primary&gt;1" type="string" value="workspace_1_key"/>
      <property name="&lt;Primary&gt;2" type="string" value="workspace_2_key"/>
      <property name="&lt;Primary&gt;3" type="string" value="workspace_3_key"/>
      <property name="&lt;Primary&gt;4" type="string" value="workspace_4_key"/>
    </property>
  </property>
  <property name="providers" type="array">
    <value type="string" value="xfwm4"/>
    <value type="string" value="commands"/>
  </property>
</channel>
EOF

    echo "[Paso 4] xfce4-keyboard-shortcuts.xml creado correctamente."
fi

# ----------------------------------------------------
# Paso 5: Verificar y crear xfwm4.xml
# ----------------------------------------------------
echo "[Paso 5] Verificando xfwm4.xml..."

if [ -f "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml" ]; then
    echo "[Paso 5] xfwm4.xml ya existe. No se sobrescribirá."
else
    echo "[Paso 5] No existe. Creando xfwm4.xml..."
    cat > "$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml" << 'EOF'
<?xml version="1.1" encoding="UTF-8"?>

<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="activate_action" type="string" value="bring"/>
    <property name="borderless_maximize" type="bool" value="true"/>
    <property name="box_move" type="bool" value="false"/>
    <property name="box_resize" type="bool" value="false"/>
    <property name="button_layout" type="string" value="O|SHMC"/>
    <property name="button_offset" type="int" value="0"/>
    <property name="button_spacing" type="int" value="0"/>
    <property name="click_to_focus" type="bool" value="true"/>
    <property name="cycle_apps_only" type="bool" value="false"/>
    <property name="cycle_draw_frame" type="bool" value="true"/>
    <property name="cycle_raise" type="bool" value="false"/>
    <property name="cycle_hidden" type="bool" value="true"/>
    <property name="cycle_minimum" type="bool" value="true"/>
    <property name="cycle_minimized" type="bool" value="false"/>
    <property name="cycle_preview" type="bool" value="true"/>
    <property name="cycle_tabwin_mode" type="int" value="0"/>
    <property name="cycle_workspaces" type="bool" value="false"/>
    <property name="double_click_action" type="string" value="maximize"/>
    <property name="double_click_distance" type="int" value="5"/>
    <property name="double_click_time" type="int" value="250"/>
    <property name="easy_click" type="string" value="Alt"/>
    <property name="focus_delay" type="int" value="250"/>
    <property name="focus_hint" type="bool" value="true"/>
    <property name="focus_new" type="bool" value="true"/>
    <property name="frame_opacity" type="int" value="100"/>
    <property name="frame_border_top" type="int" value="0"/>
    <property name="full_width_title" type="bool" value="true"/>
    <property name="horiz_scroll_opacity" type="bool" value="false"/>
    <property name="inactive_opacity" type="int" value="100"/>
    <property name="maximized_offset" type="int" value="0"/>
    <property name="mousewheel_rollup" type="bool" value="true"/>
    <property name="move_opacity" type="int" value="100"/>
    <property name="placement_mode" type="string" value="center"/>
    <property name="placement_ratio" type="int" value="20"/>
    <property name="popup_opacity" type="int" value="100"/>
    <property name="prevent_focus_stealing" type="bool" value="false"/>
    <property name="raise_delay" type="int" value="250"/>
    <property name="raise_on_click" type="bool" value="true"/>
    <property name="raise_on_focus" type="bool" value="false"/>
    <property name="raise_with_any_button" type="bool" value="true"/>
    <property name="repeat_urgent_blink" type="bool" value="false"/>
    <property name="resize_opacity" type="int" value="100"/>
    <property name="scroll_workspaces" type="bool" value="true"/>
    <property name="shadow_delta_height" type="int" value="0"/>
    <property name="shadow_delta_width" type="int" value="0"/>
    <property name="shadow_delta_x" type="int" value="0"/>
    <property name="shadow_delta_y" type="int" value="-3"/>
    <property name="shadow_opacity" type="int" value="50"/>
    <property name="show_app_icon" type="bool" value="false"/>
    <property name="show_dock_shadow" type="bool" value="true"/>
    <property name="show_frame_shadow" type="bool" value="true"/>
    <property name="show_popup_shadow" type="bool" value="false"/>
    <property name="snap_resist" type="bool" value="false"/>
    <property name="snap_to_border" type="bool" value="true"/>
    <property name="snap_to_windows" type="bool" value="false"/>
    <property name="snap_width" type="int" value="10"/>
    <property name="vblank_mode" type="string" value="auto"/>
    <property name="theme" type="string" value="Default"/>
    <property name="tile_on_move" type="bool" value="true"/>
    <property name="title_alignment" type="string" value="center"/>
    <property name="title_font" type="string" value="Sans Bold 9"/>
    <property name="title_horizontal_offset" type="int" value="0"/>
    <property name="titleless_maximize" type="bool" value="false"/>
    <property name="title_shadow_active" type="string" value="false"/>
    <property name="title_shadow_inactive" type="string" value="false"/>
    <property name="title_vertical_offset_active" type="int" value="0"/>
    <property name="title_vertical_offset_inactive" type="int" value="0"/>
    <property name="toggle_workspaces" type="bool" value="false"/>
    <property name="unredirect_overlays" type="bool" value="true"/>
    <property name="urgent_blink" type="bool" value="false"/>
    <property name="use_compositing" type="bool" value="true"/>
    <property name="workspace_count" type="int" value="4"/>
    <property name="wrap_cycle" type="bool" value="true"/>
    <property name="wrap_layout" type="bool" value="true"/>
    <property name="wrap_resistance" type="int" value="10"/>
    <property name="wrap_windows" type="bool" value="true"/>
    <property name="wrap_workspaces" type="bool" value="false"/>
    <property name="zoom_desktop" type="bool" value="true"/>
    <property name="zoom_pointer" type="bool" value="true"/>
    <property name="workspace_names" type="array">
      <value type="string" value="Área de trabajo 1"/>
      <value type="string" value="Área de trabajo 2"/>
      <value type="string" value="Área de trabajo 3"/>
      <value type="string" value="Área de trabajo 4"/>
    </property>
  </property>
</channel>
EOF

    echo "[Paso 5] xfwm4.xml creado correctamente."
fi

# ----------------------------------------------------
# Finalización
# ----------------------------------------------------
echo "=== Instalación y configuración de XFCE completada ==="
echo ""
echo "IMPORTANTE: Para que los atajos surtan efecto, reinicia la sesión o ejecuta 'xfce4-panel -r' y 'xfwm4 --replace'."
echo ""
