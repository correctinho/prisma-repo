-- CreateTable
CREATE TABLE "ean_products" (
    "uuid" TEXT NOT NULL,
    "ean_code" TEXT NOT NULL,
    "name" TEXT,
    "image_url" TEXT,
    "brand" TEXT,
    "description" TEXT,
    "max_price" INTEGER,
    "gross_weight" INTEGER,
    "net_weight" INTEGER,
    "height" DOUBLE PRECISION,
    "length" DOUBLE PRECISION,
    "width" DOUBLE PRECISION,

    CONSTRAINT "ean_products_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "ean_products_ean_code_key" ON "ean_products"("ean_code");
