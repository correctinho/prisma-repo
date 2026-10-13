-- AlterEnum
ALTER TYPE "TransactionType" ADD VALUE IF NOT EXISTS 'COMPANY_PRE_PAID_RECHARGE';

-- AlterTable
ALTER TABLE "business_data" ADD COLUMN IF NOT EXISTS "timezone" TEXT NOT NULL DEFAULT 'America/Campo_Grande';
