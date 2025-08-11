/*
  Warnings:

  - You are about to drop the column `discount_value` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `discount_percentage` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "discount_value",
ADD COLUMN     "discount_percentage" INTEGER NOT NULL;
