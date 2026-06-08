# Import a certificate into a Windows certificate store if not already present
# Rendered by Ansible template (apply-cert.yml)

$ErrorActionPreference = 'Stop'

$certPath  = "{{ apply_cert_path }}"
$storePath = "{{ apply_cert_store_path }}"

# Load the certificate to obtain its thumbprint
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2 $certPath
$thumbprint = $cert.Thumbprint

# Check whether it is already present in the target store
$existing = Get-ChildItem -Path $storePath | Where-Object { $_.Thumbprint -eq $thumbprint }

if ($existing) {
    $changed = $false
} else {
    Import-Certificate -FilePath $certPath -CertStoreLocation $storePath | Out-Null
    $changed = $true
}

[PSCustomObject]@{
    changed    = $changed
    thumbprint = $thumbprint
    subject    = $cert.Subject
} | ConvertTo-Json -Compress
