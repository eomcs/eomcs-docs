# VSCode 파이썬 개발 환경 설정 가이드

## 1. 플러그인 설치

- 파이썬 기본 플러그인
  - Python(Microsoft)
  - Python Debugger(Microsoft)
  - Python Environments(Microsoft)
- 파이썬 포맷터 + 린터 플러그인
  - Ruff(Astral Software)
- 파이썬 타입 검사기 플러그인
  - Pylance(Microsoft)
- jupyter 노트북 플러그인
  - Jupyter(Microsoft)
  - Jupyter Cell Tags(Microsoft)
  - Jupyter Keymap(Microsoft)
  - Jupyter Notebook Renderers(Microsoft)
  - Jupyter Slide Show(Microsoft)

## 2. 설정하기(settings.json) 

```json
{
  "[python]": {
    //"editor.defaultFormatter": "ms-python.black-formatter",
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": "explicit",
      "source.organizeImports": "explicit"
    },
    "editor.rulers": [
      72, // docstring과 주석 줄 길이
      88  // 코드 줄 길이
    ]
  },

  "ruff.lint.select": [
    "E",  // pycodestyle errors(기본 문법 오류, 들여쓰기, 공백 등)
    "F"   // Pyflakes(논리적 오류)
  ],

  // for Jupyter Notebooks
  "notebook.codeActionsOnSave": {
    "notebook.source.fixAll": "explicit",
    "notebook.source.organizeImports": "explicit"
  },

  // Pylance 타입 검사기 설정
  "python.analysis.typeCheckingMode": "basic",
  //"python.analysis.autoSearchPaths": true,
  //"python.analysis.useLibraryCodeForTypes": true
}
```

## 3. CLI 도구 설치

- Ruff → 코드 스타일/포맷/린트
- Pyright → 타입 검사

### Ruff 사용법

```bash
# Ruff 설치
pip install ruff

# 전체 프로젝트 검사
ruff check .

# 자동 수정(권장)
ruff check . --fix

# 포맷팅 기능 사용 (Black 대체 가능)
ruff format .

# 특정 파일만 검사
ruff check app/main.py
```

### Pyright 사용법

```bash
# Pyright는 Node 기반으로 제공되므로 npm 설치가 가장 공식적이다.
npm install -g pyright

# 설치 확인
pyright --version

# 전체 프로젝트 타입 검사
# - Pyright는 자동으로 pyproject.toml 또는 pyrightconfig.json을 읽습니다.
pyright

# 특정 파일만 타입 검사
pyright main.py
```

- strict 모드로 검사하고 싶다면, 프로젝트 루트에 `pyrightconfig.json` 파일을 생성한 후 다음 내용을 추가한다.
```json
{
  "typeCheckingMode": "strict",
  "reportMissingImports": true,
  "reportUnusedVariable": true
}
```

- pyproject.toml 통합 설정 (권장)
  - Pyright는 기본적으로 pyproject.toml 도 읽을 수 있지만,
  - 실무에서는 `pyrightconfig.json`을 분리하는 것이 일반적입니다.
```toml
[tool.ruff]
line-length = 88
select = ["E", "F", "I", "UP"]  # 기본 린트 + import + pyupgrade
ignore = ["E501"]  # 줄 길이 제한은 formatter가 처리
exclude = ["venv", ".git"]

[tool.ruff.format]
# Black 스타일과 호환
quote-style = "double"
indent-style = "space"
```