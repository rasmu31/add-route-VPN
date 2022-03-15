$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("X-Auth-Email", "")
$Headers.Add("X-Auth-Key", "")

$zone=""
$record=""

$record_result = invoke-restmethod -method get -uri "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$record" -Headers $Headers
$ip = $record_result.result.content
$gateway = "192.168.1.1"

# If you need to specify the interface, get interface id with netsh interface ipv4 show interfaces 
# $interface = 8
# At the end of route -p add command, add IF $interface

try {
	Get-NetRoute -DestinationPrefix "$ip/32" -ErrorAction Stop
	if ($?) {
		route delete $ip/32
	}
}
catch {
	
}

route -p add $ip mask 255.255.255.255 $gateway
