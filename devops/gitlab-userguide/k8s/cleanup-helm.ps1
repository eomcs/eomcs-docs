# cleanup-helm.ps1 - 로컬 DevOps 환경 정리 스크립트 (Helm 기반) - Windows 11용

param(
    [string]$Namespace = "devops",
    [string]$RunnerName = "gitlab-runner"
)

# 한글 출력을 위한 인코딩 설정
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [Console]::OutputEncoding
chcp 65001 > $null

$ErrorActionPreference = "Continue"  # 일부 명령어가 실패해도 계속 진행

$CURRENT_USER = $env:USERNAME

Write-Host "=== 로컬 DevOps 환경 정리 시작 ===" -ForegroundColor Red
Write-Host "네임스페이스: $Namespace" -ForegroundColor Cyan
Write-Host "저장소: Kubernetes 내부 동적 프로비저닝" -ForegroundColor Cyan
Write-Host ""

# 사용자 확인
$confirmation = Read-Host "⚠️  모든 GitLab 및 Runner 리소스를 삭제하시겠습니까? (y/N)"
if ($confirmation -notmatch "^[Yy]$") {
    Write-Host "정리가 취소되었습니다." -ForegroundColor Yellow
    exit 0
}

Write-Host "🧹 환경 정리 시작..." -ForegroundColor Yellow

# 포트 포워딩 Job 종료
Write-Host "📡 포트 포워딩 Job 종료 중..." -ForegroundColor Gray
try {
    Get-Job | Where-Object { $_.Command -like "*port-forward*gitlab*" } | Stop-Job -ErrorAction SilentlyContinue
    Get-Job | Where-Object { $_.Command -like "*port-forward*gitlab*" } | Remove-Job -ErrorAction SilentlyContinue
    Write-Host "✅ 포트 포워딩 Job 종료 완료" -ForegroundColor Green
}
catch {
    Write-Host "💡 활성화된 포트 포워딩 Job이 없습니다." -ForegroundColor Gray
}

# kubectl 프로세스 종료 (포트 포워딩)
Write-Host "📡 kubectl 포트 포워딩 프로세스 종료 중..." -ForegroundColor Gray
try {
    Get-Process | Where-Object { $_.ProcessName -eq "kubectl" -and $_.CommandLine -like "*port-forward*gitlab*" } | Stop-Process -Force -ErrorAction SilentlyContinue
    Write-Host "✅ kubectl 프로세스 종료 완료" -ForegroundColor Green
}
catch {
    Write-Host "💡 kubectl 포트 포워딩 프로세스가 없습니다." -ForegroundColor Gray
}

# Helm으로 설치된 GitLab Runner 제거
Write-Host "🚀 GitLab Runner (Helm) 제거 중..." -ForegroundColor Yellow
try {
    $helmList = helm list -n $Namespace 2>$null
    if ($helmList -match $RunnerName) {
        helm uninstall $RunnerName -n $Namespace
        Write-Host "✅ GitLab Runner 제거 완료" -ForegroundColor Green
    }
    else {
        Write-Host "💡 GitLab Runner가 Helm으로 설치되지 않았습니다." -ForegroundColor Gray
    }
}
catch {
    Write-Host "💡 GitLab Runner Helm 릴리스를 찾을 수 없습니다." -ForegroundColor Gray
}

# kubectl로 설치된 기타 리소스 확인 및 제거
Write-Host "🗑️  kubectl 리소스 정리 중..." -ForegroundColor Yellow
try {
    $namespaceExists = kubectl get namespace $Namespace 2>$null
    if ($namespaceExists) {
        Write-Host "현재 네임스페이스의 리소스:" -ForegroundColor Gray
        kubectl get all -n $Namespace
        Write-Host ""
        
        # GitLab 및 기타 리소스 제거
        kubectl delete namespace $Namespace --ignore-not-found=true
        Write-Host "✅ 네임스페이스 $Namespace 제거 완료" -ForegroundColor Green
    }
    else {
        Write-Host "💡 네임스페이스 $Namespace가 존재하지 않습니다." -ForegroundColor Gray
    }
}
catch {
    Write-Host "💡 네임스페이스 $Namespace를 찾을 수 없습니다." -ForegroundColor Gray
}

# PersistentVolume 정리 (수동 설정된 경우)
Write-Host "💾 PersistentVolume 정리 중..." -ForegroundColor Yellow
try {
    kubectl delete pv gitlab-config-pv gitlab-logs-pv gitlab-data-pv --ignore-not-found=true 2>$null
    Write-Host "✅ PersistentVolume 정리 완료" -ForegroundColor Green
}
catch {
    Write-Host "💡 정리할 PersistentVolume이 없습니다." -ForegroundColor Gray
}

