$ErrorActionPreference = "Stop"

# ── Read parameters directly ──────────────────────────────────
$ApplicationName        = "{{ com_app_name }}"
$Description            = "{{ com_app_description | default('') }}"
$IdentityMode           = "{{ com_app_identity_mode | default('this_user') }}"
$Username               = "{{ com_app_username | default('') }}"
$Password               = "{{ com_app_password | default('') }}"
$EnableAppAccessChecks  = [bool]::Parse("{{ com_app_access_checks | default('true') }}")
$AccessChecksLevel      = [int]"{{ com_app_access_checks_level | default('0') }}"

function Get-CollectionItemByName {
    param(
        [Parameter(Mandatory = $true)] $Collection,
        [Parameter(Mandatory = $true)] [string]$Name,
        [string[]]$PropertyNames = @("Name")
    )

    for ($i = 0; $i -lt $Collection.Count; $i++) {
        $item = $Collection.Item($i)
        foreach ($prop in $PropertyNames) {
            try {
                $value = $item.Value($prop)
                if ($null -ne $value -and [string]$value -eq $Name) {
                    return $item
                }
            } catch {
            }
        }
    }
    return $null
}

$changed = $false
$catalog = New-Object -ComObject COMAdmin.COMAdminCatalog
$apps = $catalog.GetCollection("Applications")
$apps.Populate()

$app = Get-CollectionItemByName -Collection $apps -Name $ApplicationName -PropertyNames @("Name")

if (-not $app) {
    $app = $apps.Add()
    $app.Value("Name") = $ApplicationName
    $app.Value("Description") = $Description
    $app.Value("Activation") = 1

    switch ($IdentityMode) {
            "this_user" {
                if ([string]::IsNullOrWhiteSpace($Username)) {
                    throw "Username is required when IdentityMode=this_user"
                }
                $app.Value("Identity") = $Username
                $app.Value("Password") = $Password
            }
            "interactive_user" {
                $app.Value("Identity") = "Interactive User"
                $app.Value("Password") = ""
            }
            "localservice" {
                $app.Value("Identity") = "nt authority\localservice"
                $app.Value("Password") = ""
            }
            "networkservice" {
                $app.Value("Identity") = "nt authority\networkservice"
                $app.Value("Password") = ""
            }
            "system" {
                $app.Value("Identity") = "nt authority\system"
                $app.Value("Password") = ""
            }
        }

    $app.Value("ApplicationAccessChecksEnabled") = $EnableAppAccessChecks
    $app.Value("AccessChecksLevel") = $AccessChecksLevel

    [void]$apps.SaveChanges()
    $changed = $true
}
else {
    Write-Verbose "Application '$ApplicationName' already exists — skipping creation"
}

[ordered]@{
    changed = $changed
    application = $ApplicationName
    step = "create_or_update_app"
} | ConvertTo-Json -Depth 5