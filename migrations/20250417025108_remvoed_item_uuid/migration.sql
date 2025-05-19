/*
  Warnings:

  - You are about to drop the column `item_uuid` on the `transactions` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "item_uuid";
