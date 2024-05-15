FROM python:3.10-slim

# Работа с файами

RUN mkdir app
RUN apt-get update && apt-get install -y curl && apt-get clean
WORKDIR app

ADD billar/. /app/

# Установка приложений

RUN pip install -r requirements.txt

# Уствановка команд


CMD python manage.py makemigrations \
    && python manage.py migrate \
    && python manage.py collectstatic --noinput \
    && python manage.py collectstatic --noinput \
    && gunicorn billar.wsgi:application -b 0.0.0.0:8000
