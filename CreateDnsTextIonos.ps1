param(
    [Parameter(Mandatory = $true)]
    [string]$ZoneName,
    [Parameter(Mandatory = $true)]
    [string]$TextValue
)
    

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("X-API-Key", "<key>")
$headers.Add("Content-Type", "application/json")

$response = Invoke-RestMethod 'https://api.hosting.ionos.com/dns/v1/zones' -Method 'GET' -Headers $headers
$id = ($response | Where-Object { $_.name -eq $ZoneName }).id

# $response = Invoke-RestMethod "https://api.hosting.ionos.com/dns/v1/zones/$id" -Method 'GET' -Headers $headers
$body = @"
[
  {
    "name": "_acme-challenge.$ZoneName",
    "type": "TXT",
    "content": "$TextValue",
    "ttl": 3600,
    "prio": 0,
    "disabled": false
  }
]
"@

$response = Invoke-RestMethod "https://api.hosting.ionos.com/dns/v1/zones/$id/records" -Method 'POST' -Headers $headers -Body $body
# $response | ConvertTo-Json
return $response