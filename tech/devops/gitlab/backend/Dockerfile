# Java 17 이미지 사용
FROM eclipse-temurin:17-jdk

# 작업 디렉토리 생성
WORKDIR /app

# 환경 변수 설정
ENV APP_NAME=hello-api

# JAR 파일 복사
COPY ./app/build/libs/hello-api.jar app.jar

# 실행 명령
ENTRYPOINT ["sh", "-c", "java -jar app.jar --spring.profiles.active=prod"]
