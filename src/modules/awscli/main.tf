terraform {
  required_version = ">= 1.0"

  required_providers {
    coder = {
      source  = "coder/coder"
      version = ">= 0.12.4"
    }
  }
}

# Add required variables for your modules and remove any unneeded variables
variable "agent_id" {
  type        = string
  description = "The ID of a Coder agent."
}

resource "coder_script" "awscli" {
  agent_id     = var.agent_id
  display_name = "AWS-CLI"
  icon         = "/icon/aws.svg"
  script = templatefile("${path.module}/run.sh", {
  })
  run_on_start       = true
  start_blocks_login = true
}
