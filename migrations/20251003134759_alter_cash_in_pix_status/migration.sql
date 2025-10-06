/*
  Warnings:

  - The values [CASH_IN_PIX] on the enum `TransactionType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TransactionType_new" AS ENUM ('P2P_TRANSFER', 'POS_PAYMENT', 'ECOMMERCE_PAYMENT', 'CASH_IN_PIX_USER', 'CASH_IN_PIX_PARTNER', 'CASH_OUT', 'BENEFIT_CREDIT');
ALTER TABLE "transactions" ALTER COLUMN "transaction_type" TYPE "TransactionType_new" USING ("transaction_type"::text::"TransactionType_new");
ALTER TYPE "TransactionType" RENAME TO "TransactionType_old";
ALTER TYPE "TransactionType_new" RENAME TO "TransactionType";
DROP TYPE "TransactionType_old";
COMMIT;
