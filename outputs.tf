output "template" {
  value       = file(local.template_file)
  description = "Content of the template, used for rendering"
}

output "content" {
  value       = local.content
  description = "Raw content of the cloud config in YAML format"
}

output "base64" {
  value       = base64encode(local.content)
  description = "Base64 encoded content of the cloud config"
}

output "base64gzip" {
  value       = base64gzip(local.content)
  description = "Base64 encoded + Gzipped content of the cloud config"
}

output "md5sum" {
  value       = md5(local.content)
  description = "Hash sum of the content"
}

output "sha1sum" {
  value       = sha1(local.content)
  description = "Hash sum of the content"
}

output "sha256sum" {
  value       = sha256(local.content)
  description = "Hash sum of the content"
}

output "sha512sum" {
  value       = sha512(local.content)
  description = "Hash sum of the content"
}
