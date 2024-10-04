-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
