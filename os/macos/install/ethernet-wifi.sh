#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" &&
	. "../../../utils.sh"

declare -r LABEL="dev.emmacampbell.ethernet-wifi"
declare -r PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

# Point launchd at the repo copy directly — launchd doesn't expand `~`,
# and the path has to be absolute.
declare -r AGENT="$(cd ../agents && pwd)/ethernet-wifi.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

write_plist() {
	mkdir -p "$(dirname "$PLIST")"

	cat >"$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>$LABEL</string>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/bash</string>
		<string>$AGENT</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<true/>
	<key>StandardOutPath</key>
	<string>$HOME/Library/Logs/ethernet-wifi.log</string>
	<key>StandardErrorPath</key>
	<string>$HOME/Library/Logs/ethernet-wifi.log</string>
</dict>
</plist>
PLIST
}

load_agent() {
	launchctl bootout "gui/$UID/$LABEL" 2>/dev/null
	launchctl bootstrap "gui/$UID" "$PLIST"
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Ethernet / Wi-Fi Agent\n\n"

write_plist
print_result $? "$PLIST"

load_agent
print_result $? "$LABEL"
