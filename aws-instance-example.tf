resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-01718400c2741bdb3"]
   key_name               = "Linux_Terraform-Chef" 
   iam_instance_profile =   "myManagedInstanceRole"
   user_data = <<-EOF
		#!/bin/bash
      sudo amazon-linux-extras install ansible2 -y
      sudo yum install git -y
      git clone https://github.com/Abishek-Ravichander/Ansible-playbook.git
      cd Ansible-playbook
      ansible-playbook apache.yml -f 10
      EOF
   }
