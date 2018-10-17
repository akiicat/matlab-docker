FROM ubuntu:16.04

RUN mkdir /app
WORKDIR /app

ENV LD_LIBRARY_PATH=/usr/local/MATLAB/MATLAB_Runtime/v92/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v92/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v92/sys/os/glnxa64:
ENV MCR_PATH=/usr/local/MATLAB/MATLAB_Runtime/v92
CMD ["sh", "run.sh", "/usr/local/MATLAB/MATLAB_Runtime/v92"]


RUN apt-get update && \

 # install matlab require packages
 apt-get install -qqy wget unzip x11-apps && \

 # install matlab relative packages
 apt-get install -qqy libxrandr2 && \ 

 # download and install matlab
 wget http://ssd.mathworks.com/supportfiles/downloads/R2017a/deployment_files/R2017a/installers/glnxa64/MCR_R2017a_glnxa64_installer.zip && \
 unzip MCR_R2017a_glnxa64_installer.zip && \
 ./install -mode silent -agreeToLicense yes && \
 rm -rf /app/*