# PVC 정리 (동적 프로비저닝된 경우)
Write-Host "💾 PersistentVolumeClaim 정리 중..." -ForegroundColor Yellow
try {
    kubectl get pvc -n $Namespace 2>$null | Out-Null
    if ($?) {
        kubectl delete pvc --all -n $Namespace --ignore-not-found=true
        Write-Host "✅ PersistentVolumeClaim 정리 완료" -ForegroundColor Green
    }
    else {
        Write-Host "💡 정리할 PersistentVolumeClaim이 없습니다." -ForegroundColor Gray
    }
}
catch {
    Write-Host "💡 PersistentVolumeClaim 정리 중 오류가 발생했습니다." -ForegroundColor Gray
}

# Docker 이미지 정리 옵션
Write-Host ""
$dockerCleanup = Read-Host "🐳 관련 Docker 이미지도 정리하시겠습니까? (y/N)"
if ($dockerCleanup -match "^[Yy]$") {
    Write-Host "🧹 Docker 이미지 정리 중..." -ForegroundColor Yellow
    
    try {
        # GitLab 관련 이미지 제거
        docker rmi gitlab/gitlab-ce:latest 2>$null
        Write-Host "   GitLab CE 이미지 제거 시도" -ForegroundColor Gray
    }
    catch {
        Write-Host "   GitLab CE 이미지가 없습니다." -ForegroundColor Gray
    }
    
    try {
        docker rmi gitlab/gitlab-runner:v17.11.3 2>$null
        Write-Host "   GitLab Runner 이미지 제거 시도" -ForegroundColor Gray
    }
    catch {
        Write-Host "   GitLab Runner 이미지가 없습니다." -ForegroundColor Gray
    }
    
    try {
        # 사용하지 않는 이미지 정리
        docker image prune -f 2>$null
        Write-Host "✅ Docker 이미지 정리 완료" -ForegroundColor Green
    }
    catch {
        Write-Host "💡 정리할 Docker 이미지가 없습니다." -ForegroundColor Gray
    }
}
else {
    Write-Host "🐳 Docker 이미지가 보존되었습니다." -ForegroundColor Cyan
}

# Helm 저장소 정리 옵션
Write-Host ""
$helmRepoCleanup = Read-Host "📦 GitLab Helm 저장소도 제거하시겠습니까? (y/N)"
if ($helmRepoCleanup -match "^[Yy]$") {
    try {
        helm repo remove gitlab 2>$null
        Write-Host "✅ Helm 저장소 정리 완료" -ForegroundColor Green
    }
    catch {
        Write-Host "💡 GitLab 저장소가 없습니다." -ForegroundColor Gray
    }
}
else {
    Write-Host "📦 Helm 저장소가 보존되었습니다." -ForegroundColor Cyan
}

# 최종 상태 확인
Write-Host ""
Write-Host "📋 정리 후 상태 확인:" -ForegroundColor Yellow
Write-Host ""

Write-Host "Kubernetes 네임스페이스:" -ForegroundColor White
try {
    $namespaceCheck = kubectl get namespaces 2>$null | Select-String $Namespace
    if ($namespaceCheck) {
        Write-Host "⚠️  $Namespace 네임스페이스가 여전히 존재합니다." -ForegroundColor Yellow
    }
    else {
        Write-Host "✅ $Namespace 네임스페이스 없음" -ForegroundColor Green
    }
}
catch {
    Write-Host "✅ $Namespace 네임스페이스 없음" -ForegroundColor Green
}

Write-Host ""
Write-Host "PersistentVolumes:" -ForegroundColor White
try {
    $pvCheck = kubectl get pv 2>$null | Select-String "gitlab"
    if ($pvCheck) {
        Write-Host "⚠️  GitLab 관련 PV가 여전히 존재합니다:" -ForegroundColor Yellow
        $pvCheck | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
    }
    else {
        Write-Host "✅ GitLab PV 없음" -ForegroundColor Green
    }
}
catch {
    Write-Host "✅ GitLab PV 없음" -ForegroundColor Green
}

Write-Host ""
Write-Host "Helm 릴리스:" -ForegroundColor White
try {
    $helmCheck = helm list -A 2>$null | Select-String "gitlab"
    if ($helmCheck) {
        Write-Host "⚠️  GitLab 관련 Helm 릴리스가 여전히 존재합니다:" -ForegroundColor Yellow
        $helmCheck | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
    }
    else {
        Write-Host "✅ GitLab Helm 릴리스 없음" -ForegroundColor Green
    }
}
catch {
    Write-Host "✅ GitLab Helm 릴리스 없음" -ForegroundColor Green
}

Write-Host ""
Write-Host "🎉 DevOps 환경 정리 완료!" -ForegroundColor Green
Write-Host ""
Write-Host "재설치하려면:" -ForegroundColor White
Write-Host "1. .\deploy-helm.ps1  # GitLab 배포" -ForegroundColor Gray
Write-Host "2. GitLab Runner는 Helm으로 수동 설치" -ForegroundColor Gray
Write-Host ""
Write-Host "문제가 있는 경우:" -ForegroundColor White
Write-Host "- kubectl get all -A  # 전체 리소스 확인" -ForegroundColor Gray
Write-Host "- docker system prune  # Docker 시스템 정리" -ForegroundColor Gray
Write-Host "- Docker Desktop 재시작" -ForegroundColor Gray