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

## Kubernetes Parallel Jobs

```shell
git clone https://github.com/akiicat/matlab-docker.git
cd matlab-docker/helloworld
```

有兩個地方需要注意：

- 需要手動幫 matlab 的執行檔，加上執行的權限
- 把運行的 shell script 檔案命名成 `run.sh`

```shell
chmod +x hellotest
mv <your-matlab-shell-script> run.sh
```

建立在 matlab 裡面建立 Dockerfile，如果有缺少套件的話可以使用 `apt-get` 安裝，最後把當前資料夾下的檔案複製到容器裡面。

```shell
# matlab-docker/helloworld/Dockerfile
FROM akiicat/matlab-docker

# RUN apt-get install -qqy <missing-library>

ADD . / /app/
```

Build docker images，命名為 `gcr.io/<your-gcp-project-id>/matlab`，然後要把 `<your-gcp-project-id>` 改成 GCP 專案的 id。

```shell
docker build -t gcr.io/<your-gcp-project-id>/matlab:v1 .
docker build -t gcr.io/sunlit-inquiry-164609/matlab:v1 .
```

在本地端測試運行

```shell
docker run --rm -ti gcr.io/sunlit-inquiry-164609/matlab:v1
```

推到 gcloud docker registrory：

```shell
gcloud docker -- push gcr.io/<your-gcp-project-id>/matlab:v1
gcloud docker -- push gcr.io/sunlit-inquiry-164609/matlab:v1
```

設定 Kubernets configuration

```shell
gcloud container clusters \
    get-credentials <cluster-name> \
    --zone <cluster-zone>
```

使用 Kubernetes 同時運行 Matlab Jobs

- `parallelism`：同時運行的 jobs 數
- `completions`：完成的 jobs 數
- `image`：設定剛剛所使用 docker images

```shell
# config.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: matlab-parallel
  labels:
    chapter: jobs
spec:
  parallelism: 2
  completions: 3
  template:
    metadata:
      labels:
        chapter: jobs
    spec:
      containers:
      - name: matlab
        image: gcr.io/sunlit-inquiry-164609/matlab:v1
        imagePullPolicy: Always
      restartPolicy: OnFailure
```

運行 Jobs

```shell
kubectl apply -f config.yaml
```
