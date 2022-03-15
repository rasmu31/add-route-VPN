Add automatically a route through your local interface to your WAN IP when tour VPN starts. Useful if you're using you VPN connection to reach local services by your WAN IP or external DNS because you could suffer from low speed.

Context :
I have a web service on my raspberrypi at home accessible with domain.tld, domain.tld pointing to my WAN IP.
I handle my DNS records with Cloudflare.
I use OpenVPNGui to connect to my VPN provider, when it connects to VPN an event is triggered in eventviewer in System->Microsoft-Windows-NetworkProfile and the EventID is 10000.
EventID 10000 is triggered when any network adapter connects so we need to filter on VPN adapter, we'll do it in Task parameters.

The XML task is available on the repository as add-route-VPN-task.xml, you'll need to change the network name.
My network name is "ExpressVPN", maybe yours is "Unidentified network". If it's the case like it was for me, you can change the VPN network name by editing temporarily Firewall settings where you have to uncheck your VPN adapter in protected network connections list for the according profile and changing the network name in secpol.msc

The powershell code gathers my WAN IP from Cloudflare DNS API (my WAN IP is itself gathered by a cron on my raspberrypi), check if the route exists and add the route to my WAN IP through my local interface (192.168.1.1), then finally write WAN IP 
I also transformed powershell code in an executable with ps2exe with args noConsole noError NoOutput noVisualStyles in order to avoid the console window when the task starts.

