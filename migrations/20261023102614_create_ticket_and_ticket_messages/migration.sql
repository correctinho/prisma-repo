-- CreateEnum
CREATE TYPE "TicketOrigin" AS ENUM ('EMPREGADOR', 'PARCEIRO', 'MEGA_APP');

-- CreateEnum
CREATE TYPE "TicketStatus" AS ENUM ('OPEN', 'ANSWERED', 'WAITING_USER', 'CLOSED');

-- CreateEnum
CREATE TYPE "TicketPriority" AS ENUM ('LOW', 'MEDIUM', 'HIGH', 'URGENT');

-- CreateEnum
CREATE TYPE "MessageSenderType" AS ENUM ('CLIENT', 'SUPPORT', 'SYSTEM');

-- CreateTable
CREATE TABLE "tickets" (
    "uuid" TEXT NOT NULL,
    "protocol" TEXT NOT NULL,
    "origin" "TicketOrigin" NOT NULL,
    "status" "TicketStatus" NOT NULL DEFAULT 'OPEN',
    "priority" "TicketPriority" NOT NULL DEFAULT 'MEDIUM',
    "category" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "business_id" TEXT,
    "business_user_id" TEXT,
    "partner_id" TEXT,
    "app_user_id" TEXT,
    "user_name" TEXT NOT NULL,
    "user_email" TEXT,
    "user_phone" TEXT,
    "slack_channel_id" TEXT,
    "slack_thread_ts" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "tickets_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "ticket_messages" (
    "uuid" TEXT NOT NULL,
    "ticket_uuid" TEXT NOT NULL,
    "sender_type" "MessageSenderType" NOT NULL,
    "sender_name" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "attachments" JSONB,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ticket_messages_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "tickets_protocol_key" ON "tickets"("protocol");

-- CreateIndex
CREATE UNIQUE INDEX "tickets_slack_thread_ts_key" ON "tickets"("slack_thread_ts");

-- CreateIndex
CREATE INDEX "tickets_status_idx" ON "tickets"("status");

-- CreateIndex
CREATE INDEX "tickets_business_id_idx" ON "tickets"("business_id");

-- CreateIndex
CREATE INDEX "tickets_app_user_id_idx" ON "tickets"("app_user_id");

-- CreateIndex
CREATE INDEX "tickets_slack_thread_ts_idx" ON "tickets"("slack_thread_ts");

-- CreateIndex
CREATE INDEX "ticket_messages_ticket_uuid_idx" ON "ticket_messages"("ticket_uuid");

-- AddForeignKey
ALTER TABLE "ticket_messages" ADD CONSTRAINT "ticket_messages_ticket_uuid_fkey" FOREIGN KEY ("ticket_uuid") REFERENCES "tickets"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;
