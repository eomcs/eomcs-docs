# 클라우드 네이티브 개발자 과정

## 모놀리식 기반 레거시 시스템을 MSA 기반 마이크로서비스로 마이그레이션 하는 실습 과정

- 마이크로서비스 아키텍처(MSA; Microservices Architecture) 이해
    - 마이크로서비스의 등장 배경과 모놀리식(Monolithic) 아키텍처와의 비교
    - 마이크로서비스의 정의 및 특징
    - 마이크로서비스의 장단점 
    - 마이크로서비스 구현을 위한 핵심 기술
- 마이크로서비스 아키텍처 적용
    - 마이크로서비스 모델링 및 모놀리스 분해 방법
    - 마이크로서비스 통신 방식
    - 데이터베이스 분해 전략
    - MSA 도입 과정에서 직면하는 문제점과 해결 방안
- 실습 | 모놀리식 애플리케이션을 MSA로 마이그레이션
    - 예제: 프로젝트 관리 시스템
    - 1단계: 모놀리식 애플리케이션 분석 및 서비스 식별
    - 2단계: 서비스 및 데이터베이스 분리
    - 3단계: JWT 토큰을 활용한 서비스 간 인증 구축
    - 4단계: 배포 및 테스트

## CI/CD 기반 데브옵스 개발 환경 구축 실습 과정

- Docker 사용법
    - 가상 머신과 도커 컨테이너 비교
    - 도커 엔진과 도커 컨테이너의 관계 및 구동 원리 
    - 도커 컨테이너 실행 및 관리 방법
    - Dockerfile 작성 방법 및 도커 이미지 빌드 방법
    - 도커 볼륨과 네트워크 사용법
    - 도커 컴포즈 사용법
- Kubernetes 사용법
    - 파드와 리플리카셋의 개념과 동작원리
    - 디플로이먼트와 서비스의 역할
    - 리소스(네임스페이스, 컨피그맵, 시크릿) 관리와 설정
    - 인그레스 사용법
- CI/CD 파이프라인 구축
    - GitLab 로컬 서비스 및 GitLab Runner 역할 및 동작 원리
    - GitLab CI/CD 파이프라인 설정 파일(.gitlab-ci.yml) 작성법
- 실습
    - Docker Desktop 설치 및 설정
    - GitLab Community Edition 도커 이미지 기반 컨테이너 생성 및 실행
    - 쿠버네티스에 GitLab Runner 배포
    - GitLab CI/CD 환경 설정
    - 백엔드 프로젝트 자동 빌드 및 배포 파이프라인 구축
    - 프론트엔드 프로젝트 자동 빌드 및 배포 파이프라인 구축
    - GitLab CI/CD 파이프라인 테스트 및 검증

## Azure 기반 클라우드 네이티브 애플리케이션 구축 실습 과정

- 클라우드 네이티브 애플리케이션의 이해
    - 클라우드 네이티브의 개념
    - 클라우드 네이티브 애플리케이션 개발 방법론
    - 클라우드 네이티브 애플리케이션 설계 패턴
    - 클라우드 네이티브 핵심 기술(컨테이너, 오케스트레이션, 서비스 메시, 데브옵스 등)
- 클라우드 네이티브 애플리케이션 아키텍처와 Azure 주요 서비스 실습
    - 예제 애플리케이션: 프로젝트 관리 시스템 백엔드/프론트엔드
    - 주요 서비스
        - CI/CD: Azure Repos, Azure Pipelines, Azure Pipelines Agent (호스트 VM/컨테이너에서 Job 실행) 
        - 컨테이너 오케스트레이션: AKS (Azure Kubernetes Service)
        - 컨테이너 레지스트리: ACR (Azure Container Registry)
        - 로드밸런서 & Ingress: Azure Application Gateway (+AGIC: Application Gateway Ingress Controller)
        - 데이터베이스: Azure Database (PostgreSQL/MySQL/SQL DB), Cosmos DB
        - 객체 스토리지: Azure Blob Storage
        - 이미지 해상도 및 크기 변환: Azure CDN + Azure Functions
    - 기타 서비스
        - 캐시: Azure Cache for Redis
        - CDN: Azure CDN
        - 인증/사용자 관리: Azure Active Directory (Entra ID), Azure AD B2C
        - 메시징/이벤트: Azure Service Bus, Event Grid, Event Hubs
        - 모니터링/로그: Azure Monitor + Application Insights
        - 시크릿 관리: Azure Key Vault
