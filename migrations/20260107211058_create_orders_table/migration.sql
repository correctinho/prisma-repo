-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'PAID', 'CANCELLED', 'REJECTED');

-- CreateTable
CREATE TABLE "business_orders" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "total_amount" INTEGER NOT NULL,
    "status" "OrderStatus" NOT NULL DEFAULT 'PENDING',
    "payment_proof_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "business_orders_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_order_items" (
    "uuid" TEXT NOT NULL,
    "order_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "beneficiary_snapshot" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "business_order_items_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "business_orders" ADD CONSTRAINT "business_orders_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_orders" ADD CONSTRAINT "business_orders_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_order_items" ADD CONSTRAINT "business_order_items_order_uuid_fkey" FOREIGN KEY ("order_uuid") REFERENCES "business_orders"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_order_items" ADD CONSTRAINT "business_order_items_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
