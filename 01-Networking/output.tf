# Step 10 - Add output variables
output "subnet_id" {
  value = aws_subnet.public_subnet_assignment1.id
}