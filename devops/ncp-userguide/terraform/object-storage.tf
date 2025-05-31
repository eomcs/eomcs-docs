# Container Registry 용 Object Storage 버킷 생성
resource "ncloud_objectstorage_bucket" "docker_image_bitcamp_teacher01" {
  bucket_name = "docker-image-bitcamp-teacher01"
}

# SourceCommit 용 Object Storage 버킷 생성
resource "ncloud_objectstorage_bucket" "source_commit_bitcamp_teacher01" {
  bucket_name = "source-commit-bitcamp-teacher01"
}

