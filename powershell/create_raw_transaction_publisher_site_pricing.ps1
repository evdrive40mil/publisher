﻿cd $pwd
1..10 | % { write "" }

echo "Set pricing for backlinks on publisher site page"

$publisher_page_link = Read-Host "enter publisher page link ex(summerblog.ws)"
$publisher_day_price = Read-Host "enter publisher price per day for placing backlink"
$publisher_wallet_address = Read-Host "enter publisher wallet address ex(MJbvkR6oUS1rBh2abf8grm6F9X7yv3Y3Jr)"
$tx_vout = Read-Host "enter transaction id to spend from ex(81a11f6801c661f0e601e13c33caf6c71a86f90a06594bf7680a7b51d04e5527)"
$tx_vout_count = Read-Host "enter spend from transaction id vout number ex(0)"



$data_string = [System.String]::Concat("publisher_page:",$publisher_page_link," ","day_price:",$publisher_day_price," publisher_wallet:",$publisher_wallet_address)
echo $data_string
echo "hex encoded data for transaction"


$char_array = $data_string.ToCharArray();
$hex_data = ""
Foreach ($element in $char_array) 
{
    $hx = [System.String]::Format("{0:x}", [System.Convert]::ToUInt32($element))
    $hex_data+=$hx
    
}

write-host $hex_data
$cmd_a = "`"[{`\`"txid`\`":`\`"$tx_vout`\`",`\`"vout`\`":$tx_vout_count}]`"" 
$cmd_b = "`"[{`\`"$publisher_wallet_address`\`":0.0001}, {`\`"data`\`":`\`"$hex_data`\`"}]`""
write-host $cmd_a
write-host $cmd_b

$raw_tx = (.\litecoin-cli.exe -datadir=dataV212 createrawtransaction  $cmd_a $cmd_b )

write-host "raw transaction " $raw_tx

write-host "sign transcation in wallet using hex output string"
write-host "send signed transcation from wallet using signed hex output string"



