-- AlterTable
ALTER TABLE "ean_products" ADD COLUMN     "created_at" TEXT,
ADD COLUMN     "grpc_code" TEXT,
ADD COLUMN     "min_price" INTEGER,
ADD COLUMN     "ncm_code" TEXT,
ADD COLUMN     "origin" TEXT;
