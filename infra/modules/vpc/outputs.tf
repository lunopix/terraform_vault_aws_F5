output "vpc_id" {
  description = "Ce module retourne l'ID du vpc myVPC"
  value       = aws_vpc.monVPC.id

}


output "PublicNetCreated" {
  description = "Ce module retourne l'ID du réseau public de F5"
  value       = aws_subnet.ResourcePublicNet.id

}