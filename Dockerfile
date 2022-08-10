FROM Admon
USER root
RUN apt-get install -y wget
RUN apt-get install -y nmap
RUN wget https://releases.hashicorp.com/terraform/1.2.6/terraform_1.2.6_linux_amd64.zip
RUN unzip terraform_*
RUN rm terraform_*
RUN mv terraform /usr/local/bin/
