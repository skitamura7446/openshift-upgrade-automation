apiVersion: route.openshift.io/v1
kind: Route
metadata:
  labels:
    app: sample-blog
  name: nginx
  namespace: sample-blog
spec:
  host: ${APP_HOST}
  port:
    targetPort: 8080
  to:
    kind: Service
    name: nginx
    weight: 100
  wildcardPolicy: None
