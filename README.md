# Terraform Modules
---
### Allows Reusable Infrastructure as Code
### How to Use:
```hcl
module "[MODULE_NAME]" {
  source = "git::https://github.com/anthony-albertina/terraform-modules//[MODULE]?ref=[TAG]"
  [VARIABLE_NAME] = [VALUE]
}

