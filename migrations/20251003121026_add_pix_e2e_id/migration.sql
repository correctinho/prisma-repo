/*
  Warnings:

  - A unique constraint covering the columns `[pix_e2e_id]` on the table `transactions` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "pix_e2e_id" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "transactions_pix_e2e_id_key" ON "transactions"("pix_e2e_id");
