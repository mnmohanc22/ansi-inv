[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$ApplicationName,

    [string]$Description = "",

    [ValidateSet("this_user", "interactive_user", "localservice", "networkservice", "system")]
    [string]$IdentityMode = "this_user",

    [string]$Username = "",

    [string]$Password = "",

    [bool]$EnableAppAccessChecks = $false,

    [ValidateSet(0,1)]
    [int]$AccessChecksLevel = 0
)

$ErrorActionPreference = "Stop"

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
    $localChanged = $false

    if ($app.Value("Description") -ne $Description) {
        $app.Value("Description") = $Description
        $localChanged = $true
    }

    if ([int]$app.Value("Activation") -ne 1) {
        $app.Value("Activation") = 1
        $localChanged = $true
    }

    if ([bool]$app.Value("ApplicationAccessChecksEnabled") -ne $EnableAppAccessChecks) {
        $app.Value("ApplicationAccessChecksEnabled") = $EnableAppAccessChecks
        $localChanged = $true
    }

    if ([int]$app.Value("AccessChecksLevel") -ne $AccessChecksLevel) {
        $app.Value("AccessChecksLevel") = $AccessChecksLevel
        $localChanged = $true
    }

    switch ($IdentityMode) {
            "this_user" {
                if ($app.Value("Identity") -ne $Username) {
                    $app.Value("Identity") = $Username
                    $app.Value("Password") = $Password
                    $localChanged = $true
                }
            }
            "interactive_user" {
                if ($app.Value("Identity") -ne "Interactive User") {
                    $app.Value("Identity") = "Interactive User"
                    $app.Value("Password") = ""
                    $localChanged = $true
                }
            }
            "localservice" {
                if ($app.Value("Identity") -ne "nt authority\localservice") {
                    $app.Value("Identity") = "nt authority\localservice"
                    $app.Value("Password") = ""
                    $localChanged = $true
                }
            }
            "networkservice" {
                if ($app.Value("Identity") -ne "nt authority\networkservice") {
                    $app.Value("Identity") = "nt authority\networkservice"
                    $app.Value("Password") = ""
                    $localChanged = $true
                }
            }
            "system" {
                if ($app.Value("Identity") -ne "nt authority\system") {
                    $app.Value("Identity") = "nt authority\system"
                    $app.Value("Password") = ""
                    $localChanged = $true
                }
            }
        }

    if ($localChanged) {
        [void]$apps.SaveChanges()
        $changed = $true
    }
}

[ordered]@{
    changed = $changed
    application = $ApplicationName
    step = "create_or_update_app"
} | ConvertTo-Json -Depth 5