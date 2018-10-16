# Matlab Docker

Matlab Version R2017a

## Get Images

### Build by yourself

```shell
git clone https://github.com/akiicat/matlab-docker.git
cd matlab-docker
docker build -t matlab-docker .
```

### Pull from Docker Hub

```shell
docker pull akiicat/matlab-docker
```

## Run Jobs

### Sample: Hello World

在 Container 裡面的 MCR 路徑是 `/usr/local/MATLAB/MATLAB_Runtime/v92`，執行時要將這個路徑傳入。

```shell
cd helloworld
chmod +x helloworld
export DOCKER_MCR_ROOT=/usr/local/MATLAB/MATLAB_Runtime/v92
docker run --rm -it -v $(pwd):/app matlab-docker sh run_hellotest.sh $DOCKER_MCR_ROOT
```

執行結果

```shell
$ docker run --rm -it -v $(pwd):/app matlab:0.0.5 sh run_hellotest.sh $DOCKER_MCR_ROOT
------------------------------------------
Setting up environment variables
---
LD_LIBRARY_PATH is .:/usr/local/MATLAB/MATLAB_Runtime/v92/runtime/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v92/bin/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v92/sys/os/glnxa64:/usr/local/MATLAB/MATLAB_Runtime/v92/sys/opengl/lib/glnxa64
hello world!
```

## Run Jobs from Docker Hub

```shell
cd helloworld
chmod +x helloworld
export DOCKER_MCR_ROOT=/usr/local/MATLAB/MATLAB_Runtime/v92
docker run --rm -it -v $(pwd):/app akiicat/matlab-docker sh run_hellotest.sh $DOCKER_MCR_ROOT
````
