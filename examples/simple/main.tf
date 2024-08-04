terraform {
  required_version = ">= 0.13"
}

module "example" {
  source = "../../"

  packages = [
    "bash-completion",
    "git",
    "nano",
  ]

  package_update             = true
  package_upgrade            = true
  package_reboot_if_required = true

  runcmd = [
    "echo 1 > /etc/test",
    "systemctl daemon-reload",
    "systemctl restart sshd",
  ]
}
