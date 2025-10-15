-- CreateEnum
CREATE TYPE "OfflineTokenStatus" AS ENUM ('ACTIVE', 'CONSUMED', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "OfflineTokenHistoryEventType" AS ENUM ('ACTIVATED', 'USED_IN_TRANSACTION', 'CONSUMED', 'EXPIRED_BY_TTL', 'REVOKED', 'REPLACED_BY_NEW_ACTIVATION', 'DELETED_FROM_POOL');

-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "used_offline_token_code" TEXT;

-- CreateTable
CREATE TABLE "offline_tokens" (
    "uuid" TEXT NOT NULL,
    "token_code" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "status" "OfflineTokenStatus" NOT NULL DEFAULT 'ACTIVE',
    "expires_at" TIMESTAMP(3) NOT NULL,
    "activated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_accessed_at" TIMESTAMP(3),
    "last_used_at" TIMESTAMP(3),
    "sequence_number" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "offline_tokens_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "offline_token_history" (
    "uuid" TEXT NOT NULL,
    "original_token_uuid" TEXT,
    "token_code" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "event_type" "OfflineTokenHistoryEventType" NOT NULL,
    "event_description" TEXT,
    "related_transaction_uuid" TEXT,
    "event_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "snapshot_expires_at" TIMESTAMP(3),
    "snapshot_status" "OfflineTokenStatus",

    CONSTRAINT "offline_token_history_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "offline_tokens_token_code_key" ON "offline_tokens"("token_code");

-- CreateIndex
CREATE INDEX "offline_tokens_user_info_uuid_user_item_uuid_status_idx" ON "offline_tokens"("user_info_uuid", "user_item_uuid", "status");

-- CreateIndex
CREATE INDEX "offline_tokens_token_code_idx" ON "offline_tokens"("token_code");

-- CreateIndex
CREATE INDEX "offline_tokens_status_expires_at_idx" ON "offline_tokens"("status", "expires_at");

-- CreateIndex
CREATE INDEX "offline_token_history_token_code_idx" ON "offline_token_history"("token_code");

-- CreateIndex
CREATE INDEX "offline_token_history_user_info_uuid_user_item_uuid_idx" ON "offline_token_history"("user_info_uuid", "user_item_uuid");

-- CreateIndex
CREATE INDEX "offline_token_history_related_transaction_uuid_idx" ON "offline_token_history"("related_transaction_uuid");

-- AddForeignKey
ALTER TABLE "offline_tokens" ADD CONSTRAINT "offline_tokens_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_tokens" ADD CONSTRAINT "offline_tokens_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
