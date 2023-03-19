# 도커 사용법

## 도커 설치

### 기존 설치 제거

`$ sudo apt remove docker docker-engine docker.io containerd runc`

기존에 저장된 도커 오브젝트(images, containers, volumes, network) 제거
`$ sudo rm -rf /var/lib/docker`
`$ sudo rm -rf /var/lib/containerd`

### 도커 설치 스크립트 다운로드

`$ sudo apt-get update`
`$ sudo apt-get install curl`
`$ curl https://get.docker.com > docker-install.sh`
`$ chomd 755 docker-install.sh`

### 도커 설치

`$ sudo ./docker-install.sh`

## 도커 컨테이너 다루기

### 도커 컨테이너 생성 및 실행

우분투 14.04 컨테이너 생성

- `$ sudo docker run -i -t ubuntu:14.04`
- `-i` : 상호 입출력 하겠다고 설정
- `-t` : tty를 활성화해서 bash 셸을 사용하도록 설정

컨테이터 나가기 및 종료

- `$ exit` 또는 Ctrl + D : 배시셸을 종료함으로써 컨테이너를 정지시킨다.
- Ctrl + P 다음에 Ctrl + Q: 단순히 컨테이너의 셸만 빠져나온다.

### 도커 컨테이너 실행 세부 단계

도커 이미지 내려받기

- `$ sudo docker pull centos:7`

도커 이미지 목록 확인하기

- `$ sudo docker images`

도커 이미지로 컨테이너 생성하기

- `$ sudo docker create -i -t --name mycentos centos:7`

도커 컨테이너 실행하기

- `$ sudo docker start mycentos`
- `$ sudo docker start 해시아이디일부분`

도커 컨테이너에 들어가기

- `$ sudo docker attach mycentos`

정리

- `docker run`
  - 이미지 없으면 `docker pull`
  - `docker create -i -t`
  - `docker start`
  - `docker attach` : -i -t 옵션을 사용했을 때
- `docker create`
  - 이미지 없으면 `docker pull`
  - `docker create -i -t`

### 도커 컨테이너 목록 확인

실행 중인 컨테이너 목록 보기

- `$ sudo docker ps`

모든 컨테이너 목록 보기

- `$ sudo docker ps -a`
  - CONTAINER ID: 컨테이너에 자동 할당되는 고유한 ID.
    - `$ sudo docker inspect 컨테이너이름 | grep Id` : 컨테이너 ID 전체 보기
  - IMAGE: 컨테이너 이미지 이름
  - COMMAND: 컨테이너가 시작될 때 실행될 명령
  - CREATED: 컨테이너가 생성된 후 흐른 시간
  - STATUS: 컨테이너 상태. Up(실행중), Exited(종료), Pause(중지)
  - PORTS: 컨테이너가 개방한 포트와 호스트에 연결한 포트. 외부에 노출하도록 설정하지 않았다면 출력 내용 없음.
  - NAMES: 컨테이너의 고유한 이름. --name 옵션으로 설정한 이름. 설정하지 않으면 형용사와 명사를 사용해 무작위 생성.
    - `$ sudo docker rename 무작위이름 새이름`

### 도커 컨테이너 삭제

사용하지 않는 컨테이너 삭제하기

- `$ sudo docker rm epic_dubinsky`

실행 중인 컨테이너 삭제하기

- `$ sudo docker stop mycentos` : 실행 중인 컨테이너 정지시키기
- `$ sudo docker rm mycentos` : 컨테이너 삭제하기

또는 `-f` 옵션을 사용하여 종료와 삭제를 한 번에 처리하기

- `$ sudo docker rm -f mycentos`

정지된 모든 컨테이너 삭제하기

- `$ sudo docker container prune`

실행 중인 컨테이너 모두 정지 후 삭제하기

- `$ sudo docker stop $(sudo docker ps -a -q)`
- `$ sudo docker rm $(sudo docker ps -a -q)`

### 도커 컨테이너를 외부에 노출하기

도커가 설치된 호스트에서만 접근 가능

- `$ sudo docker run -i -t --name network_test ubuntu:14.04`
  - NIC 확인: `# ifconfig`

컨테이너를 노출 시키기

- `$ sudo docker run -i -t --name mywebserver -p 80:80 ubuntu:14.04`
  - `-p 호스트포트:컨테이너포트`
  - 여러 개의 포트 노출: `-p` 옵션을 여러 개 삽입

컨테이너에 아파치 웹 서버 설치 및 시작시키기

- `root@xxx# apt-get update`
- `root@xxx# apt-get install apache2 -y`
- `root@xxx# service apache2 start`

컨테이너를 실행하고 있는 호스트로 접속하기

- `http://vagrant리눅스IP/`
  - vagrant ssh 밖에서 실행할 것
