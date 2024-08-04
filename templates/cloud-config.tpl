#cloud-config

%{~ if length(bootcmd) > 0 ~}
bootcmd:
  %{~ for cmd in bootcmd ~}
  - ${trimspace(cmd)}
  %{~ endfor ~}
%{ endif ~}

%{~ if length(groups) > 0 ~}
groups:
  %{~ for g in groups ~}
  - ${ g.name }%{ if length(lookup(g, "members", [])) > 0 }: [ ${ join(", ", g.members) } ]%{ endif }
  %{~ endfor ~}
%{ endif ~}

%{~ if length(users) > 0 ~}
users:
  %{~ if length(default_user) > 0 || keep_default_user ~}
  - default
  %{~ endif ~}
  %{~ for u in users ~}
  - name: ${ trimspace(u.name) }
  %{~ if lookup(u, "gecos", "") != "" ~}
    gecos: ${ trimspace(u.gecos) }
  %{~ endif ~}
  %{~ if lookup(u, "homedir", "") != "" ~}
    homedir: ${ trimspace(u.homedir) }
  %{~ endif ~}
  %{~ if lookup(u, "primary_group", "") != "" ~}
    primary_group: ${ trimspace(u.primary_group) }
  %{~ endif ~}
  %{~ if length(lookup(u, "groups", [])) > 0 ~}
    groups:
      %{~ for group in u.groups ~}
      - ${ trimspace(group) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(u, "selinux_user", "") != "" ~}
    selinux_user: ${ trimspace(u.selinux_user) }
  %{~ endif ~}
    lock_passwd: ${ trimspace(lookup(u, "lock_passwd", true)) }
    inactive: ${ trimspace(lookup(u, "inactive", false)) }
  %{~ if lookup(u, "passwd", "") != "" ~}
    passwd: ${ trimspace(u.passwd) }
  %{~ endif ~}
  %{~ if lookup(u, "no_create_home", false) ~}
    no_create_home: true
  %{~ endif ~}
  %{~ if lookup(u, "no_user_group", false) ~}
    no_user_group: true
  %{~ endif ~}
  %{~ if lookup(u, "no_log_init", false) ~}
    no_log_init: true
  %{~ endif ~}
    shell: ${ trimspace(lookup(u, "shell", "/bin/bash")) }
  %{~ if length(lookup(u, "ssh_import_id", [])) > 0 ~}
    ssh_import_id:
      %{~ for id in u.ssh_import_id ~}
      - ${ trimspace(id) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if length(lookup(u, "ssh_authorized_keys", [])) > 0 ~}
    ssh_authorized_keys:
      %{~ for key in u.ssh_authorized_keys ~}
      - ${ trimspace(key) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(u, "ssh_redirect_user", false) ~}
    ssh_redirect_user: true
  %{~ endif ~}
  %{~ if length(lookup(u, "sudo", [])) > 0 ~}
    sudo:
      %{~ for item in u.sudo ~}
      - ${ trimspace(item) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(u, "system", false) ~}
    system: true
  %{~ endif ~}
  %{~ if lookup(u, "snapuser", "") != "" ~}
    snapuser: ${ u.snapuser }
  %{~ endif ~}
  %{~ endfor /* users */ ~}
%{ endif /* users */ ~}

%{~ if default_user != {} ~}
system_info:
  default_user:
    name: ${ trimspace(default_user.name) }
  %{~ if lookup(default_user, "gecos", "") != "" ~}
    gecos: ${ trimspace(default_user.gecos) }
  %{~ endif ~}
  %{~ if lookup(default_user, "homedir", "") != "" ~}
    homedir: ${ trimspace(default_user.homedir) }
  %{~ endif ~}
  %{~ if lookup(default_user, "primary_group", "") != "" ~}
    primary_group: ${ trimspace(default_user.primary_group) }
  %{~ endif ~}
  %{~ if length(lookup(default_user, "groups", [])) > 0 ~}
    groups:
      %{~ for group in default_user.groups ~}
      - ${ trimspace(group) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(default_user, "selinux_user", "") != "" ~}
    selinux_user: ${ trimspace(default_user.selinux_user) }
  %{~ endif ~}
    lock_passwd: ${ trimspace(lookup(default_user, "lock_passwd", true)) }
  %{~ if lookup(default_user, "passwd", "") != "" ~}
    passwd: ${ trimspace(default_user.passwd) }
  %{~ endif ~}
  %{~ if lookup(default_user, "no_create_home", false) ~}
    no_create_home: true
  %{~ endif ~}
  %{~ if lookup(default_user, "no_user_group", false) ~}
    no_user_group: true
  %{~ endif ~}
  %{~ if lookup(default_user, "no_log_init", false) ~}
    no_log_init: true
  %{~ endif ~}
    shell: ${ trimspace(lookup(default_user, "shell", "/bin/bash")) }
  %{~ if length(lookup(default_user, "ssh_import_id", [])) > 0 ~}
    ssh_import_id:
      %{~ for id in default_user.ssh_import_id ~}
      - ${ trimspace(id) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if length(lookup(default_user, "ssh_authorized_keys", [])) > 0 ~}
    ssh_authorized_keys:
      %{~ for key in default_user.ssh_authorized_keys ~}
      - ${ trimspace(key) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(default_user, "ssh_redirect_user", false) ~}
    ssh_redirect_user: true
  %{~ endif ~}
  %{~ if length(lookup(default_user, "sudo", [])) > 0 ~}
    sudo:
      %{~ for item in default_user.sudo ~}
      - ${ trimspace(item) }
      %{~ endfor ~}
  %{~ endif ~}
  %{~ if lookup(default_user, "system", false) ~}
    system: true
  %{~ endif ~}
  %{~ if lookup(default_user, "snapuser", "") != "" ~}
    snapuser: ${ default_user.snapuser }
  %{~ endif ~}
