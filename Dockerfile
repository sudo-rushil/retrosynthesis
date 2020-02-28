FROM continuumio/miniconda3
COPY . /usr/src/
WORKDIR /usr/src/
RUN apt-get update && apt-get clean
RUN apt-get install make && apt install nodejs -y curl && curl -L https://npmjs.org/install.sh | sh
RUN make install
RUN make installother
EXPOSE 5050 8080
CMD make run
