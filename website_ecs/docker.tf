#Not using this as Terraform doesn't pick up the changes made to Dockerfile

#resource "docker_image" "anne_test_website_docker" {
#  name = "anne-test-website-docker"
#  build {
#    path = "../website"
#    dockerfile = "Dockerfile"
#    tag  = ["anne-test-website:10_22"]
#
#    label = {
#      author : "Anne"
#    }
#  }
#}