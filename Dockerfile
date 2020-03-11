FROM crpd:latest

ADD launch.sh /
ADD sshd_config /

ADD juniper.conf /
# ADD license.conf /

# Add antidote user
# (Note that this, as well as the "antidotepassword" password are for NRE labs.
# You can use whatever auth you wish for your own purposes)
RUN mkdir -p /home/antidote
RUN useradd antidote -p antidotepassword
RUN chown antidote:antidote /home/antidote
RUN chsh antidote --shell=/bin/bash
RUN echo 'antidote:antidotepassword' | chpasswd

RUN echo 'root:antidotepassword' | chpasswd

CMD ["bash", "/launch.sh"]