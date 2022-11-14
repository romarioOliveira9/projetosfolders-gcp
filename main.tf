provider "google" {
  project     = "rosana-devops-iac"
  region      = "us-central"
  zone        = "us-central-c"
  credentials = file("serviceaccount.yaml")
}

resource "google_folder" "Financeiro" {
  display_name = "Financeiro"
  parent       = "organizations/696517304353"
}

resource "google_folder" "SalesForce" {
  display_name = "SalesForce"
  parent       = google_folder.Financeiro.name
}

resource "google_folder" "Desenvolvimento" {
  display_name = "Desenvolvimento"
  parent       = google_folder.SalesForce.name
}

resource "google_folder" "Producao" {
  display_name = "Producao"
  parent       = google_folder.SalesForce.name
}

resource "google_project" "rosana2-salesforce-dev" {
  name                = "SalesForce-Dev"
  project_id          = "rosana2-salesforce-dev"
  folder_id           = google_folder.Desenvolvimento.name
  auto_create_network = false
  billing_account     = "013F28-894419-ABC300"
}