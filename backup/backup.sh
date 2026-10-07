#!/bin/sh

set -e

echo "=========================================="
echo "INICIO DEL BACKUP"
echo "Driver: $MY_DATABASE_DRIVER"
echo "Host: $DB_HOST"
echo "Base de datos: $DB_NAME"
echo "=========================================="

TIMESTAMP=$(date +"%Y%m%d%H%M%S")

BACKUP_DIR="/tmp/backup"
mkdir -p "$BACKUP_DIR"

case "$MY_DATABASE_DRIVER" in

  postgres)
    echo "Generando backup PostgreSQL..."

    export PGPASSWORD="$DB_PASSWORD"

    BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

    pg_dump \
      -h "$DB_HOST" \
      -p "$DB_PORT" \
      -U "$DB_USER_NAME" \
      -d "$DB_NAME" \
      -f "$BACKUP_FILE"
    ;;

  *)
    echo "ERROR: driver no soportado: $MY_DATABASE_DRIVER"
    exit 1
    ;;

esac

echo "Backup generado:"
ls -lh "$BACKUP_FILE"

S3_PATH="s3://${S3_BUCKET}/${S3_PREFIX}/${TIMESTAMP}/$(basename "$BACKUP_FILE")"

echo "Subiendo a:"
echo "$S3_PATH"

aws s3 cp "$BACKUP_FILE" "$S3_PATH"

echo "=========================================="
echo "BACKUP COMPLETADO CORRECTAMENTE"
echo "=========================================="

rm -f "$BACKUP_FILE"