FROM debian:bookworm-slim

LABEL maintainer="your-name"
LABEL description="CUPS Print Server on Raspbian (Raspberry PI)"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \

cups \
cups-client \
cups-pdf \
openssl \
sudo \
passwd \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Create admin user

RUN useradd -m admin && usermod -aG lp,lpadmin admin

# Prepare directories

RUN mkdir -p /etccups/ssl/var/spool/cups-pdf \
 && chmod 700 /etc/cups/ssl

COPY cupsd.conf /etc/cups/cupsd.conf
COPY printers.conf /etc/cups/printers.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 631

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/sbin/cupsd","-f"]
``
