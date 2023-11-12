killport() {
	local port="$(lsof -i ":$1" | awk 'NR > 1 {print $2}')"
	kill -9 "$port"
}
