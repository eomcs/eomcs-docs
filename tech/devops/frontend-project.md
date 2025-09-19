# 프론트엔드 프로젝트

### .env.* 파일 설정

- `.env.development` 파일에 REST API 서버 주소를 등록한다.

```properties
NEXT_PUBLIC_REST_API_URL=http://localhost:9090
```

- `.env.production` 파일에 REST API 서버 주소를 등록한다.

```properties
NEXT_PUBLIC_REST_API_URL=http://localhost:8080
```

## 빌드 및 실행

### 의존 모듈 설치

```bash
npm install
```

### `npm` 으로 실행

- 개발 모드로 실행(포트번호: 9090)
  - `.env.development` 설정 파일 로딩

```bash
npm run dev
```

- 제품 모드로 실행(포트번호: 8080)
  - `.env.production` 설정 파일 로딩

```bash
npm run build # 빌드를 먼저 해야 한다.
npm run start
```

### `node` 로 직접 실행

```bash
npm run build # 빌드를 먼저 해야 한다.

# 빌드된 파일을 server.js 파일이 있는 .next/ 디렉토리에 복사한다.
cp -r .next/static .next/standalone/.next/ 
node .next/standalone/server.js
```
