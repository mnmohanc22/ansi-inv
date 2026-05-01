# Validate wildcard certificate exists and is valid after import
# Rendered by Ansible template

$ErrorActionPreference = 'Stop'

$Store    = "{{ windows_wildcard_cert_store_path }}"
$Friendly = "{{ windows_wildcard_cert_friendly_name }}"

$cert = Get-ChildItem -Path $Store |
    Where-Object { $_.FriendlyName -eq $Friendly } |
    Sort-Object NotAfter -Descending |
    Select-Object -First 1

if (-not $cert) {
    throw "Certificate with friendly name '$Friendly' was not found in $Store after import."
}

$now = Get-Date
if ($cert.NotAfter -lt $now) {
    throw "Certificate '$Friendly' exists but is expired (expired: $($cert.NotAfter))."
}

@{
    valid      = $true
    thumbprint = $cert.Thumbprint
    subject    = $cert.Subject
    friendly   = $cert.FriendlyName
    expiry     = $cert.NotAfter.ToString("yyyy-MM-dd")
    days_left  = [int]($cert.NotAfter - $now).TotalDays
} | ConvertTo-Json -Compress
