/*
  Warnings:

  - Added the required column `item_uuid` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "item_uuid" TEXT NOT NULL,
ADD COLUMN     "partner_user_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_partner_user_uuid_fkey" FOREIGN KEY ("partner_user_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
