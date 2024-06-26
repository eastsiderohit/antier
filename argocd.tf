# Install argocd in eks
resource "helm_release" "argocd" {
  name             = "argo"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.52.1"
  namespace        = "argo"
  create_namespace = true
  set {
    name  = "configs.params.server.insecure"
    value = "true"
  }
  set {
    name  = "configs.secret.argocdServerAdminPassword"
    value = random_password.argo.bcrypt_hash
  }
}

# generate random password for argocd
resource "random_password" "argo" {
  length  = 16
  special = false
}

# store password for argocd in ssm paramter store
resource "aws_ssm_parameter" "argo" {
  name  = "/${terraform.workspace}/argo/password"
  type  = "SecureString"
  value = random_password.argo.result
}

# Install alb controller with eks
resource "helm_release" "argocd" {
  name             = "argo-services"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-apps"
  version          = "2.0.0"
  namespace        = "argo"
  create_namespace = true
  values = [
    templatefile("templates/alb.yaml.tpl", {
      environment = terraform.workspace
      cluster_name = module.eks.cluster_name 
    }
  )]
}
