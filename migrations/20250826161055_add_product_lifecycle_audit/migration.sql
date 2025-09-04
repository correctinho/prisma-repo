/*
  Warnings:

  - Added the required column `created_by_uuid` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_by_uuid` to the `products` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "products" ADD COLUMN     "businessUserUuid" TEXT,
ADD COLUMN     "created_by_uuid" TEXT NOT NULL,
ADD COLUMN     "updated_by_uuid" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "product_history" (
    "uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "changed_by_uuid" TEXT NOT NULL,
    "field_changed" TEXT NOT NULL,
    "old_value" TEXT,
    "new_value" TEXT,
    "changed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_history_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_created_by_uuid_fkey" FOREIGN KEY ("created_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_updated_by_uuid_fkey" FOREIGN KEY ("updated_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_businessUserUuid_fkey" FOREIGN KEY ("businessUserUuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_history" ADD CONSTRAINT "product_history_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_history" ADD CONSTRAINT "product_history_changed_by_uuid_fkey" FOREIGN KEY ("changed_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
