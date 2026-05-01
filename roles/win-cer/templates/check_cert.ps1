# Check if wildcard certificate already exists in the store
# Rendered by Ansible template

$ErrorActionPreference = 'Stop'

$Store    = "{{ windows_wildcard_cert_store_path }}"
$Friendly = "{{ windows_wildcard_cert_friendly_name }}"

$cert = Get-ChildItem -Path $Store |
    Where-Object { $_.FriendlyName -eq $Friendly } |
    Sort-Object NotAfter -Descending |
    Select-Object -First 1

if ($cert) {
    @{
        exists     = $true
        thumbprint = $cert.Thumbprint
        subject    = $cert.Subject
        expiry     = $cert.NotAfter.ToString("yyyy-MM-dd")
    } | ConvertTo-Json -Compress
} else {
    @{
        exists     = $false
        thumbprint = $null
        subject    = $null
        expiry     = $null
    } | ConvertTo-Json -Compress
}
