# data "aws_launch_template" "existing" {
#   name_prefix = "${var.cluster_name}-${var.env}-lt-"
#   image_id    = var.ami
# }

# resource "aws_launch_template_version" "with_bootstrap" {
#   launch_template_id  = data.aws_launch_template.existing.id
#   version_description = "add eks bootstrap user_data"

#   # Do NOT set iam_instance_profile or instance_type here for managed node groups
#   user_data = base64encode(<<-EOT
#     #!/bin/bash
#     set -x
#     exec > >(tee /var/log/bootstrap.log | logger -t userdata -s 2>/dev/console) 2>&1
#     if [ -f /etc/eks/bootstrap.sh ]; then
#       /etc/eks/bootstrap.sh ${aws_eks_cluster.main.name} --kubelet-extra-args '--v=4'
#     else
#       echo "/etc/eks/bootstrap.sh not found on AMI" >&2
#       exit 1
#     fi
#   EOT
#   )
# }