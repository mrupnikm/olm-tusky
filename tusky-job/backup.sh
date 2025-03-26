#!/bin/bash
set -e

# Setup MinIO client
mc alias set minio "$MINIO_ENDPOINT" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" --insecure

# Create backup filename with timestamp
BACKUP_FILE="backup-$(date +%Y%m%d-%H%M%S).sql.gz"

echo "Starting PostgreSQL backup of $PG_DATABASE from $PG_HOST..."
pg_dump -h "$PG_HOST" -p "$PG_PORT" -U "$PG_USER" -d "$PG_DATABASE" | gzip >"$BACKUP_FILE"

echo "Uploading backup to MinIO bucket $MINIO_BUCKET..."
mc cp --insecure "$BACKUP_FILE" "minio/$MINIO_BUCKET/"

# Cleanup
rm "$BACKUP_FILE"

echo "Backup completed successfully and uploaded to MinIO"