%{ endif /* default_user */ ~}

%{~ if length(write_files) > 0 ~}
write_files:
  %{~ for f in write_files ~}
  - path: ${ trimspace(f.path) }
  %{~ if lookup(f, "owner", "") != "" ~}
    owner: ${ trimspace(f.owner) }
  %{~ endif ~}
    permissions: ${ trimspace(lookup(f, "permissions", "0644")) }
    encoding: b64
    content: ${ base64encode(f.content) }
  %{~ endfor ~}
%{ endif /* write_files */ ~}

%{~ if length(ntp) > 0 ~}
ntp:
  enabled: ${ trimspace(lookup(ntp, "enabled", true)) }
  %{~ if lookup(ntp, "ntp_client", "") != "" ~}
  ntp_client: ${ trimspace(ntp.ntp_client) }
  %{~ endif ~}
  %{~ if length(lookup(ntp, "pools", [])) > 0 ~}
  pools:
    %{~ for pool in ntp.pools ~}
    - ${ trimspace(pool) }
    %{~ endfor ~}
  %{~ endif ~}
  %{~ if length(lookup(ntp, "servers", [])) > 0 ~}
  servers:
    %{~ for server in ntp.servers ~}
    - ${ trimspace(server) }
    %{~ endfor ~}
  %{~ endif ~}
  %{~ if length(lookup(ntp, "config", {})) > 0 ~}
  config:
    %{~ if length(lookup(ntp.config, "confpath", "")) > 0 ~}
    confpath: ${ trimspace(ntp.config.confpath) }
    %{~ endif ~}
    %{~ if length(lookup(ntp.config, "check_exe", "")) > 0 ~}
    check_exe: ${ trimspace(ntp.config.check_exe) }
    %{~ endif ~}
    %{~ if length(lookup(ntp.config, "template", "")) > 0 ~}
    template: |
        ${ indent(8, trimspace(ntp.config.template)) }
    %{~ endif ~}
    %{~ if length(lookup(ntp.config, "packages", "")) > 0 ~}
    packages:
      %{~ for package in ntp.config.packages ~}
      - ${ package }
      %{~ endfor ~}
    %{~ endif ~}
  %{~ endif ~}
%{ endif /* ntp */ ~}

%{~ if length(yum_repos) > 0 ~}
yum_repos:
  %{~ for id, conf in yum_repos ~}
  ${ id }:
    name: ${ trimspace(conf.name) }
    %{~ if lookup(conf, "baseurl", null) != null ~}
    baseurl: ${ trimspace(conf.baseurl) }
    %{~ endif ~}
    %{~ if lookup(conf, "enabled", null) != null ~}
    enabled: ${ tostring(conf.enabled) }
    %{~ endif ~}
    %{~ if lookup(conf, "gpgcheck", null) != null ~}
    gpgcheck: ${ tostring(conf.gpgcheck) }
    %{~ endif ~}
    %{~ if length(lookup(conf, "gpgkey", [])) > 0 ~}
    gpgkey:
      %{~ for key in conf.gpgkey ~}
      - ${ trimspace(key) }
      %{~ endfor ~}
    %{~ endif  ~}
  %{~ endfor ~}
%{ endif /* yum_repos */ ~}

%{~ if length(packages) > 0 ~}
packages:
  %{~ for package in packages ~}
  - ${ trimspace(package) }
  %{~ endfor ~}
%{ endif ~}

%{~ if package_update != null ~}
package_update: ${ tostring(package_update) }
%{ endif ~}

%{~ if package_upgrade != null ~}
package_upgrade: ${ tostring(package_upgrade) }
%{ endif ~}

%{~ if package_reboot_if_required != null ~}
package_reboot_if_required: ${ tostring(package_reboot_if_required) }
%{ endif ~}

%{~ if length(runcmd) > 0 ~}
runcmd:
  %{~ for cmd in runcmd ~}
  - ${trimspace(cmd)}
  %{~ endfor ~}
%{ endif ~}

%{~ if length(final_message) > 0 ~}
final_message: ${ trimspace(final_message) }
%{ endif ~}
