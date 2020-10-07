resource "google_service_account" "account" {
  account_id   = var.name
  display_name = coalesce(var.displayname, var.name)
  description  = var.description
  project      = var.project

  provisioner "local-exec" {
    command = "sleep 15"
  }
}

resource "google_project_iam_binding" "binding" {
  count = length(var.roles)

  members  = ["serviceAccount:${var.name}@${var.project}.iam.gserviceaccount.com"]
  project = var.project
  role    = element(var.roles,count.index)

  depends_on = [ google_service_account.account ]
}