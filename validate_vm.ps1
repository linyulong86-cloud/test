param(
    [string]$ResourceGroup,
    [string[]]$ExpectedVMs
)

Write-Host "Validating expected VMs in RG: $ResourceGroup"

$failed = $false

foreach ($vm in $ExpectedVMs) {

    Write-Host "Checking expected VM: $vm"

    #Check if VM exists in target RG
    $exists = az vm list `
        --resource-group $ResourceGroup `
        --query "[?name=='$vm'] | length(@)" `
        -o tsv

    if ($exists -eq 0) {
        Write-Host "ERROR: VM $vm does NOT exist in $ResourceGroup"
        $failed = $true
        continue
    }

    #Check power state
    $status = az vm get-instance-view `
        --resource-group $ResourceGroup `
        --name $vm `
        --query "instanceView.statuses[1].displayStatus" `
        -o tsv

    Write-Host "$vm status: $status"

    if ($status -notmatch "running") {
        Write-Host "ERROR: VM $vm is not running"
        $failed = $true
    }
}

if ($failed) {
    Write-Host "VM validation FAILED"
    exit 1
}

Write-Host "All expected VMs exist and are running"
exit 0