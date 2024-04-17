variable "instancias" {
  description = "Nombre de insntacias"
  type        = list(string)
  # type        = set(string)
  default = ["apache"]
}

resource "aws_instance" "public_instance" {
  # count = length(var.instancias)
  for_each               = toset(var.instancias) // cambia las lista por un set, lo castea desde aqui
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "${each.value}-${ local.sufix }"
  }
}

resource "aws_instance" "monitoring_instance" {
  # count = length(var.instancias)
  count                  = var.enable_monitoring == 1 ? 1 : 0
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")

  tags = {
    "Name" = "Monitoreo-${ local.sufix }"
  }
}



# variable "cadena" {
#   type    = string
#   default = "ami-123,AMI,AMI-AAV,ami-12f"
# }

# variable "palabras" {
#   type    = list(string)
#   default = ["hola", "como", "estan"]
# }

# variable "entornos" {
#   type = map(string)
#   default = {
#     "prod" = "10.10.0.0/16"
#     "dev"  = "172.16.0.0/16"
#   }
# }
