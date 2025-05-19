/*
  Warnings:

  - You are about to drop the column `business_info_uuid` on the `transactions` table. All the data in the column will be lost.
  - You are about to drop the column `favored_uuid` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `transaction_type` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('P2P_TRANSFER', 'POS_PAYMENT', 'ECOMMERCE_PAYMENT', 'CASH_IN_PIX', 'CASH_OUT', 'BENEFIT_CREDIT');

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_business_info_uuid_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_favored_uuid_fkey";

-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_user_item_uuid_fkey";

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "business_info_uuid",
DROP COLUMN "favored_uuid",
ADD COLUMN     "description" TEXT,
ADD COLUMN     "favored_business_info_uuid" TEXT,
ADD COLUMN     "favored_user_uuid" TEXT,
ADD COLUMN     "transaction_type" "TransactionType" NOT NULL,
ALTER COLUMN "user_item_uuid" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_user_uuid_fkey" FOREIGN KEY ("favored_user_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_business_info_uuid_fkey" FOREIGN KEY ("favored_business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
