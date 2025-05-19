-- CreateEnum
CREATE TYPE "UserItemEventType" AS ENUM ('BENEFIT_CREDITED', 'ITEM_SPENT', 'CASHBACK_RECEIVED', 'REFUND_RECEIVED', 'BALANCE_ADJUSTMENT', 'BENEFIT_EXPIRED', 'OTHER');

-- CreateEnum
CREATE TYPE "CorrectAccountEventType" AS ENUM ('PLATFORM_FEE_COLLECTED', 'PAYOUT_SENT', 'MANUAL_ADJUSTMENT', 'SERVICE_COST', 'OTHER');

-- CreateEnum
CREATE TYPE "BusinessAccountEventType" AS ENUM ('PAYMENT_RECEIVED', 'PLATFORM_FEE_CHARGED', 'PARTNER_CASHBACK_COST', 'PAYOUT_REQUESTED', 'PAYOUT_PROCESSED', 'REFUND_ISSUED', 'MANUAL_ADJUSTMENT', 'OTHER');

-- CreateTable
CREATE TABLE "user_item_history" (
    "id" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "event_type" "UserItemEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "related_benefit_group_uuid" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_item_history_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "correct_account" (
    "uuid" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "status" "BusinessAccountStatus" NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "correct_account_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "correct_account_history" (
    "id" TEXT NOT NULL,
    "correct_account_uuid" TEXT NOT NULL,
    "event_type" "CorrectAccountEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "related_business_uuid" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "correct_account_history_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "business_account_history" (
    "id" TEXT NOT NULL,
    "business_account_uuid" TEXT NOT NULL,
    "event_type" "BusinessAccountEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "business_account_history_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_related_benefit_group_uuid_fkey" FOREIGN KEY ("related_benefit_group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_account_history" ADD CONSTRAINT "correct_account_history_correct_account_uuid_fkey" FOREIGN KEY ("correct_account_uuid") REFERENCES "correct_account"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_account_history" ADD CONSTRAINT "business_account_history_business_account_uuid_fkey" FOREIGN KEY ("business_account_uuid") REFERENCES "business_account"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_account_history" ADD CONSTRAINT "business_account_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
