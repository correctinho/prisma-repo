/*
  Warnings:

  - You are about to drop the column `addressUuid` on the `partner_config` table. All the data in the column will be lost.
  - You are about to drop the column `latitude` on the `partner_config` table. All the data in the column will be lost.
  - You are about to drop the column `longitude` on the `partner_config` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "partner_config" DROP CONSTRAINT "partner_config_addressUuid_fkey";

-- AlterTable
ALTER TABLE "partner_config" DROP COLUMN "addressUuid",
DROP COLUMN "latitude",
DROP COLUMN "longitude",
ADD COLUMN     "dispatch_address_uuid" TEXT;

-- AddForeignKey
ALTER TABLE "partner_config" ADD CONSTRAINT "partner_config_dispatch_address_uuid_fkey" FOREIGN KEY ("dispatch_address_uuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
