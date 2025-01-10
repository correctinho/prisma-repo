/*
  Warnings:

  - A unique constraint covering the columns `[business_info_uuid]` on the table `partner_config` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "partner_config_business_info_uuid_key" ON "partner_config"("business_info_uuid");
