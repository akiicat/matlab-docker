# Matlab Docker

Matlab Version R2017a

## Usage

```shell
git clone https://github.com/akiicat/matlab-docker.git
cd matlab-docker/helloworld
chmod +x hellotest
```

Run hello world in oneline.

```shell
docker run --rm -it -v $(pwd):/app akiicat/matlab-docker sh run_hellotest.sh /usr/local/MATLAB/MATLAB_Runtime/v92
```

Run your matlab task.

```shell
docker run --rm -it -v $(pwd):/app akiicat/matlab-docker sh <your-matlab-shell-script> /usr/local/MATLAB/MATLAB_Runtime/v92
```

## Build custom version and package

```shell
git clone https://github.com/akiicat/matlab-docker.git
cd matlab-docker
```

If you want to build custom versions, replace the string `R2017a` in `Dockerfile` to the version specified on [matlab website](https://ch.mathworks.com/products/compiler/matlab-runtime.html).

If some packages are not found, add packages at the end of the line `apt-get install -qqy` in `Dockerfile`.

Build docker images which name is called `matlab`.

```shell
docker build -t matlab .
```

Run Hello World Sample

在 Container 裡面的 MCR 路徑是 `/usr/local/MATLAB/MATLAB_Runtime/v92`，執行時要將這個路徑傳入。

```shell
docker run --rm -it -v $(pwd):/app matlab sh run_hellotest.sh /usr/local/MATLAB/MATLAB_Runtime/v92
```

