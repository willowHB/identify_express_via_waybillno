FROM python:3.8.3

RUN mkdir /app
COPY controller.py /app
WORKDIR /app

# 添加三方依赖文件
COPY requirements.txt /app/requirements.txt

# Install pip 安装三方依赖
RUN pip install -r /app/requirements.txt
RUN pip install gunicorn prometheus-flask-exporter

CMD ["python","controller.py"]