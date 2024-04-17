resource "aws_instance" "public_instance" {
  ami                    = var.ec2_specs.ami
  instance_type          = var.ec2_specs.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = data.aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg_public_instance.id]
  user_data              = file("scripts/userdata.sh")
  # <<EOF
  # #!/bin/bash
  # echo "Este es un mensaje" > ~/mensaje.txt
  # EOF
  // sirve para instalar paquetes en una insntacias o algo similar cuando se crear la instaica desde 


  provisioner "local-exec" {
    command = "echo instancia creada con la IP ${aws_instance.public_instance.public_ip} >> datos_instances.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo instancia  ${self.public_ip} destruida >> datos_instances.txt" // el self se refiere a la intancias misma osea el recurso sobre el que se esta codificando
  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "echo 'hola mundo' > ~/saludo.txt"
  #   ]
  #   connection {
  #     type = "ssh"
  #     host = self.public_ip
  #     user = "ec2-user"
  #     private_key = file("mykey.pem")
  #   }
  # }
  # lifecycle {
  #   # create_before_destroy = true
  #   # prevent_destroy = true # no se puede borrar el recurso 
  #   # ignore_changes = [ 
  #   #   ami,
  #   #   subnet_id
  #   # ]
  #   replace_triggered_by = [ 
  #     aws_subnet.private_subnet
  #   ] # mientras este recueros no sufra cambios el recurso no va a sufrir cambios
  # }
}


# resource "aws_instance" "mywebserver" {
#   ami           = "ami-051f8a213df8bc089"
#   instance_type = "t2.micro"
#   key_name      = data.aws_key_pair.key.key_name
#   subnet_id     = aws_subnet.public_subnet.id
#   tags = {
#     "Name" = "myserver"
#   }
#   vpc_security_group_ids = [
#     aws_security_group.sg_public_instance.id
#   ]
# }
