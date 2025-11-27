-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "subscription_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_subscription_uuid_fkey" FOREIGN KEY ("subscription_uuid") REFERENCES "subscriptions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
