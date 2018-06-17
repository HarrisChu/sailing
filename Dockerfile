FROM centos:7

RUN mkdir /sailing
WORKDIR /sailing

ENV LANG "en_US.UTF-8"


RUN yum install yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install which -y \
    && yum update -y \
    && yum install -y python36u python36u-libs python36u-devel python36u-pip \
    && ln -s /usr/bin/python3.6 /usr/bin/python3\
    && ln -s /usr/bin/pip3.6 /usr/bin/pip3      \
    && pip3 install pipenv

COPY Pipfile.lock Pipfile /sailing/

RUN pipenv install

COPY . /sailing

CMD ["/bin/bash"]

