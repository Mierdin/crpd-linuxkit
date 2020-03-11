FROM crpd:latest

ADD launch.sh /
ADD sshd_config /

ADD juniper.conf /
# ADD license.conf /

RUN echo 'root:Password1!' | chpasswd

CMD ["bash", "/launch.sh"]