/*
  Warnings:

  - You are about to drop the column `description` on the `business_account_history` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `correct_account_history` table. All the data in the column will be lost.
  - You are about to drop the column `description` on the `user_item_history` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "business_account_history" DROP COLUMN "description";

-- AlterTable
ALTER TABLE "correct_account_history" DROP COLUMN "description";

-- AlterTable
ALTER TABLE "user_item_history" DROP COLUMN "description";
