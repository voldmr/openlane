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

# ngspice dependencies
RUN yum install -y csh wget tcl-devel tk-devel libX11-devel cairo-devel ncurses-devel bison flex libXpm-devel libXaw-devel xcb-util-devel readline-devel fftw3

# git clone netgen components
RUN git clone https://git.code.sf.net/p/ngspice/ngspice ngspice-ngspice

WORKDIR ngspice-ngspice

RUN git checkout ngspice-33


# build
RUN ./autogen.sh
RUN mkdir release
WORKDIR release
RUN ../configure  --with-x --enable-xspice --enable-cider --with-readline=yes --enable-openmp --disable-debug CFLAGS="-m64 -O2" LDFLAGS="-m64 -s" --prefix=/build

RUN make clean && \
    make -j $(nproc) && \
    make install

RUN mkdir -p /build/version/

RUN date +"Build Timestamp: %Y-%m-%d_%H-%M-%S" > /build/version/ngspice.version
RUN git rev-parse HEAD >> /build/version/ngspice.version
RUN tar -czf /build.tar.gz /build
