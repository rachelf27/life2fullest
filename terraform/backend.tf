  terraform {
    backend "local" {
      path = "terraform.tfstate"
    }
  }
#terraform {
  #   backend "remote" {
  #     hostname     = "app.terraform.io"
  #     organization = "RachelMurphy"
  #     workspaces {
  #       name = "ecom_app_workspace"
  #     }
  #   }
#}
