/*
  Warnings:

  - You are about to drop the column `image` on the `products` table. All the data in the column will be lost.
  - You are about to drop the column `price` on the `products` table. All the data in the column will be lost.
  - Added the required column `discount` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `promotional_price` to the `products` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "products" DROP COLUMN "image",
DROP COLUMN "price",
ADD COLUMN     "brand" TEXT,
ADD COLUMN     "discount" INTEGER NOT NULL,
ADD COLUMN     "ean_code" TEXT,
ADD COLUMN     "image_urls" TEXT[],
ADD COLUMN     "is_mega_promotion" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "promotional_price" INTEGER NOT NULL,
ALTER COLUMN "weight" DROP NOT NULL,
ALTER COLUMN "height" DROP NOT NULL,
ALTER COLUMN "width" DROP NOT NULL;
