FROM crpd:19.4R1.10

ADD launch.sh /

RUN echo 'root:juniper' | chpasswd

CMD ["bash", "/launch.sh"]