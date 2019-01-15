FROM ubuntu:bionic

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
        openjdk-8-jdk-headless \
        git-core \
        curl \
        wget \
        gnupg \
        openssh-client \
        build-essential &&\
    curl -sL https://deb.nodesource.com/setup_8.x | bash - &&\
    apt-get install -y nodejs &&\
    wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp &&\
    tar xf /tmp/apache-maven-*.tar.gz -C /opt &&\
    ln -s /opt/apache-maven-3.6.0 /opt/maven &&\
    ln -snf /usr/share/zoneinfo/America/Chicago /etc/localtime && echo 'America/Chicago' > /etc/timezone &&\
    apt-get -y autoremove && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

RUN ln -svT "/usr/lib/jvm/java-8-openjdk-$(dpkg --print-architecture)" /opt/java-home

ENV JAVA_HOME=/opt/java-home
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}

# node-sass C library for arm is not availabe for download. During npm install, the library will be built locally, which takes really long time.
# So built the library first, then make it available locally via env variable SASS_BINARY_PATH in the build container.
RUN mkdir /node-sass
COPY node-sass/linux-arm-57-binding.node /node-sass

