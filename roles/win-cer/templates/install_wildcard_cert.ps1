# Install wildcard certificate and optional chain
# Rendered by Ansible template

$ErrorActionPreference = 'Stop'

$TempDir    = "{{ windows_wildcard_cert_temp_dir }}"
$PfxPath    = "{{ windows_wildcard_cert_pfx_dest }}"
$Store      = "{{ windows_wildcard_cert_store_path }}"
$Friendly   = "{{ windows_wildcard_cert_friendly_name }}"
$Exportable = {{ ' $true' if windows_wildcard_cert_exportable else ' $false' }}
$Password   = "{{ windows_wildcard_cert_pfx_password }}"

function JsonOut($obj) {
    $obj | ConvertTo-Json -Compress
}

# Check existing by friendly name or subject
$existing = Get-ChildItem -Path $Store | Where-Object { $_.FriendlyName -eq $Friendly } | Sort-Object NotAfter -Descending | Select-Object -First 1
if ($existing) {
    $out = @{ thumbprint = $existing.Thumbprint; changed = $false }
    Write-Output (JsonOut $out)
    exit 0
}

# Import PFX
if (-not (Test-Path -Path $PfxPath)) {
    throw "PFX file not found: $PfxPath"
}

$securePwd = ConvertTo-SecureString $Password -AsPlainText -Force
$imported = Import-PfxCertificate -FilePath $PfxPath -Password $securePwd -CertStoreLocation $Store -Exportable:$Exportable
if (-not $imported) { throw "PFX import failed" }

$thumb = $imported.Thumbprint

# Set friendly name if needed
$cert = Get-ChildItem -Path $Store | Where-Object { $_.Thumbprint -eq $thumb } | Select-Object -First 1
if ($cert -and $cert.FriendlyName -ne $Friendly) {
    $cert.FriendlyName = $Friendly
}

# Import intermediate/root certificates (if provided)
{% if windows_wildcard_cert_intermediate_certs is defined and windows_wildcard_cert_intermediate_certs | length > 0 %}
{% for item in windows_wildcard_cert_intermediate_certs %}
$chainPath = "{{ windows_wildcard_cert_temp_dir }}\\{{ item.src | basename }}"
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

# Final verify
$final = Get-ChildItem -Path $Store | Where-Object { $_.Thumbprint -eq $thumb } | Select-Object -First 1
if (-not $final) { throw "Certificate not found after import" }

$out = @{ thumbprint = $thumb; changed = $true }
Write-Output (JsonOut $out)
