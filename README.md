# Cloud config generator

Simple template tool for creating [cloud-config](https://cloudinit.readthedocs.io/en/latest/topics/examples.html) with [Terraform](https://www.terraform.io/)

## Usage example

Terraform code:

```terraform
module cloud_config {
  source  = "4ops/cloud-config/null"
  version = "1.0.2"

  groups          = ["mygroup1", "mygroup2"]
  users           = [{ name = "test", group = ["mygroup1", "mygroup2"] }]
  packages        = ["nano", "sudo", "python3-pip"]
  package_upgrade = true
  final_message   = "All done :)"
}
```

Result:

```yaml
#cloud-config
groups:
  - mygroup1
  - mygroup2
users:
  - name: test
    shell: /bin/bash
    groups: [ mygroup1, mygroup2 ]
packages:
  - nano
  - sudo
  - python3-pip
package_upgrade: true
final_message: All done :)
```

Also, see [examples](/examples) directory.
