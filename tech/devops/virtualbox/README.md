# VirtualBox 기반 CI/CD

## 준비 

### VirtualBox 설치

[VirtualBox 안내서](../../../userguide/virtualbox-userguide.md)에 따라 설치 및 설정한다.

### Vagrant 설치

[Vagrant 안내서](../../../userguide/vagrant-userguide.md)에 따라 설치 및 설정한다.

### 작업 폴더 생성

**CI/CD 작업 폴더 생성:**

```bash
mkdir cicd-study
cd cicd-study
```

## Jenkins 서버 구축

**폴더 생성:**

```bash
mkdir jenkins
cd jenkins
```

**Vagrantfile 생성:**

```bash
vagrant init
```

**Vagrantfile 편집:**

```Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"

  config.vm.hostname = "jenkins"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "jenkins"
    vb.memory = 2048
    vb.cpus = 2
  end
end
```

**가상 머신 실행:**

```bash
vagrant up
```

