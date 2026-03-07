#!/bin/bash
# Register custom keyboard shortcuts in KDE Plasma
if [ "$(uname)" = "Darwin" ] || ! command -v kwriteconfig6 &> /dev/null; then
    echo "Skipping KDE shortcuts (not a KDE environment)"
    exit 0
fi
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "net.local.launcher.sh-2.desktop" --key "_launch" "Shift+Space"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "net.local.ghostty.desktop" --key "_launch" "Ctrl+Alt+Space"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "net.local.obsidian.desktop" --key "_launch" "Ctrl+Alt+O"
kwriteconfig6 --file kglobalshortcutsrc --group "services" --group "net.local.spotify.desktop" --key "_launch" "Ctrl+Alt+S"
