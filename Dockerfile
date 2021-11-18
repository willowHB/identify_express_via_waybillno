FROM python:3.8.3

RUN mkdir /app
COPY controller.py /app
WORKDIR /app

# 添加项目
ADD  ./home/yjt/identify_express_via_waybillno/ /identify_express_via_waybillno/
# 添加三方依赖
ADD ./home/yjt/identify_express_via_waybillno/requirements.txt /identify_express_via_waybillno/requirements.txt

# Install pip
RUN pip install -r /identify_express_via_waybillno/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install gunicorn prometheus-flask-exporter -i https://pypi.tuna.tsinghua.edu.cn/simple

CMD ["python","controller.py"]