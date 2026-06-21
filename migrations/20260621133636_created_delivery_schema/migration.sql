-- CreateEnum
CREATE TYPE "EcommerceOrderStatus" AS ENUM ('PENDING_PAYMENT', 'PAID', 'PREPARING', 'IN_TRANSIT', 'DELIVERED', 'CANCELED');

-- CreateEnum
CREATE TYPE "DeliveryStatus" AS ENUM ('DISTRIBUTING', 'WAITING_ACCEPTANCE', 'PENDING', 'ACCEPTED', 'NOT_ANSWERED', 'FINISHED', 'CANCELLED', 'UNKNOWN');

-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "deliveryUuid" TEXT;

-- CreateTable
CREATE TABLE "ecommerce_orders" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "transaction_uuid" TEXT,
    "status" "EcommerceOrderStatus" NOT NULL DEFAULT 'PENDING_PAYMENT',
    "total_items_amount" INTEGER NOT NULL,
    "freight_amount" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ecommerce_orders_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "ecommerce_order_items" (
    "uuid" TEXT NOT NULL,
    "ecommerce_order_uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit_price" INTEGER NOT NULL,

    CONSTRAINT "ecommerce_order_items_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "deliveries" (
    "uuid" TEXT NOT NULL,
    "ecommerce_order_uuid" TEXT NOT NULL,
    "external_delivery_id" TEXT,
    "provider" TEXT NOT NULL DEFAULT 'TAXIMACHINE',
    "status" "DeliveryStatus" NOT NULL DEFAULT 'PENDING',
    "estimated_minutes" INTEGER,
    "estimated_km" DOUBLE PRECISION,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "deliveries_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "ecommerce_orders_transaction_uuid_key" ON "ecommerce_orders"("transaction_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "deliveries_ecommerce_order_uuid_key" ON "deliveries"("ecommerce_order_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "deliveries_external_delivery_id_key" ON "deliveries"("external_delivery_id");

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_deliveryUuid_fkey" FOREIGN KEY ("deliveryUuid") REFERENCES "deliveries"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_orders" ADD CONSTRAINT "ecommerce_orders_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_orders" ADD CONSTRAINT "ecommerce_orders_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_orders" ADD CONSTRAINT "ecommerce_orders_transaction_uuid_fkey" FOREIGN KEY ("transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_order_items" ADD CONSTRAINT "ecommerce_order_items_ecommerce_order_uuid_fkey" FOREIGN KEY ("ecommerce_order_uuid") REFERENCES "ecommerce_orders"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_order_items" ADD CONSTRAINT "ecommerce_order_items_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "deliveries" ADD CONSTRAINT "deliveries_ecommerce_order_uuid_fkey" FOREIGN KEY ("ecommerce_order_uuid") REFERENCES "ecommerce_orders"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
