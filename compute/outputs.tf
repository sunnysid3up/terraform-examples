output "ssh_key_name" {
  value = aws_key_pair.key_pair.key_name
}

output "ssh_public_key" {
  value = aws_key_pair.key_pair.public_key
}

output "bastion_public_ip" {
  value = aws_instance.bastion.*.public_ip
}

output "private_instance_ip" {
  value = aws_instance.app.*.private_ip
}

output "private_instance_id" {
  value = aws_instance.app.*.id
}