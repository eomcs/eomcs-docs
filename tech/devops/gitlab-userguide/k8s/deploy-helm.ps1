# deploy-devops-helm.ps1 - 로컬 DevOps 환경 배포 스크립트 (Helm 사용) - Windows 11용

param(
    [string]$Namespace = "devops",
    [int]$GitLabPort = 8929,
    [int]$SSHPort = 2222
)

# 한글 출력을 위한 인코딩 설정
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [Console]::OutputEncoding
chcp 65001 > $null

$ErrorActionPreference = "Stop"

$CURRENT_USER = $env:USERNAME

Write-Host "=== 로컬 DevOps 환경 배포 시작 (Helm 방식) ===" -ForegroundColor Green
Write-Host "사용자: $CURRENT_USER" -ForegroundColor Cyan
Write-Host "GitLab: http://localhost:$GitLabPort" -ForegroundColor Cyan
Write-Host "SSH: localhost:$SSHPort" -ForegroundColor Cyan
Write-Host "저장소: Kubernetes 내부 동적 프로비저닝" -ForegroundColor Cyan
Write-Host ""

# 필수 도구 확인
Write-Host "🔧 필수 도구 확인 중..." -ForegroundColor Yellow

# Kubernetes 확인
Write-Host "Kubernetes 클러스터 연결 확인 중..." -ForegroundColor Gray
try {
    $null = kubectl cluster-info 2>$null
    Write-Host "✅ Kubernetes 클러스터 연결 확인" -ForegroundColor Green
}
catch {
    Write-Host "❌ 오류: Kubernetes 클러스터에 연결할 수 없습니다." -ForegroundColor Red
    Write-Host "Docker Desktop에서 Kubernetes가 활성화되어 있는지 확인하세요." -ForegroundColor Red
    exit 1
}

# Helm 확인
if (-not (Get-Command helm -ErrorAction SilentlyContinue)) {
    Write-Host "❌ 오류: Helm이 설치되어 있지 않습니다." -ForegroundColor Red
    Write-Host "Helm을 설치하세요: https://helm.sh/docs/intro/install/" -ForegroundColor Red
    exit 1
}

$helmVersion = helm version --short
Write-Host "✅ Helm 설치 확인 ($helmVersion)" -ForegroundColor Green

# GitLab 배포
Write-Host "🚀 GitLab 배포 중..." -ForegroundColor Yellow
kubectl apply -f gitlab.yml

Write-Host "⏳ GitLab 서비스 시작 대기 중..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# 포트 포워딩 설정
Write-Host "🔗 포트 포워딩 설정 중..." -ForegroundColor Yellow

# 기존 포트 포워딩 프로세스 종료
Write-Host "기존 포트 포워딩 프로세스 정리 중..." -ForegroundColor Gray
Get-Process | Where-Object { $_.ProcessName -eq "kubectl" -and $_.CommandLine -like "*port-forward*gitlab*" } | Stop-Process -Force -ErrorAction SilentlyContinue

# GitLab HTTP 포트 포워딩 (백그라운드)
$httpJob = Start-Job -ScriptBlock {
    param($ns, $port)
    kubectl port-forward -n $ns svc/gitlab-service "$port:80"
} -ArgumentList $Namespace, $GitLabPort

# GitLab SSH 포트 포워딩 (백그라운드)
$sshJob = Start-Job -ScriptBlock {
    param($ns, $port)
    kubectl port-forward -n $ns svc/gitlab-service "$port:22"
} -ArgumentList $Namespace, $SSHPort

Write-Host "✅ 포트 포워딩 설정 완료" -ForegroundColor Green
Write-Host "   - HTTP: Job ID $($httpJob.Id)" -ForegroundColor Cyan
Write-Host "   - SSH: Job ID $($sshJob.Id)" -ForegroundColor Cyan

# GitLab Runner Helm 저장소 추가
Write-Host "📦 GitLab Runner Helm 저장소 설정 중..." -ForegroundColor Yellow
try {
    helm repo add gitlab https://charts.gitlab.io/ 2>$null
}
catch {
    # 이미 추가된 경우 무시
}
helm repo update

