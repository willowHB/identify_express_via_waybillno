FROM python:3.8.3

RUN mkdir /app

copy controller.py /app

WORKDIR /app

CMD ["python","controller.py"]