# We Use an official ubuntu 18.04 runtime as a parent image
FROM ubuntu:18.04
# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1
# Add django allowed host via environment
ENV ALLOWED_HOST localhost
# Install PIP3
RUN apt update && apt install -y \
    python3-pip
# create root directory for our project in the container
RUN mkdir /MyWebService
# Set the working directory to /music_service
WORKDIR /MyWebService
# Copy the current directory contents into the container at /music_service
ADD . /MyWebService/
# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 8000
CMD exec gunicorn DjangoDocker.wsgi:application -b '[::]:8000'

