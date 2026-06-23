# Output instructions for the Namecheap nameserver update.
output "namecheap_setup_instructions" {
  description = "Step-by-step Namecheap nameserver update"
  value = <<-EOT
    Update your Namecheap nameservers for ${var.domain_name} to:
    ${join("\n    ", aws_route53_zone.stanley_bank_zone.name_servers)}

    In Namecheap: Domain List → ${var.domain_name} → Nameservers → Custom DNS.
    Paste the 4 records above.
  EOT
}
