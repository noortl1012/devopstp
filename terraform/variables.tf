variable "docker_image" {
  description = "Docker image to be used in the web app"
  type        = string
  default     = "noortl/myapp:1.0"  # Default value if not set
}
