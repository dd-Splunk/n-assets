# N Assets

## Installation

To install, click on the **Releases** / "latest" tag on the right side of this screen.

Download the [n-asset.spl](https://github.com/dd-Splunk/n-assets/releases/download/latest/n-assets.spl) file located under the **Assets** paragraph to your local filesystem.

From the Splunk GUI, select Apps -> Manage Apps -> Install from file and select the n-asset.spl file just downloaded.

From the Splunk GUI, select Settings -> Data Inpputs -> SA-Eventgen -> Enable to start the Event generator

Restart Splunk to make changes effectives.

That's it.

## Create Assets

Use the folowing spl statement

```SPL
| inputlookup n_assets.csv | iplocation IPAddress
| rename Department AS bunit, IPAddress AS ip, Location AS country, FQDN AS dns
| rename isManaged AS is_expected, lon AS long, Mac AS mac, Username AS owner
| eval nt_host = lower(AssetID)
| eval priority = "medium"
| eval should_timesync = "Y"
| eval should_update = "Y"
| fields ip,mac,nt_host,dns,owner,priority,lat,long,city,country,bunit,category,pci_domain,is_expected,should_timesync,should_update,requires_av,cim_entity_zone
```
