apiVersion: v1
kind: ConfigMap
metadata:
  name: django-mysql-conf
data:
  MYSQL_USER: sampleblog
  MYSQL_DATABASE: sampleblog
#  MYSQL_HOST: "sample-blog-db.carhgrscmnza.us-east-1.rds.amazonaws.com"
  MYSQL_HOST: "${RDS_HOST}"
  MYSQL_PORT: "3306"
  BLOG_ADMIN_USER: admin
  BLOG_ADMIN_EMAIL: admin@sample.com
