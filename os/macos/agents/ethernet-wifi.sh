#!/bin/bash
#
# ethernet-wifi.sh
# ---
# turn Wi-Fi off while ethernet is connected, and back on when it isn't.
#
# runs under launchd (see os/macos/install/ethernet-wifi.sh). Only acts when
# ethernet comes or goes, so Wi-Fi can still be switched on by hand while
# plugged in.

# Plugging in a dock or waking from sleep produces a burst of network
# events, so wait for them to go quiet before checking.
declare -r SETTLE_SECONDS=3

declare -r WIFI_DEVICE="$(networksetup -listallhardwareports |
	awk '/^Hardware Port: Wi-Fi/ { getline; print $2 }')"

wifiState=""

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# "Ethernet Adapter (enN)" ports are virtual, not real ethernet.

ethernet_devices() {
	networksetup -listallhardwareports | awk '
		/^Hardware Port:/ { wired = /Ethernet|LAN/ && !/Ethernet Adapter/ }
		/^Device:/ && wired { print $2 }
	'
}

# A link alone isn't enough: a cable into a dead network gets a
# self-assigned 169.254 address, and we'd want to keep Wi-Fi for that.

ethernet_connected() {
	local device=""
	local address=""

	for device in $(ethernet_devices); do
		address="$(ipconfig getifaddr "$device")"

		if [ -n "$address" ] && [[ "$address" != 169.254.* ]]; then
			return 0
		fi
	done

	return 1
}

sync_wifi() {
	local desired="on"

	if ethernet_connected; then
		desired="off"
	fi

	if [ "$desired" != "$wifiState" ]; then
		networksetup -setairportpower "$WIFI_DEVICE" "$desired" &&
			wifiState="$desired" &&
			printf "%s wifi %s\n" "$(date '+%F %T')" "$desired"
	fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
	sync_wifi

	while read -r _; do
		while read -r -t "$SETTLE_SECONDS" _; do :; done
		sync_wifi
	done < <(route -n monitor | grep --line-buffered -E '^RTM_(IFINFO|NEWADDR|DELADDR)')
}

main
