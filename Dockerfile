FROM crpd:19.4R1.10

ADD launch.sh /
ADD sshd_config /

ADD juniper.conf /
ADD license.conf /

# ADD crpd01.conf /config/juniper.conf
# RUN gzip /config/juniper.conf
# RUN ls -lha /config

RUN echo 'root:antidotepassword' | chpasswd

CMD ["bash", "/launch.sh"]