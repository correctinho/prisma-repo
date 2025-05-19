/*
  Warnings:

  - You are about to drop the column `related_business_uuid` on the `correct_account_history` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "correct_account_history" DROP COLUMN "related_business_uuid";

-- AddForeignKey
ALTER TABLE "correct_account_history" ADD CONSTRAINT "correct_account_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
