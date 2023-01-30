apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app-sample-blog
  namespace: openshift-gitops
  labels:
    environment: prod
spec:
  destination:
    namespace: sample-blog 
    server: https://kubernetes.default.svc
  project: sample-blog
  source:
    kustomize:
    path: k8s/overlays/prod
    repoURL: ${GIT_URL}.git 
    targetRevision: master
  syncPolicy: {}
#    automated:
#      prune: false
#      selfHeal: false
#    syncOptions:
#      - ApplyOutOfSyncOnly=true 
#      - CreateNamespace=true
