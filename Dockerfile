FROM continuumio/miniconda3
COPY . /usr/src/
WORKDIR /usr/src/
RUN apt-get update
RUN apt-get install make
RUN apt install nodejs -y curl
RUN curl -L https://npmjs.org/install.sh | sh
RUN make install
EXPOSE 5000 8080 5001
CMD make run
