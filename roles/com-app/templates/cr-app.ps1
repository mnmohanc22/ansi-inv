# Define the application name
$appName = "MyEmptyComApp1"

# Instantiate the COM+ Admin Catalog object
$comAdmin = New-Object -ComObject COMAdmin.COMAdminCatalog

# Get the "Applications" collection and populate it
$apps = $comAdmin.GetCollection("Applications")
$apps.Populate()

# Check if the application already exists
$existingApp = $apps | Where-Object { $_.Name -eq $appName }

if ($existingApp) {
    Write-Host "COM+ Application '$appName' already exists." -ForegroundColor Yellow
} else {
    # Add a new application entry
    $newApp = $apps.Add()
    $newApp.Value("Name") = $appName
    
    # Optional: Set activation type (0 = Library, 1 = Server)
    # Server applications run in their own process (dllhost.exe)
    $newApp.Value("Activation") = 1

    # Disable access checks
    $newApp.Value("ApplicationAccessChecksEnabled") = $false
    $newApp.Value("AccessChecksLevel") = 0
    
    # Save changes to the catalog
    $apps.SaveChanges()
    Write-Host "Successfully created empty COM+ Application: $appName" -ForegroundColor Green
}
