# Python 도구 준비

## pyenv + conda 설치

```bash
# Miniconda를 pyenv로 설치
pyenv install miniconda3-latest
# 또는 특정 버전
pyenv install miniconda3-4.7.12

# 설치된 Python/conda 버전 확인
pyenv versions  

# 글로벌 또는 로컬에서 conda 사용
pyenv global miniconda3-latest
# 또는
pyenv local miniconda3-latest
```

## 프로젝트 전용 파이썬 환경 생성 및 환경 전환

```bash
# 일반 개발 프로젝트
cd my_web_project
pyenv local 3.13.5
python -m venv venv
source venv/bin/activate

# 데이터 사이언스 프로젝트: 직접 환경 생성
cd my_ds_project
conda create --name ds_project python=3.13.5
pyenv local miniconda3-latest/envs/ds_project

# 데이터 사이언스 프로젝트: 매니패스트 파일을 이용하여 환경 생성
cd my_ds_project
conda env create -f environment.yml
pyenv local miniconda3-latest/envs/ds_project

# 기존 환경이 있다면 업데이트
conda env update -n ds_project -f environment.yml
```

### environment.yml 

- 기본 예시
```bash
name: ds_project
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.13.5
  - numpy
  - pandas
  - matplotlib
  - seaborn
  - jupyter
  - scikit-learn
  - requests
  - beautifulsoup4
```

- 고급 예시
```bash
name: ds_project
channels:
  - conda-forge
  - defaults
dependencies:
  - python=3.13.5
  - numpy>=1.24.0
  - pandas>=2.0.0
  - matplotlib>=3.7.0
  - seaborn>=0.12.0
  - jupyter>=1.0.0
  - scikit-learn>=1.3.0
  - pip>=23.0.0
  - pip:
    - streamlit
    - plotly
    - dash
variables:
  - MY_PROJECT_PATH: /path/to/project
```

## 프로젝트 환경에 패키지 설치

```bash
# 기본 miniconda 환경으로 전환
# - conda 명령을 사용하려면 기본 환경으로 전환해야 한다.
pyenv local miniconda3-latest

# ds_project 환경에 패키지 설치
conda install -n ds_project numpy pandas matplotlib seaborn jupyter scikit-learn
# 또는
conda install -n ds_project --file requirements.txt

# 다시 ds_project 환경으로 전환
pyenv local miniconda3-latest/envs/ds_project
```

## 프로젝트 환경 삭제

```bash
# ds_project 환경 자체를 삭제
conda env remove -n ds_project
```

## VSCode에서 Jupyter 노트북 실행

- xxx.ipynb 파일 열기
- 우상단 커널 버튼 클릭
- xxx 환경 선택
