resource "null_resource" "bastion" {
  depends_on = [module.bastion, aws_route_table.main-private, aws_nat_gateway.main-natgw]
  connection {
    host        = module.bastion.public_ip
    type        = "ssh"
    user        = var.user_bastion
    private_key = "${file(var.key)}"
  }
    provisioner "file" {
    source      = var.key
    destination = var.key_bastion
  }
  provisioner "remote-exec" {
    inline = [ "sudo apt update -y", "sudo apt install software-properties-common -y", "sudo apt-add-repository ppa:ansible/ansible -y", "sudo apt update -y", "sudo apt install ansible -y"]
  }
  provisioner "file" {
    source = "ansible"
    destination = "/home/ubuntu/ansible"
  }
  provisioner "remote-exec" {
    inline = ["sudo chmod 600 /home/ubuntu/.ssh/key-oregon.pem"]
  }
  provisioner "remote-exec" {
    inline = ["echo [elasticsearch]>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-a[0].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-a[1].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-a[2].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-b[0].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-b[1].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${aws_instance.elk-b[2].private_ip}>>/home/ubuntu/ansible/inventory",
    "echo [kibana]>>/home/ubuntu/ansible/inventory",
    "echo ${module.kibana.private_ip}>>/home/ubuntu/ansible/inventory",
    "echo [logstash]>>/home/ubuntu/ansible/inventory",
    "echo ${module.logstash-1.private_ip}>>/home/ubuntu/ansible/inventory",
    "echo ${module.logstash-2.private_ip}>>/home/ubuntu/ansible/inventory"
    ]
  }
  provisioner "remote-exec" {
    inline = ["sudo sed -i -e 's+#host_key_checking+host_key_checking+g' /etc/ansible/ansible.cfg"]
  }
  provisioner "remote-exec" {
    inline = ["ansible-playbook -i /home/ubuntu/ansible/inventory /home/ubuntu/ansible/playbook.yml"]
  }
}
