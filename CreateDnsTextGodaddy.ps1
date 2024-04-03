param(
    [Parameter(Mandatory = $true)]
    [string]$ZoneName,
    [Parameter(Mandatory = $true)]
    [string]$TextValue
)
    

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "sso-key <key>")
$headers.Add("Content-Type", "application/json")

$body = @"
[
  {
    "data": "$TextValue",
    "ttl": 3600
  }
]
"@

$response = Invoke-RestMethod "https://api.godaddy.com/v1/domains/$ZoneName/records/TXT/_acme-challenge" -Method 'PUT' -Headers $headers -Body $body
# $response | ConvertTo-Json
return $response