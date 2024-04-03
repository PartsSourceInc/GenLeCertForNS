param(
    [Parameter(Mandatory = $true)]
    [string]$ZoneName
)
    

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("X-API-Key", "<key>")
$headers.Add("Content-Type", "application/json")

$response = Invoke-RestMethod 'https://api.hosting.ionos.com/dns/v1/zones' -Method 'GET' -Headers $headers
$id = ($response | Where-Object { $_.name -eq $ZoneName }).id

$response2 = Invoke-RestMethod "https://api.hosting.ionos.com/dns/v1/zones/$id" -Method 'GET' -Headers $headers

foreach ($recordId in ($response2.records | Where-Object { $_.name -eq "_acme-challenge.$ZoneName" }).id) {
    $response3 = Invoke-RestMethod "https://api.hosting.ionos.com/dns/v1/zones/$id/records/$recordId" -Method 'DELETE' -Headers $headers
    $response3 | ConvertTo-Json
}
