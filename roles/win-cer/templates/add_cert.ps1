# Import wildcard certificate PFX and optional chain certificates
# Rendered by Ansible template

$ErrorActionPreference = 'Stop'

$PfxPath    = "{{ windows_wildcard_cert_pfx_dest }}"
$Store      = "{{ windows_wildcard_cert_store_path }}"
$Friendly   = "{{ windows_wildcard_cert_friendly_name }}"
$Exportable = {{ ' $true' if windows_wildcard_cert_exportable else ' $false' }}
$Password   = "{{ windows_wildcard_cert_pfx_password }}"

if (-not (Test-Path -Path $PfxPath)) {
    throw "PFX file not found: $PfxPath"
}

# Import PFX
$securePwd = ConvertTo-SecureString $Password -AsPlainText -Force
$imported = Import-PfxCertificate `
    -FilePath $PfxPath `
    -Password $securePwd `
    -CertStoreLocation $Store `
    -Exportable:$Exportable

if (-not $imported) { throw "PFX import failed" }

$thumb = $imported.Thumbprint

# Set friendly name if not already correct
$cert = Get-ChildItem -Path $Store | Where-Object { $_.Thumbprint -eq $thumb } | Select-Object -First 1
if ($cert -and $cert.FriendlyName -ne $Friendly) {
    $cert.FriendlyName = $Friendly
}

# Import intermediate/root chain certificates (if provided)
{% if windows_wildcard_cert_intermediate_certs is defined and windows_wildcard_cert_intermediate_certs | length > 0 %}
{% for item in windows_wildcard_cert_intermediate_certs %}
$chainPath  = "{{ windows_wildcard_cert_temp_dir }}\\{{ item.src | basename }}"
$chainStore = "Cert:\\LocalMachine\\{{ item.store_name }}"
if (Test-Path -Path $chainPath) {
    $incoming = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
    $incoming.Import($chainPath)
    $already = Get-ChildItem -Path $chainStore | Where-Object { $_.Thumbprint -eq $incoming.Thumbprint }
    if (-not $already) {
        Import-Certificate -FilePath $chainPath -CertStoreLocation $chainStore | Out-Null
    }
}
{% endfor %}
{% endif %}

@{ thumbprint = $thumb; changed = $true } | ConvertTo-Json -Compress
