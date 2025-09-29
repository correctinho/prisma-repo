/*
  Warnings:

  - A unique constraint covering the columns `[provider_tx_id]` on the table `transactions` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "provider_tx_id" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "transactions_provider_tx_id_key" ON "transactions"("provider_tx_id");
