/*
  Warnings:

  - Added the required column `partner_credit_amount` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "partner_credit_amount" INTEGER NOT NULL;
