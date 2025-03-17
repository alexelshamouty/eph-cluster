#!/bin/sh

eksctl utils associate-iam-oidc-provider --region eu-north-1 --cluster ephemral-cluster --approve --profile mystuff

eksctl create iamserviceaccount \                                                                                                                                                       130 ↵
        --name ebs-csi-controller-sa \
        --namespace kube-system \
        --cluster ephemral-cluster \
        --role-name AmazonEKS_EBS_CSI_DriverRole \
        --role-only \
        --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
        --approve --profile mystuff --region eu-north-1

eksctl create addon --name aws-ebs-csi-driver --cluster ephemral-cluster --region eu-north-1 --profile mystuff  --version latest --service-account-role-arn arn:aws:iam::825765385668:role/AmazonEKS_EBS_CSI_DriverRole --force
