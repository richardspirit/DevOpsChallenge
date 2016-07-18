#create webclient
$wc=New-Object net.webclient

#Get formatted IP address from website
$ip=$wc.downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"
$address = (get-date).ToString() +  " | " + $ip
$address | Set-Content ipaddress.txt
