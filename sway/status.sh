# https://unix.stackexchange.com/questions/473788/simple-swaybar-example#473789

# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%a %F %H:%M")

# Get the Linux version but remove the "-1-ARCH" part
# linux_version=$(uname -r | cut -d '-' -f1)

# Returns the battery status: "Full", "Discharging", or "Charging".
# battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Emojis and characters for the status bar
# ↑
# ⚡
# 💎
# 💡
# 💻
# 📁
# 🔋
# 🔌
# 🕚

if [ "$(acpi 2>&1)" != "No support for device type: power_supply" ] ; then
    status=$(acpi | cut -d: -f2 | cut -d, -f1,2 | sed s'/^ //')
    icon='🔋'
    if [ "${status#Charging}" != "$status" ] ; then
        icon='⚡'
    fi
    echo "↑ $uptime_formatted · $icon $status · 🕚 $date_formatted"
else
    echo "↑ $uptime_formatted · 🕚 $date_formatted"
fi
