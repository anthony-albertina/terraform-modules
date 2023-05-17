# Terraform Modules
---
### Allows Reusable Infrastructure as Code
### How to Use:
```hcl
# 1. Install terraform based on your OS
# 2. Create a main.tf file calling the module like below:
module "[MODULE_NAME]" {
  source = "git@github.com:anthony-albertina/terraform-modules//[MODULE]?ref=[TAG]"
  [VARIABLE_NAME] = [VALUE]
}
# 3. In the same directory, run `terraform init`, then `terraform plan`, and finally if no errors then `terraform apply`. Enjoy!
```
### How to Contribute:
```bash
# 1. Make a folder in the root of the repo named after an offering
# 2. Test the module until completed
# 3. Push changes and tag a commit sequentially like so:
git tag -a "v0.0.1" -m "First tagging of my module"
git push --follow-tags
```
### Allows asynchronous calling and tagging of modules
