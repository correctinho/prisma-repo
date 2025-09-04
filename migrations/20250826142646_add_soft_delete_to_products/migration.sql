-- AlterTable
ALTER TABLE "products" ADD COLUMN     "deleted_at" TIMESTAMP(3),
ADD COLUMN     "deleted_by_uuid" TEXT;

-- AlterTable
ALTER TABLE "transactions" ALTER COLUMN "fee_amount" SET DEFAULT 0,
ALTER COLUMN "cashback" SET DEFAULT 0,
ALTER COLUMN "discount_percentage" SET DEFAULT 0;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_deleted_by_uuid_fkey" FOREIGN KEY ("deleted_by_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
