-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "payer_business_info_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_payer_business_info_uuid_fkey" FOREIGN KEY ("payer_business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
