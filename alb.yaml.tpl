applications:
  alb: 
    namespace: argocd
    name: ${environment}-sevices
    additionalLabels: {}
    additionalAnnotations: {}
    finalizers:
      - resources-finalizer.argocd.argoproj.io
    description: "Services app of apps"
    project: default
    source:
      repoURL: https://aws.github.io/eks-charts
      targetRevision: 1.7.0
      chart: aws-load-balancer-controller
      helm: 
        parameters: 
          - name: clusterName
            value: ${cluster_name}
      directory:
       recurse: false
    destination:
      server: https://kubernetes.default.svc
      namespace: argocd
    syncPolicy:
      automated:
        prune: true
        selfHeal: true
    revisionHistoryLimit: 5

#note: first create a folder with name template and then make alb.yaml.tpl
