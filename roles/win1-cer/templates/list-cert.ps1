# List all certificates from a Windows certificate store
# Rendered by Ansible template (list_certificates.yml)

$ErrorActionPreference = 'Stop'

$storePath = "{{ list_cert_store_path }}"

$certs = Get-ChildItem -Path $storePath |
    Select-Object -Property FriendlyName, Subject, Thumbprint,
        @{ Name = 'Expiry'; Expression = { $_.NotAfter.ToString('yyyy-MM-dd') } },
        @{ Name = 'Issuer'; Expression = { $_.Issuer } }

if ($null -eq $certs) {
    '[]'
} else {
    $certs | ConvertTo-Json -Compress
}
