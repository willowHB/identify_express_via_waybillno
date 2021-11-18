FROM python:3.8.3

RUN mkdir /app
# 添加项目的启动类
COPY controller.py /app
WORKDIR /app

# 添加三方依赖文件
COPY requirements.txt /app/requirements.txt

# Install pip 安装三方依赖 (指定阿里云pypi加速，清华pypi加速会报403)
RUN pip install -r /app/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
RUN pip install gunicorn prometheus-flask-exporter -i https://mirrors.aliyun.com/pypi/simple/

CMD ["python","controller.py"]