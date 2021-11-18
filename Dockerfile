# 基础镜像centos7
FROM centos:7

# Install python3
RUN set -ex \
    # 预安装所需组件
    && yum install -y install zlib-devel bzip2-devel openssl-devel ncurses-devel \
        sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel \
        && yum -y install gcc kernel-devel kenel-headers make bzip2 \
        && yum -y install gcc gcc-c++ zlib zlib-devel \
        && yum -y install wget
    # 安装python并配置环境
    && wget https://www.python.org/ftp/python/3.8.3/Python-3.8.3.tgz \
    && tar -zxvf Python-3.8.3.tgz \
    && cd Python-3.8.3 \
    && ./configure --prefix=/usr/local/python3 \
    && make && make install \
    && ln -s /usr/local/python3/bin/python3 /usr/bin/python3 \
    && ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 \
    && pip3 config set global.index-url https://mirrors.aliyun.com/pypi/simple/ \
    && pip3 install --upgrade pip

RUN  yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel \
        sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel \
        && yum -y install gcc kernel-devel kenel-headers make bzip2 \
        && yum -y install gcc gcc-c++ zlib zlib-devel

RUN mkdir /app
COPY controller.py /app
WORKDIR /app

# 添加三方依赖文件
COPY requirements.txt /app/requirements.txt

# Install pip 安装三方依赖
RUN pip install -r /app/requirements.txt -i https://mirrors.aliyun.com/pypi/simple/
RUN pip install gunicorn prometheus-flask-exporter -i https://mirrors.aliyun.com/pypi/simple/

CMD ["python","controller.py"]