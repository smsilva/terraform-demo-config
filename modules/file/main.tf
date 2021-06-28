variable "environment" {
  default = "temp"
}

variable "templates_directory" {
  default = "../../templates"
}

variable "destination" {
  default = "../../environments"
}

data "template_file" "tfvars" {
  template = file("${var.templates_directory}/${var.environment}.tfvars.tpl")
}

resource "local_file" "file" {
  content  = data.template_file.tfvars.rendered
  filename = "${var.destination}/${var.environment}/terraform.tfvars"
}