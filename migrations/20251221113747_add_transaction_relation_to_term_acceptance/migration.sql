-- AlterTable
ALTER TABLE "term_acceptances" ADD COLUMN     "transaction_uuid" TEXT;

-- CreateIndex
CREATE INDEX "term_acceptances_transaction_uuid_idx" ON "term_acceptances"("transaction_uuid");

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_transaction_uuid_fkey" FOREIGN KEY ("transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
