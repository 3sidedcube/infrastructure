locals {
  name = "${lower(var.project_name)}-auth"
}

resource "aws_cognito_user_pool" "main" {
  name = local.name

  mfa_configuration = "OFF"

  username_attributes = ["email"]

  auto_verified_attributes = [ "email" ]

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = false
    require_uppercase = false
    require_symbols   = false
  }

  device_configuration {
    device_only_remembered_on_user_prompt = false
  }

#   lambda_config {
#     pre_sign_up       = module.pre_sign_up_function.arn
#     post_confirmation = module.post_confirmation_function.arn
#   }
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = local.name
  user_pool_id = aws_cognito_user_pool.main.id
}

# Step 4 - Create Client App(s)
resource "aws_cognito_user_pool_client" "main" {
  name = "${local.name}-client"

  user_pool_id = aws_cognito_user_pool.main.id

  callback_urls = var.callback_urls

  supported_identity_providers = ["COGNITO"]

  access_token_validity  = var.access_token_validity_minutes
  id_token_validity      = var.access_token_validity_minutes
  refresh_token_validity = var.refresh_token_validity_days

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "phone", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true
}
