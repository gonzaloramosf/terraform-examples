output "ec2-public_ip" {
  value = module.liftoff-webserver.instance.public_ip
}
