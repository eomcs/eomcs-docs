FROM eclipse-temurin:25-jdk-jammy

# Dockerfile 상단에 추가
LABEL maintainer="jinyoung.eom@gmail.com"
LABEL description="Java Vibe Coding Environment with Claude Code CLI"
LABEL version="1.0"

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    bash-completion \
    git \
    curl \
    unzip \
    jq \
    nano \
    vim \
    ca-certificates \
    ripgrep \
    tzdata \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 타임존 설정을 별도 레이어로
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 로케일 생성
RUN locale-gen ko_KR.UTF-8
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR:ko
ENV LC_ALL=ko_KR.UTF-8

# nvm 환경 변수 설정
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=24

# nvm 설치 및 Node.js 설치
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . "$NVM_DIR/nvm.sh" \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default

# Maven 설치
ENV MAVEN_VERSION=3.9.11
RUN curl -L -o maven.tar.gz \
    "https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" \
    && tar xzf maven.tar.gz -C /usr/local \
    && ln -s "/usr/local/apache-maven-${MAVEN_VERSION}" /usr/local/maven \
    && rm maven.tar.gz

ENV PATH="/usr/local/maven/bin:${PATH}"

# Gradle 최신 버전 자동 설치
RUN set -eux; \
    GRADLE_LATEST="$(curl -s https://services.gradle.org/versions/current | jq -r '.version')" ; \
    echo "Installing Gradle ${GRADLE_LATEST}" ; \
    curl -L -o gradle.zip "https://services.gradle.org/distributions/gradle-${GRADLE_LATEST}-bin.zip" ; \
    mkdir -p /usr/local/gradle ; \
    unzip -q gradle.zip -d /usr/local/gradle ; \
    ln -s "/usr/local/gradle/gradle-${GRADLE_LATEST}" /usr/local/gradle/gradle-latest ; \
    rm gradle.zip

ENV PATH="/usr/local/gradle/gradle-latest/bin:${PATH}"

# Claude Code CLI 설치
RUN curl -fsSL https://claude.ai/install.sh | bash

# Claude Code 기본 설정 디렉토리 생성
RUN mkdir -p /root/.claude

# OpenAI Codex CLI 설치
RUN . "$NVM_DIR/nvm.sh" && npm install -g @openai/codex

# Google Gemini CLI 설치
RUN . "$NVM_DIR/nvm.sh" && npm install -g @google/gemini-cli

# Cursor CLI 설치
RUN curl https://cursor.com/install -fsS | bash

# PATH에 Claude Code 추가
ENV PATH="/root/.local/bin:${PATH}"

# Gradle 설정 디렉토리 생성 및 최적화
RUN mkdir -p /root/.gradle && \
    echo "org.gradle.daemon=true" > /root/.gradle/gradle.properties && \
    echo "org.gradle.parallel=true" >> /root/.gradle/gradle.properties && \
    echo "org.gradle.caching=true" >> /root/.gradle/gradle.properties && \
    echo "org.gradle.configureondemand=true" >> /root/.gradle/gradle.properties

# Maven 설정 디렉토리 생성 및 최적화 (Gradle 설정 다음에)
RUN mkdir -p /root/.m2 && \
    echo '<settings>' > /root/.m2/settings.xml && \
    echo '  <localRepository>/root/.m2/repository</localRepository>' >> /root/.m2/settings.xml && \
    echo '</settings>' >> /root/.m2/settings.xml

# Git 기본 설정 (선택사항)
RUN git config --global init.defaultBranch main

# bash 설정
RUN echo '[ -f /etc/bash_completion ] && . /etc/bash_completion' >> /root/.bashrc && \
    echo "alias ll='ls -alh'" >> /root/.bashrc && \
    echo "alias g='gradle'" >> /root/.bashrc && \
    echo "alias gt='gradle test'" >> /root/.bashrc && \
    echo "alias gb='gradle build'" >> /root/.bashrc && \
    echo "alias m='mvn'" >> /root/.bashrc && \
    echo "alias mci='mvn clean install'" >> /root/.bashrc && \
    echo "alias mt='mvn test'" >> /root/.bashrc

# Java 관련 환경 변수 (선택사항)
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# 설치된 도구 버전 확인 (디버깅용)
RUN echo "=== Installed Versions ===" && \
    java -version && \
    . "$NVM_DIR/nvm.sh" && node --version && \
    . "$NVM_DIR/nvm.sh" && npm --version && \
    . "$NVM_DIR/nvm.sh" && nvm current && \
    mvn -version && \
    gradle -version && \
    claude --version && \
    . "$NVM_DIR/nvm.sh" && codex --version && \
    . "$NVM_DIR/nvm.sh" && gemini --version && \
    cursor-agent --version && \
    git --version

HEALTHCHECK --interval=30s --timeout=3s \
    CMD java -version && gradle --version && mvn --version || exit 1

CMD ["bash"]
