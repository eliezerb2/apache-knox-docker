FROM openjdk:8-jre AS openjdk
LABEL forked_from_maintainer="Dennis Pfisterer, http://www.dennis-pfisterer.de"
# Prepare the container and install required software
RUN apt-get update && \
    apt-get install -y expect net-tools procps sudo unzip wget xtail && \
    apt-get clean

FROM openjdk AS knox_base
# The version of Apache Knox to use
ENV KNOX_VERSION 1.3.0
WORKDIR /opt
RUN wget -q -O knox.zip https://downloads.apache.org/knox/${KNOX_VERSION}/knox-${KNOX_VERSION}.zip && \
    unzip knox.zip && \
    rm knox.zip

FROM knox_base AS knox

# Create a non-root user to run knox
RUN groupadd -r knox && \
    useradd --no-log-init -r -g knox knox
RUN adduser knox sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Grant permissions recursively on /opt for all users to read, write and execute
RUN chmod -R a+rwx /opt

# Link to /opt/knox
RUN ln -s /opt/knox-${KNOX_VERSION} /opt/knox
ENV GATEWAY_HOME /opt/knox/

# Copy scripts
COPY run-knox.sh /opt
COPY knox-pw.expect /tmp

# Enable mounting an external config
VOLUME /opt/knox/conf

# Expose the port
EXPOSE 8080
EXPOSE 8443

USER knox

# Create credentials
RUN expect /tmp/knox-pw.expect

# Start knox
WORKDIR $GATEWAY_HOME
#CMD ["/opt/run-knox.sh"]
#TODO: HEALTHCHECK
