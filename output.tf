output "base_url" {
  value = aws_api_gateway_deployment.image_uploader_deployment.invoke_url
}