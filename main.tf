terraform {
  required_version = ">= 0.13"
}

locals {
  template_file = var.template_file != "" ? var.template_file : "${path.module}/templates/cloud-config.tpl"

  content = trimspace(templatefile(local.template_file, {
    bootcmd                    = var.bootcmd
    groups                     = var.groups
    users                      = var.users
    default_user               = var.default_user
    write_files                = var.write_files
    ntp                        = var.ntp
    yum_repos                  = var.yum_repos
    packages                   = var.packages
    package_update             = var.package_update
    package_upgrade            = var.package_upgrade
    package_reboot_if_required = var.package_reboot_if_required
    runcmd                     = var.runcmd
    final_message              = var.final_message
    keep_default_user          = var.keep_default_user
  }))
}
