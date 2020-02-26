FROM continuumio/miniconda3
COPY . /usr/src/
WORKDIR /usr/src/
RUN make install
EXPOSE 5000
CMD make
