data "aws_launch_template" "existing" {
  name = var.launch_template_name
  user_data = base64encode(<<-EOT
    #!/bin/bash
    set -x
    # send stdout/stderr to /var/log/bootstrap.log and to the console
    exec > >(tee /var/log/bootstrap.log | logger -t userdata -s 2>/dev/console) 2>&1
    date
    echo "Checking for bootstrap script..."
    if [ -f /etc/eks/bootstrap.sh ]; then
      echo "Found bootstrap, running with increased kubelet verbosity"
      /etc/eks/bootstrap.sh ${aws_eks_cluster.main.name} --kubelet-extra-args '--v=4'
      rc=$?
      echo "bootstrap.sh exit code: ${rc}"
      exit ${rc}
    else
      echo "/etc/eks/bootstrap.sh not found on AMI" >&2
      exit 1
    fi
  EOT
  )
}

# resource "aws_iam_instance_profile" "node" {
#   name = "${var.cluster_name}-${var.env}-node-profile"
#   role = aws_iam_role.main.name
# }

# resource "aws_launch_template" "node" {
#   name_prefix   = "${var.cluster_name}-${var.env}-lt-"
#   image_id      = var.ami
#   # do not hardcode instance_type if you want the node group to control instance types
# #   iam_instance_profile {
# #     name = aws_iam_instance_profile.node.name
# #   }

#   # simple bootstrap for EKS managed nodes - cluster name injected
# #   user_data = base64encode(<<-EOT
# #     #!/bin/bash
# #     set -x
# #     # send stdout/stderr to /var/log/bootstrap.log and to the console
# #     exec > >(tee /var/log/bootstrap.log | logger -t userdata -s 2>/dev/console) 2>&1
# #     date
# #     echo "Checking for bootstrap script..."
# #     if [ -f /etc/eks/bootstrap.sh ]; then
# #       echo "Found bootstrap, running with increased kubelet verbosity"
# #       /etc/eks/bootstrap.sh ${aws_eks_cluster.main.name} --kubelet-extra-args '--v=4'
# #       rc=$?
# #       echo "bootstrap.sh exit code: ${rc}"
# #       exit ${rc}
# #     else
# #       echo "/etc/eks/bootstrap.sh not found on AMI" >&2
# #       exit 1
# #     fi
# #   EOT
# #   )
# }