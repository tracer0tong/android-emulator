# Android development environment for ubuntu precise (12.04 LTS) (i386).
# version 0.0.4

# Start with ubuntu 12.04 (i386).
FROM ubuntu:12.04

MAINTAINER tracer0tong <yuriy.leonychev@gmail.com>

# Specially for SSH access and port redirection
ENV ROOTPASSWORD android

# Expose ADB, ADB control and VNC ports
EXPOSE 22
EXPOSE 5037
EXPOSE 5554
EXPOSE 5555
EXPOSE 5900

ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

# Update packages
RUN apt-get -y update

# First, install add-apt-repository, sshd and bzip2
RUN apt-get -y install python-software-properties bzip2 ssh net-tools

# Add oracle-jdk7 to repositories
RUN add-apt-repository ppa:webupd8team/java

# Make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update apt
RUN apt-get update

# Install oracle-jdk7
RUN apt-get -y install oracle-java7-installer

# Install android sdk
RUN wget http://dl.google.com/android/android-sdk_r23-linux.tgz
RUN tar -xvzf android-sdk_r23-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk

# Install apache ant
RUN wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.8.4-bin.tar.gz
RUN tar -xvzf apache-ant-1.8.4-bin.tar.gz
RUN mv apache-ant-1.8.4 /usr/local/apache-ant

# Add android tools and platform tools to PATH
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools

# Add ant to PATH
ENV ANT_HOME /usr/local/apache-ant
ENV PATH $PATH:$ANT_HOME/bin

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Remove compressed files.
RUN cd /; rm android-sdk_r23-linux.tgz && rm apache-ant-1.8.4-bin.tar.gz

# Some preparation before update
RUN chown -R root:root /usr/local/android-sdk/

# Install latest android tools and system images
RUN echo "y" | android update sdk --filter platform-tool --no-ui --force
RUN echo "y" | android update sdk --filter platform --no-ui --force
RUN echo "y" | android update sdk --filter build-tools-22.0.1 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-x86-android-19 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-x86-android-21 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-x86-android-22 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-armeabi-v7a-android-19 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-armeabi-v7a-android-21 --no-ui -a
RUN echo "y" | android update sdk --filter sys-img-armeabi-v7a-android-22 --no-ui -a

# Update ADB
RUN echo "y" | android update adb

# Create fake keymap file
RUN mkdir /usr/local/android-sdk/tools/keymaps
RUN touch /usr/local/android-sdk/tools/keymaps/en-us

# Run sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo "root:$ROOTPASSWORD" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Install socat
RUN apt-get install -y socat

# Add entrypoint 
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
