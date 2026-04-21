# ------------------------------------------------------------
# tf.sh
# Wrapper script to force Terraform to use the project-local
# terraform.rc file instead of ~/.terraformrc.
# This ensures module paths remain stable and clean.
# ------------------------------------------------------------

#!/bin/bash
export TF_CLI_CONFIG_FILE="$(pwd)/terraform.d/terraform.rc"
terraform "$@"

