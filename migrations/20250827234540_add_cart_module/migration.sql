-- AlterEnum
ALTER TYPE "ProductType" ADD VALUE 'BOOKABLE_SERVICE';

-- CreateTable
CREATE TABLE "carts" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "carts_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "cart_items" (
    "uuid" TEXT NOT NULL,
    "cart_uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "cart_items_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "carts_user_info_uuid_business_info_uuid_key" ON "carts"("user_info_uuid", "business_info_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "cart_items_cart_uuid_product_uuid_key" ON "cart_items"("cart_uuid", "product_uuid");

-- AddForeignKey
ALTER TABLE "carts" ADD CONSTRAINT "carts_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carts" ADD CONSTRAINT "carts_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_cart_uuid_fkey" FOREIGN KEY ("cart_uuid") REFERENCES "carts"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
