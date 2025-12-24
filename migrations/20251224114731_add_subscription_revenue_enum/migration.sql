-- AlterEnum
ALTER TYPE "CorrectAccountEventType" ADD VALUE 'SUBSCRIPTION_REVENUE';

-- CreateTable
CREATE TABLE "login_histories" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "logged_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip_address" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,

    CONSTRAINT "login_histories_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE INDEX "login_histories_user_info_uuid_idx" ON "login_histories"("user_info_uuid");