Write-Host "✅ Helm 저장소 설정 완료" -ForegroundColor Green

# 상태 확인 함수
function Show-Status {
    Write-Host ""
    Write-Host "📋 배포 상태 확인:" -ForegroundColor Yellow
    Write-Host "Namespace: $Namespace" -ForegroundColor Cyan
    kubectl get pods -n $Namespace
    Write-Host ""
    kubectl get svc -n $Namespace
    Write-Host ""
    Write-Host "💾 Kubernetes 저장소 상태:" -ForegroundColor Yellow
    kubectl get pvc -n $Namespace
}

# 초기 상태 확인
Show-Status

Write-Host ""
Write-Host "🔧 GitLab 초기 설정 및 Runner 설치 가이드:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. GitLab 시작 대기 (5-10분 소요):" -ForegroundColor White
Write-Host "   kubectl logs -n $Namespace deployment/gitlab -f" -ForegroundColor Gray
Write-Host ""
Write-Host "2. GitLab 접속 정보:" -ForegroundColor White
Write-Host "   URL: http://localhost:$GitLabPort" -ForegroundColor Gray
Write-Host "   사용자명: root" -ForegroundColor Gray
Write-Host ""
Write-Host "3. 초기 패스워드 확인:" -ForegroundColor White
Write-Host "   kubectl exec -n $Namespace deployment/gitlab -- cat /etc/gitlab/initial_root_password" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Registration Token 확인:" -ForegroundColor White
Write-Host "   GitLab 로그인 후 Admin Area → Runners → Registration token 복사" -ForegroundColor Gray
Write-Host "   또는: kubectl exec -n $Namespace deployment/gitlab -- gitlab-rails runner `"puts Gitlab::CurrentSettings.runners_registration_token`"" -ForegroundColor Gray
Write-Host ""
Write-Host "5. values-arm64.yml에서 Registration Token 업데이트:" -ForegroundColor White
Write-Host "   runnerRegistrationToken: `"YOUR_ACTUAL_TOKEN`"" -ForegroundColor Gray
Write-Host ""
Write-Host "6. GitLab Runner 설치 (Helm):" -ForegroundColor White
Write-Host "   helm install gitlab-runner gitlab/gitlab-runner ``" -ForegroundColor Gray
Write-Host "     --namespace $Namespace ``" -ForegroundColor Gray
Write-Host "     --values gitlab-runner-values-arm64.yml" -ForegroundColor Gray
Write-Host ""
Write-Host "7. Runner 상태 확인:" -ForegroundColor White
Write-Host "   kubectl get pods -n $Namespace" -ForegroundColor Gray
Write-Host "   helm list -n $Namespace" -ForegroundColor Gray
Write-Host ""
Write-Host "8. 환경 정리:" -ForegroundColor White
Write-Host "   helm uninstall gitlab-runner -n $Namespace" -ForegroundColor Gray
Write-Host "   kubectl delete namespace $Namespace" -ForegroundColor Gray
Write-Host ""

# GitLab 준비 상태 확인 옵션
$response = Read-Host "🔍 GitLab 준비 상태를 확인하시겠습니까? (y/N)"
if ($response -match "^[Yy]$") {
    Write-Host "GitLab 로그 모니터링 시작 (Ctrl+C로 종료):" -ForegroundColor Yellow
    kubectl logs -n $Namespace deployment/gitlab -f
}

Write-Host ""
Write-Host "🎉 GitLab 배포 완료! " -ForegroundColor Green
Write-Host "GitLab이 완전히 시작되면 Registration Token을 확인하고 Runner를 설치하세요." -ForegroundColor Cyan

# 정리 함수 (스크립트 종료 시 자동 실행)
Register-EngineEvent PowerShell.Exiting -Action {
    Write-Host "포트 포워딩 Job 정리 중..." -ForegroundColor Yellow
    Get-Job | Stop-Job
    Get-Job | Remove-Job
}