/*
  Warnings:

  - You are about to drop the `business_config` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "business_config" DROP CONSTRAINT "business_config_business_info_uuid_fkey";

-- DropTable
DROP TABLE "business_config";

-- CreateTable
CREATE TABLE "partner_config" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "partner_category" TEXT[],
    "items_uuid" TEXT[],
    "admin_tax" INTEGER,
    "marketing_tax" INTEGER,
    "cycle_start_day" INTEGER,
    "cycle_end_day" INTEGER,

    CONSTRAINT "partner_config_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "partner_config" ADD CONSTRAINT "partner_config_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
