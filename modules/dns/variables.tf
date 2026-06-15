variable "domain_name" { type = string }
variable "alb_dns_name" { type = string }
variable "namecheap_ips" {
  type    = list(string)
  default = ["1.1.1.1", "1.1.1.2", "1.1.1.3", "1.1.1.4"]
}
