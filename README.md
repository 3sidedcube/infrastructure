# Terraform Infrastructure

Terraform modules for common Node team infrastructure.

This repository comprises a set of individual Terraform modules.
These modules are designed to configure the basic infrastructure needed for a standard Node application.
They can be imported directly into your stage files, or extended to add additional features.

### Direct Implementation

Each environment should have it's own Terraform configuration, which pulls together the relevant modules for that project.
This follows the recommendations made in Google's [Best Practices for Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform).

```terraform
<!-- infrastructure/environments/staging.tf -->
module "network" {
  source = "github.com/chelsea-apps/infrastructure.git//network"

  project_name = local.name
}
```
