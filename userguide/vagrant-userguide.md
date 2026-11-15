# Vagrant 사용 안내

## 설치

https://developer.hashicorp.com/vagrant 사이트의 안내에 따라 설치한다.

## Vagrantfile 준비

작업 디렉토리 생성:

```bash
mkdir vagrant-lab
cd vagrant-lab
```

Vagrantfile 생성:

```bash
vagrant init
```

Vagrantfile 편집:

```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.box_version = "202510.26.0"
  config.vm.hostname = "vagrant-lab"
end
```

## Vagrant 기본 사용법

VM 시작:

```bash
vagrant up
```

VM 접속:

```bash
vagrant ssh
``` 

VM 종료:

```bash
vagrant halt
``` 

VM 삭제:

```bash
vagrant destroy
``` 

