$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("X-Auth-Email", "")
$Headers.Add("X-Auth-Key", "")

$zone=""
$record=""

$record_result = invoke-restmethod -method get -uri "https://api.cloudflare.com/client/v4/zones/$zone/dns_records/$record" -Headers $Headers
$ip = $record_result.result.content

try {
	Get-NetRoute -DestinationPrefix "$ip/32"
	route delete $ip/32
	route -p add $ip mask 255.255.255.255 192.168.1.1
}
catch {
	
}


