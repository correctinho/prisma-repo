/*
  Warnings:

  - You are about to drop the column `partner_user_uuid` on the `transactions` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "transactions" DROP CONSTRAINT "transactions_partner_user_uuid_fkey";

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "partner_user_uuid",
ADD COLUMN     "favored_partner_user_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_partner_user_uuid_fkey" FOREIGN KEY ("favored_partner_user_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
