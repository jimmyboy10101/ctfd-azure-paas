FROM ctfd/ctfd:3.5.1

USER root
RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN wget --progress=dot:giga https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem -P /opt/certificates/

USER 1001
EXPOSE 8000

# Clone the GitHub repository and copy the files to the desired location
RUN git clone https://github.com/apt-42/apt42_ctfd_themes.git /tmp/apt42_ctfd_themes \
    && mkdir -p ./CTFd/themes/apt42/ \
    && cp -r /tmp/apt42_ctfd_themes/* ./CTFd/themes/apt42/ \
    && rm -rf /tmp/apt42_ctfd_themes

RUN ls -R

ENTRYPOINT ["/opt/CTFd/docker-entrypoint.sh"]
