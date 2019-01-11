FROM ubuntu:bionic

RUN apt-get update &&\
  apt-get install -y --no-install-recommends openjdk-8-jdk-headless git-core curl wget gnupg &&\
  curl -sL https://deb.nodesource.com/setup_8.x | bash - &&\
  apt-get install -y nodejs &&\
  wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp &&\
  tar xf /tmp/apache-maven-*.tar.gz -C /opt &&\
  ln -s /opt/apache-maven-3.6.0 /opt/maven &&\
  ln -snf /usr/share/zoneinfo/America/Chicago /etc/localtime && echo 'America/Chicago' > /etc/timezone &&\
  apt-get -y autoremove && apt-get -y clean && \
  rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

# RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> /etc/profile.d/maven.sh &&\
#  echo 'export M2_HOME=/opt/maven' >> /etc/profile.d/maven.sh &&\
#  echo 'export MAVEN_HOME=/opt/maven' >> /etc/profile.d/maven.sh &&\
#  echo 'export PATH=${M2_HOME}/bin:${PATH}' >> /etc/profile.d/maven.sh &&\
#  chmod +x /etc/profile.d/maven.sh &&\
#  . /etc/profile.d/maven.sh

RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /opt/java-home

ENV JAVA_HOME=/opt/java-home
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
