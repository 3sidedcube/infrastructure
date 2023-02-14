output "password" {
  description = "Database password"
  value = random_password.main.result
  sensitive = true
}