# 리눅스 운영체제 설치

- 가상 머신 구축 시스템 설치: Virtualbox
- CLI 기반 가상 머신 관리 도구 설치: Vagrant
- 가상 머신 생성 및 설정

## Virtualbox 설치

- [Virtualbox 사이트](https://www.virtualbox.org/) 접속
- Downloads/호스트 OS에 맞는 패키지 다운로드
- Virtualbox 설치

## Vagrant 설치

- [Vagrant 사이트](https://www.vagrantup.com/) 접속
- Download 클릭
- 호스트 OS에 맞춰서 설치
  - 예) macOS: `brew install vagrant`
  - 예) Windows: 다운로드 후 설치
- 설치 확인

```bash
$ vagrant -v
```

## 가상 머신 생성

가상 머신 프로젝트 폴더 생성
```bash
~$ mkdir vm
~$ cd vm
~/vm$ mkdir centos
~/vm$ cd centos
~/vm/centos$ 
```

Variant Box(가상머신 이미지) 찾기
- [가상머신이미지 저장소 사이트](https://app.vagrantup.com/) 접속
- 'centos' 검색
- 'centos/7'의 'virtualbox' 링크 선택

'Centos 7버전' 가상 머신에 대한 Vagrant 설정 파일(Vagrantfile) 준비
```bash
~/vm/centos$ vagrant init centos/7
~/vm/centos$ cat Vagrantfile
Vagrant.configure("2") do |config|
  # ...
end
```

Variantfile 설저에 따라 가상 머신 이미지 다운로드 및 VM 생성
```bash
~/vm/centos$ vagrant up
```

가상 머신에 ssh 접속
```bash
~/vm/centos$ vagrant ssh
```

