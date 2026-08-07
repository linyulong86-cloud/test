output "vm_names" {
  value = [for vm in azurerm_windows_virtual_machine.vm : vm.name]
}

output "vm_public_ips" {
  value = {
    for vm in var.vm_names :
    vm => azurerm_public_ip.pip[vm].ip_address
  }
}