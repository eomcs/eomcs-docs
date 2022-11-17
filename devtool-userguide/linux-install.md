# 리눅스 운영체제 설치

- 가상 머신 구축 시스템 설치: Virtualbox
- CLI 기반 가상 머신 관리 도구 설치: Vagrant
- 가상 머신 생성 및 설정

## 도구  준비

### Virtualbox 설치

- [Virtualbox 사이트](https://www.virtualbox.org/) 접속
- Downloads/호스트 OS에 맞는 패키지 다운로드
- Virtualbox 설치

### Vagrant 설치

- [Vagrant 사이트](https://www.vagrantup.com/) 접속
- Download 클릭
- 호스트 OS에 맞춰서 설치
  - 예) macOS: `brew install vagrant`
  - 예) Windows: 다운로드 후 설치
- 설치 확인

```bash
$ vagrant -v
```

## VirtualBox 가상 머신 관리

### 가상 머신 프로젝트 폴더 생성

```bash
~$ mkdir vm
~$ cd vm
~/vm$ mkdir centos
~/vm$ cd centos
~/vm/centos$ 
```

### Variant Box(가상머신 이미지) 찾기

- [가상머신이미지 저장소 사이트](https://app.vagrantup.com/) 접속
- 'centos' 검색
- 'centos/7'의 'virtualbox' 링크 선택

### Vagrant 설정 파일(Vagrantfile) 준비

```bash
~/vm/centos$ vagrant init centos/7
~/vm/centos$ cat Vagrantfile
Vagrant.configure("2") do |config|
  # ...
end
```

### Box 다운로드 및 VM 생성, 실행

```bash
~/vm/centos$ vagrant up
```

### 가상 머신에 ssh 접속

```bash
~/vm/centos$ vagrant ssh
```

### VM 정지

```bash
~/vm/centos$ vagrant halt
```

### VM 삭제

```bash
~/vm/centos$ vagrant destroy
```

## Vagrantfile

### 클라우드에서 가져올 box 이름 지정하기

```
# https://vagrantcloud.com/search 사이트에서 box를 검색 할 수 있다.
config.vm.box = "box 이름"

예) config.vm.box = "centos/7"
```

### 호스트 이름 설정하기 

```
# /etc/hosts 파일에 등록될 이름을 지정할 수 있다.
config.vm.hostname = "호스트명"

예) config.vm.hostname = "myhost.localhost"
```

### 퍼블릭 네트워크 설정하기

```
config.vm.network "public_network", bridge: "en2: Wi-Fi (AirPort)"
```

### 프라이빗 네트워크 설정하기

```
# DHCP 
config.vm.network "private_network", type: "dhcp"

# 고정 IP
config.vm.network "private_network", ip: "192.168.56.2"
```

### VM을 여러 개 설정하기

```
Vagrant.configure("2") do |config|
  
  config.vm.provision "shell", inline: "echo Hello"

  config.vm.define "web" do |web|
    web.vm.box = "centos/7"
  end

  config.vm.define "db" do |db|
    db.vm.box = "centos/7"
  end

end
```

## Box 다루기

### Vagrant에 설치된 박스 목록 보기

```bash
$ vagrant box list
```

### Vagrant에 박스 추가하기

```bash
$ vagrant box add "Vagrant public catalog에 등록된 박스이름"
예) 
$ vagrant box add "centos/7"
```

```bash
$ vagrant box add "파일 경로 및 URL" --name "박스이름"
예) 
$ vagrant box add "./CentOS-7-x86_64--.box" --name "mycentos/7"
```

### Vagrant에 등록된 박스 제거하기

```bash
$ vagrant box remove "박스이름"
예) 
$ vagrant box remove "mycentos/7"
```

### VM을 Box로 만들기(Box 로 내보내기)

```bash
$ vagrant package
```


## 실행 중인 Vagrant 머신에 접속하기

### 현재 프로젝트의 머신에 SSH 접속하기

```bash
$ vagrant ssh

또는

$ vagrant ssh default
```

### 현재 프로젝트의 머신 상태 알아내기

```bash
$ vagrant status
Current machine states:

node1                     running (virtualbox)
node2                     running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state.

# 실행 중인 머신 접속하기
$ vagrant ssh node1
```

### 다른 프로젝트를 포함하여 머신 상태 알아내기

```bash
$ vagrant global-status
id       name    provider   state   directory                             
--------------------------------------------------------------------------
f483730  default virtualbox running /Users/eomjinyoung/virtualbox/cenos   
a3aafac  default virtualbox running /Users/eomjinyoung/virtualbox/centos2 
 
...

# 실행 중인 머신 접속하기
$ vagrant ssh a3aafac
```

### ssh 로 직접 접속하기

```bash
$ ssh -i .vagrant/machines/default/virtualbox/private_key vagrant@IP주소
```






