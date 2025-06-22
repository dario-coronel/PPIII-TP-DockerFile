FROM debian:latest

MAINTAINER Dario <dario.coronel@gmail.com>

RUN apt-get update && apt-get -y upgrade && apt-get clean
