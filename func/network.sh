killport() {
	local port="$(lsof -i :3000 | awk 'NR > 1 {print $2}')"
	kill -9 "$port"
}
