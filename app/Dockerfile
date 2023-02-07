FROM python:3.10

WORKDIR /app

RUN pip install "fastapi[all]"

COPY ./ /app

RUN chmod +x /app/entrypoint-test.sh
RUN chmod +x entrypoint-deploy.sh