#!/usr/bin/env python3

import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

player = Playerctl.Player('vlc')
print(player)
