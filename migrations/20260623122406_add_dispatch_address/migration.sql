-- AlterTable
ALTER TABLE "addresses" ADD COLUMN     "latitude" DOUBLE PRECISION,
ADD COLUMN     "longitude" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "partner_config" ADD COLUMN     "addressUuid" TEXT;

-- AlterTable
ALTER TABLE "user_notification" ADD COLUMN     "dispatch_address_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "partner_config" ADD CONSTRAINT "partner_config_addressUuid_fkey" FOREIGN KEY ("addressUuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_notification" ADD CONSTRAINT "user_notification_dispatch_address_uuid_fkey" FOREIGN KEY ("dispatch_address_uuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
