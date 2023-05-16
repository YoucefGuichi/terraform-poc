resource "azurerm_resource_group" "tf-azure-db-poc" {
  name     = "rty4345t3trgrtgrth45"
  location = "West Europe"
}

resource "azurerm_postgresql_flexible_server" "gimlet-postgres-server" {
  name                   = "gimlet-postgres-server"
  resource_group_name    = azurerm_resource_group.tf-azure-db-poc.name
  location               = azurerm_resource_group.tf-azure-db-poc.location
  version                = "12"
  administrator_login    = "rtrh"
  administrator_password = "3rthjrtj"
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
}

resource "azurerm_postgresql_flexible_server_database" "gimlet-azure-poc-db" {
  name      = "app1"
  server_id = azurerm_postgresql_flexible_server.gimlet-postgres-server.id
  collation = "en_US.utf8"
  charset   = "utf8"
}


resource "postgresql_role" "app_user" {
  name     = "app_user"
  login    = true
  password = "34534htr46"
}

resource "postgresql_role" "admin_user" {
  name     = "admin_user"
  login    = true
  password = "rhrhrtjr1"
}

resource "postgresql_grant" "read_from_emp" {
  database    = "app1"
  role        = postgresql_role.app_user.name
  schema      = "public"
  object_type = "table"
  objects     = ["employees"]
  privileges  = ["SELECT"]
}


resource "postgresql_grant" "read_insert_all" {
  database    = "app1"
  role        = postgresql_role.admin_user.name
  schema      = "public"
  object_type = "table"
  objects     = ["departments", "departments"]
  privileges  = ["SELECT","INSERT"]
}
