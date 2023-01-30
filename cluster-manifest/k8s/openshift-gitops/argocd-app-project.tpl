apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: sample-blog
  namespace: openshift-gitops
spec:
  destinations:
  - namespace: sample-blog
    server: https://kubernetes.default.svc
  sourceRepos:
  - ${GIT_URL}.git 
  clusterResourceWhitelist:
  - group: '*'
    kind: '*'