- 테라폼(Terraform) 기반 인프라 코드(IaC; Infrastructure as Code) 구축 실습
    - Terraform 개념 및 특징
    - Terraform 설치 및 설정
    - Terraform 구성 파일 작성
    - Terraform을 이용한 인프라 배포 및 관리

## AWS 기반 클라우드 네이티브 애플리케이션 구축 실습 과정

- 클라우드 네이티브 애플리케이션의 이해
    - 클라우드 네이티브의 개념
    - 클라우드 네이티브 애플리케이션 개발 방법론
    - 클라우드 네이티브 애플리케이션 설계 패턴
    - 클라우드 네이티브 핵심 기술(컨테이너, 오케스트레이션, 서비스 메시, 데브옵스 등)
- 클라우드 네이티브 애플리케이션 아키텍처와 AWS 주요 서비스 실습
    - 예제 애플리케이션: 프로젝트 관리 시스템 백엔드/프론트엔드
    - 주요 서비스
        - CI/CD: AWS CodeCommit, AWS CodePipeline, AWS CodeBuild
        - 컨테이너 오케스트레이션: EKS (Elastic Kubernetes Service)
        - 컨테이너 레지스트리: ECR (Elastic Container Registry)
        - 로드밸런서 & Ingress: ALB (Application Load Balancer)
        - 데이터베이스: RDS Aurora, DynamoDB
        - 객체 스토리지: S3
        - 이미지 해상도 및 크기 변환: CloudFront + Lambda@Edge(Serverless Image Handler)
    - 기타 서비스
        - 캐시: ElastiCache (Redis)
        - CDN: CloudFront
        - 인증/사용자 관리: Cognito
        - 메시징/이벤트: SQS, SNS, EventBridge
        - 모니터링/로그: CloudWatch + X-Ray
        - 시크릿 관리: Secrets Manager / Parameter Store
- 테라폼(Terraform) 기반 인프라 코드(IaC; Infrastructure as Code) 구축 실습
    - Terraform 개념 및 특징
    - Terraform 설치 및 설정
    - Terraform 구성 파일 작성
    - Terraform을 이용한 인프라 배포 및 관리

## Naver Cloud 기반 클라우드 네이티브 애플리케이션 구축 실습 과정

- 클라우드 네이티브 애플리케이션의 이해
    - 클라우드 네이티브의 개념
    - 클라우드 네이티브 애플리케이션 개발 방법론
    - 클라우드 네이티브 애플리케이션 설계 패턴
    - 클라우드 네이티브 핵심 기술(컨테이너, 오케스트레이션, 서비스 메시, 데브옵스 등)
- 클라우드 네이티브 애플리케이션 아키텍처와 AWS 주요 서비스 실습
    - 예제 애플리케이션: 프로젝트 관리 시스템 백엔드/프론트엔드
    - 주요 서비스
        - CI/CD: SourceCommit, SourceBuild, SourceDeploy, SourcePipeline
        - 컨테이너 오케스트레이션: NKS (Naver Kubernetes Service)
        - 컨테이너 레지스트리: NCR (Naver Container Registry)
        - 로드밸런서 & Ingress: Load Balancer (NLB, ALB) + Ingress Controller
        - 데이터베이스: Cloud DB for MySQL/PostgreSQL, Cloud DB for Redis
        - 객체 스토리지: Object Storage
        - 이미지 해상도 및 크기 변환: Image Optimizer
    - 기타 서비스
        - 캐시: Cloud DB for Redis
        - CDN: CDN+
        - 인증/사용자 관리: NAVER Cloud IAM + 외부 IdP 연동
        - 메시징/이벤트: Cloud Functions + Event Rule, Cloud Messaging
        - 모니터링/로그: Cloud Monitoring, Cloud Log Analytics
        - 시크릿 관리: Key Manager, Secret Manager
- 테라폼(Terraform) 기반 인프라 코드(IaC; Infrastructure as Code) 구축 실습
    - Terraform 개념 및 특징
    - Terraform 설치 및 설정
    - Terraform 구성 파일 작성
    - Terraform을 이용한 인프라 배포 및 관리