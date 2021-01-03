# Copyright 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# syntax = docker/dockerfile:1.0-experimental
FROM centos:centos7 as build

# Common development tools and libraries (kitchen sink approach)
RUN yum groupinstall -y "Development Tools"
RUN yum -y install centos-release-scl && \
    yum -y install devtoolset-8 devtoolset-8-libatomic-devel

SHELL [ "/usr/bin/scl", "enable", "devtoolset-8"]

# gaw3 dependencies
RUN yum install -y csh wget tcl-devel tk-devel libX11-devel cairo-devel ncurses-devel bison flex libXpm-devel libXaw-devel xcb-util-devel readline-devel fftw3 gtk3-devel

# git clone netgen components
RUN wget http://download.tuxfamily.org/gaw/download/gaw3-20200922.tar.gz
RUN tar -xf gaw3-20200922.tar.gz


WORKDIR gaw3-20200922

# build
RUN ./configure --prefix=/build

RUN make clean && \
    make -j $(nproc) && \
    make install

RUN mkdir -p /build/version/

RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/gaw3.version
RUN echo "20200922" >> /build/version/gaw3.version
RUN tar -czf /build.tar.gz /build
