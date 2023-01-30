python manage.py migrate
python manage.py custom_createsuperuser --username ${BLOG_ADMIN_USER} --email ${BLOG_ADMIN_EMAIL} --password ${BLOG_ADMIN_PASSWORD}
python3 manage.py runserver 0.0.0.0:8000

