/*
  Warnings:

  - A unique constraint covering the columns `[user_info_uuid,business_info_uuid,item_uuid]` on the table `user_item` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "user_item_user_info_uuid_business_info_uuid_item_uuid_key" ON "user_item"("user_info_uuid", "business_info_uuid", "item_uuid");
