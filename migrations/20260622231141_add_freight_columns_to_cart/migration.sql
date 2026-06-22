-- AlterTable
ALTER TABLE "carts" ADD COLUMN     "destination_address" TEXT,
ADD COLUMN     "destination_lat" DOUBLE PRECISION,
ADD COLUMN     "destination_lng" DOUBLE PRECISION,
ADD COLUMN     "freight_amount" INTEGER,
ADD COLUMN     "freight_estimated_minutes" INTEGER,
ADD COLUMN     "freight_quoted_at" TIMESTAMP(3);
