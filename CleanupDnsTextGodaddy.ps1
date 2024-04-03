param(
    [Parameter(Mandatory = $true)]
    [string]$ZoneName
)
    
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "sso-key <key>")
$headers.Add("Content-Type", "application/json")

$response = Invoke-RestMethod "https://api.godaddy.com/v1/domains/$ZoneName/records/TXT/_acme-challenge" -Method 'DELETE' -Headers $headers
$response | ConvertTo-Json

