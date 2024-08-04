variable "template_file" {
  type        = string
  default     = ""
  description = "Overrides default path to cloud-config template file if non-empty"
}

variable "bootcmd" {
  type        = list(string)
  default     = []
  description = <<-DESCRIPTION
    Boot commands:
    This is very similar to runcmd, but commands run very early in the boot process, only slightly after a 'boothook' would run.
    bootcmd should really only be used for things that could not be done later in the boot process.  bootcmd is very much like boothook,
    but possibly with more friendly.
    - bootcmd will run on every boot
    - the INSTANCE_ID variable will be set to the current instance id.
    - you can use 'cloud-init-per' command to help only run once
  DESCRIPTION
}

variable "runcmd" {
  type        = list(string)
  default     = []
  description = <<-DESCRIPTION
    Runcmd contains a list of either lists or a string each item will be executed in order at rc.local like level with output to the console
    - runcmd only runs during the first boot
    - if the item is a list, the items will be properly executed as if
      passed to execve(3) (with the first arg as the command).
    - if the item is a string, it will be simply written to the file and
      will be interpreted by 'sh'
  DESCRIPTION
}

variable "final_message" {
  type        = string
  default     = "Cloud-init boot finished at $TIMESTAMP. Up $UPTIME seconds this message is written by cloud-final when the system is finished its first boot"
  description = "Cloud init completion message"
}

variable "groups" {
  # [{ name, members }]
  # name    = string       # The name of the group
  # members = list(string) # Optional. Specify users list in group.
  type        = any
  default     = []
  description = "Add groups to the system"
}

variable "users" {
  # [{ name, gecos, ... }]
  # name                = string       # Required. The user's login name
  # gecos               = string       # The user name's real name, i.e. "Bob B. Smith"
  # homedir             = string       # Set to the local path you want to use. Defaults to "/home/<username>"
  # primary_group       = string       # Define the primary group. Defaults to a new group created named after the user.
  # groups              = list(string) # Optional. Additional groups to add the user to. Defaults to none
  # selinux_user        = string       # Optional. The SELinux user for the user's login, such as "staff_u". When this is omitted the system will select the default SELinux user.
  # lock_passwd         = bool         # Defaults to true. Lock the password to disable password login
  # inactive            = bool         # Create the user as inactive
  # passwd              = string       # The hash -- not the password itself -- of the password you want to use for this user. You can generate a safe hash via: "mkpasswd --method=SHA-512 --rounds=4096"
  # no_create_home      = bool         # When set to true, do not create home directory.
  # no_user_group       = bool         # When set to true, do not create a group named after the user.
  # no_log_init         = bool         # When set to true, do not initialize lastlog and faillog database.
  # ssh_import_id       = list(string) # Optional. Import SSH ids
  # ssh_authorized_keys = list(string) # Optional. [list] Add keys to user's authorized keys file
  # ssh_redirect_user   = bool         # Optional. [bool] Set true to block ssh logins for cloud ssh public keys and emit a message redirecting logins to use <default_username> instead.
  # sudo                = list(string) # Defaults to none. A list of sudo rule strings
  # system              = bool         # Create the user as a system user. This means no home directory.
  # snapuser            = string       # Create a Snappy (Ubuntu-Core) user via the snap create-user command available on Ubuntu systems.
  type        = any
  default     = []
  description = "Add users to the system"
}

variable "default_user" {
  # { name, gecos, ... }
  # name                = string       # The user's login name
  # gecos               = string       # The user name's real name, i.e. "Bob B. Smith"
  # homedir             = string       # Set to the local path you want to use. Defaults to "/home/<username>"
  # primary_group       = string       # Define the primary group. Defaults to a new group created named after the user.
  # groups              = list(string) # Optional. Additional groups to add the user to. Defaults to none
  # selinux_user        = string       # Optional. The SELinux user for the user's login, such as "staff_u". When this is omitted the system will select the default SELinux user.
  # lock_passwd         = bool         # Defaults to true. Lock the password to disable password login
  # passwd              = string       # The hash -- not the password itself -- of the password you want to use for this user. You can generate a safe hash via: "mkpasswd --method=SHA-512 --rounds=4096"
  # no_create_home      = bool         # When set to true, do not create home directory.
  # no_user_group       = bool         # When set to true, do not create a group named after the user.
  # no_log_init         = bool         # When set to true, do not initialize lastlog and faillog database.
  # ssh_import_id       = list(string) # Optional. Import SSH ids
  # ssh_authorized_keys = list(string) # Optional. [list] Add keys to user's authorized keys file
  # ssh_redirect_user   = bool         # Optional. [bool] Set true to block ssh logins for cloud ssh public keys and emit a message redirecting logins to use <default_username> instead.
  # sudo                = list(string) # Defaults to none. A list of sudo rule strings
  # system              = bool         # Create the user as a system user. This means no home directory.
  # snapuser            = string       # Create a Snappy (Ubuntu-Core) user via the snap create-user command available on Ubuntu systems.
  type        = any
  default     = {}
  description = "Setup default user settings"
}

variable "keep_default_user" {
  type        = bool
  default     = true
  description = "Add 'default' item before users list"
}

variable "write_files" {
  # [{ path, content, ... }]
  # path        = string   # Required. Destination path
  # content     = string   # Required. File content.
  # owner       = string   # Optional. Setup owner of the file 'user:group'
  # permissions = string   # Optional. File access mode. Default '0644'
  type        = any
  default     = []
  description = "The content will be decoded accordingly and then written to the path that is provided"
}

variable "ntp" {
  # { pools, servers, ... }
  # pools      = list(string)
  # servers    = list(string)
  # ntp_client = string
  # enabled    = boolean
  # config     = {
  #   confpath     = string
  #   check_exe    = string
  #   packages     = list(string)
  #   service_name = string
  #   template     = string
  # }
  type        = any
  default     = {}
  description = "Setup ntp client settings"
}

variable "yum_repos" {
  # { id = { name, baseurl, ... } }
  # name = string
  # baseurl = string
  # enabled = bool
  # gpgcheck = bool
  # gpgkey = list(string)
  default     = {}
  type        = any
  description = "Add yum repository configuration to the system"
}

variable "packages" {
  default     = []
  type        = list(string)
  description = "A list of packages to install can be provided"
}

variable "package_update" {
  default     = null
  type        = bool
  description = "Update packages cache in Ubuntu"
}

variable "package_upgrade" {
  default     = null
  type        = bool
  description = "If any packages are to be installed or an upgrade is to be performed then the package cache will be updated first."
}

variable "package_reboot_if_required" {
  default     = null
  type        = bool
  description = "If a package installation or upgrade requires a reboot, then a reboot can be performed if package_reboot_if_required is specified"
}
