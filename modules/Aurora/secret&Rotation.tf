/* data "vault_generic_secret" "db" {
  path = "secret/db"
}  */


resource "aws_secretsmanager_secret" "db_secret" {
  name = "db_managed_secret-${var.Environment}"
  kms_key_id = var.secret_kms_key
  recovery_window_in_days = var.secret_recovery_window_in_days
  force_overwrite_replica_secret = var.force_overwrite_replica_secret

  replica {
    region = var.secret_replica_region
  }
  
}

resource "aws_secretsmanager_secret_version" "db_secret_01" {
 secret_id     = aws_secretsmanager_secret.db_secret.id
 /* secret_string = jsonencode({
    username = data.vault_generic_secret.db.data["username"]
    password = data.vault_generic_secret.db.data["password"]
  }) */

  secret_string = jsonencode({
    #username = "dbadmin"
    password = "MyPassword123!"
  })
}

resource "aws_secretsmanager_secret_rotation" "Db_secret" {
  secret_id           = aws_secretsmanager_secret.db_secret.id
  rotation_lambda_arn = aws_lambda_function.dc_secret_rotation.arn

  rotation_rules {
    automatically_after_days = var.rotation_rules
  }
}

