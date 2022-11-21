resource "null_resource" "copyhtml" {

  triggers = {
    private_key = local.ssh_private_key
    host        = aws_instance.ec2.public_ip
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    port        = "22"
    private_key = self.triggers.private_key 
    host        = self.triggers.host
  }
  provisioner "file" {
    
    source      = "../../api/docker-compose.yml"
    destination = "/home/ec2-user/docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      #"sudo /home/ec2-user/docker-compose.yml",
      "docker-compose -f docker-compose.yml up",
    ]
  }
}  