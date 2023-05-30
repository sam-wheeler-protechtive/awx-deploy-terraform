# main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_role_arn
  version  = var.eks_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types
  desired_size    = var.desired_size
  min_size        = var.min_size
  max_size        = var.max_size
}

resource "kubernetes_namespace" "awx_namespace" {
  metadata {
    name = "awx"
  }
}

resource "random_string" "awx_secret_key" {
  length  = 32
  special = true
}

resource "kubernetes_secret" "awx_secret" {
  metadata {
    name      = "awx-secret"
    namespace = kubernetes_namespace.awx_namespace.metadata.0.name
  }

  data = {
    "secret_key" = base64encode(random_string.awx_secret_key.result)
  }
}

resource "kubernetes_service_account" "awx_service_account" {
  metadata {
    name      = "awx"
    namespace = kubernetes_namespace.awx_namespace.metadata.0.name
  }
}

resource "kubernetes_cluster_role" "awx_cluster_role" {
  metadata {
    name = "awx-cluster-role"
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "secrets", "namespaces", "persistentvolumeclaims"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "awx_cluster_role_binding" {
  metadata {
    name = "awx-cluster-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.awx_cluster_role.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.awx_service_account.metadata.0.name
    namespace = kubernetes_namespace.awx_namespace.metadata.0.name
  }
}

resource "kubernetes_deployment" "awx_deployment" {
  metadata {
    name      = "awx-deployment"
    namespace = kubernetes_namespace.awx_namespace.metadata.0.name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app" = "awx"
      }
    }

    template {
      metadata {
        labels = {
          "app" = "awx"
        }
      }

      spec {
        container {
          name  = "awx"
          image = var.awx_image

          env {
            name  = "SECRET_KEY"
            value = random_string.awx_secret_key.result
          }
        }
      }
    }
  }
}
