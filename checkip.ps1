
$wc=New-Object net.webclient

$ip=$wc.downloadstring("http://checkip.dyndns.com") -replace "[^\d\.]"
$address = (get-date).ToString() +  " | " + $ip
$address | Set-Content ipaddress.txt
