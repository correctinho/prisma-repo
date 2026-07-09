/*
  Warnings:

  - You are about to drop the column `destination_address` on the `carts` table. All the data in the column will be lost.
  - You are about to drop the column `destination_lat` on the `carts` table. All the data in the column will be lost.
  - You are about to drop the column `destination_lng` on the `carts` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "carts" DROP COLUMN "destination_address",
DROP COLUMN "destination_lat",
DROP COLUMN "destination_lng",
ADD COLUMN     "destination_address_uuid" TEXT,
ADD COLUMN     "status" TEXT DEFAULT 'ACTIVE';

-- AddForeignKey
ALTER TABLE "carts" ADD CONSTRAINT "carts_destination_address_uuid_fkey" FOREIGN KEY ("destination_address_uuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
