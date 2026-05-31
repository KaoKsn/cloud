FROM python:3.14-alpine AS base

RUN apk update && apk upgrade && pip install --upgrade pip 

WORKDIR /app

# Install dependencies
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN adduser -h /home/appuser -s /bin/sh -D appuser

# Homepage
COPY --chown=appuser:appuser app/ ./

# Logging
RUN mkdir -p /var/log/flask && chown -R appuser:appuser /var/log/flask/

USER appuser
EXPOSE 5000

CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:5000", "app:app", \
        "--access-logfile", "/var/log/flask/access.log", \
        "--error-logfile", "/var/log/flask/error.log"]
