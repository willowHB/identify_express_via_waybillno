FROM python:3.8.3

RUN mkdir /app
# Install pip
pip install -r /identify_express_via_waybillno/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
pip install gunicorn prometheus-flask-exporter -i https://pypi.tuna.tsinghua.edu.cn/simple

copy controller.py /app

WORKDIR /app

CMD ["python","controller.py"]