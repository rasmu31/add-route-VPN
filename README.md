Add automatically a route through your gateway to your WAN IP when your VPN starts (or other network connection).
Useful if you're using you VPN connection to reach local services by your WAN IP or external DNS because you could suffer from low speed. In my context, I update my WAN IP every 5 min against Cloudflare DNS API, so in this project I gather my WAN IP from Cloudflare using their API.

Context :
I have a web service on my raspberrypi at home accessible with domain.tld, domain.tld pointing to my WAN IP thanks to Cloudflare.
I handle my DNS records with Cloudflare, I have an A record within Cloudflare which is my WAN IP.

Problem :
When my computer is connected to my VPN, it even uses the VPN connection when I need to contact a home service configured with domain.tld.

Solution :
I use OpenVPN Gui to connect to my VPN provider.
When it connects to the VPN, an event is triggered in eventviewer in System->Microsoft-Windows-NetworkProfile and the EventID is 10000.
EventID 10000 is triggered when any network adapter connects so we need to filter on VPN adapter, we'll do it in Task parameters.

The XML task is available on the repository as add-route-VPN.xml, you'll need to change the network name (mine is ExpressVPN).
Maybe yours is "Unidentified network". If it's the case like it was for me, you can change the VPN network name by editing temporarily firewall settings where you have to uncheck your VPN adapter in protected network connections list for the according profile, at this moment the vpn network wont'be unidentified anymore.
Then, change the network name in secpol.msc and you can re-enable the parameter in firewall settings.
You need to edit the path to the file executing changes to your route table in <command> tag.

The powershell code gathers my WAN IP from Cloudflare DNS API (my WAN IP is itself updated by a cron on my raspberrypi), delete the existing route if it exists and add the route to my WAN IP through my gateway (192.168.1.1).
I also transformed powershell code in an executable with ps2exe with args noConsole noError NoOutput noVisualStyles in order to avoid the console window when the task starts.
For your needs, you can ditch the first 8 lines in powershell code and replace $record_result.result.content by your IP.
