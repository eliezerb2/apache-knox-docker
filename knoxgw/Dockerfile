FROM openjdk:8-jre AS openjdk
LABEL forked_from_maintainer="Dennis Pfisterer, http://www.dennis-pfisterer.de"
# Prepare the container and install required software
RUN apt-get update && \
    apt-get install -y expect net-tools procps sudo unzip wget xtail && \
    apt-get clean

FROM openjdk AS knox_base
ARG knox_release_mirror=https://downloads.apache.org
ARG knox_version=1.3.0
ENV KNOX_RELEASE_MIRROR=${knox_release_mirror}
ENV KNOX_VERSION=${knox_version}
WORKDIR /opt
RUN wget -q -O knox.zip ${KNOX_RELEASE_MIRROR}/knox/${KNOX_VERSION}/knox-${KNOX_VERSION}.zip && \
    unzip knox.zip && \
    rm knox.zip

FROM knox_base AS knox
ARG knox_user_group=knox
ARG knox_user=knox
ARG knox_internal_port=8443
ARG knox_admin_user=admin
ENV KNOX_USER_GROUP=${knox_user_group}
ENV KNOX_USER=${knox_user}
ENV GATEWAY_HOME=/opt/knox-${KNOX_VERSION}
ENV KNOX_INTERNAL_PORT=${knox_internal_port}
ENV KNOX_ADMIN_USER=${knox_admin_user}

# Create a non-root user to run knox
RUN groupadd -r ${KNOX_USER_GROUP} && \
    useradd --no-log-init -r -g ${KNOX_USER_GROUP} ${KNOX_USER}
RUN adduser ${KNOX_USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Grant permissions recursively for all users to read, write and execute on relevant folders
RUN chmod -R a+rwx /opt
RUN chmod -R a+rwx /etc/ssl

# Copy scripts
COPY knox-pw.expect /tmp
COPY run-knox.sh /opt

# Enable mounting an external config
#!VOLUME /opt/knox/conf

# Expose the port
EXPOSE ${KNOX_INTERNAL_PORT}

# Switch to knox user, before running the knox scripts
USER ${KNOX_USER}

# Create credentials
RUN expect /tmp/knox-pw.expect

# Start knox
WORKDIR $GATEWAY_HOME
CMD ["/opt/run-knox.sh"]

FROM knox AS knoxgw

ARG service_name=servicea
ARG service_role=SERVICEA
ARG service_version=0.0.1
ENV SERVICE_NAME=${service_name}
ENV SERVICE_ROLE=${service_role}
ENV SERVICE_VERSION=${service_version}

# copy service files
ENV SERVICE_RELATIVE_PATH=${SERVICE_NAME}/${SERVICE_VERSION}
ENV SERVICE_FULL_PATH=${GATEWAY_HOME}/data/services/${SERVICE_RELATIVE_PATH}/
RUN mkdir -p ${SERVICE_FULL_PATH}/
COPY services/${SERVICE_RELATIVE_PATH} ${SERVICE_FULL_PATH}/

# add service to topology
COPY topologies ${GATEWAY_HOME}/conf/topologies/
