/*
  Warnings:

  - You are about to drop the column `original_value` on the `products` table. All the data in the column will be lost.
  - You are about to drop the column `value` on the `products` table. All the data in the column will be lost.
  - You are about to drop the column `volume` on the `products` table. All the data in the column will be lost.
  - The `image` column on the `products` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `category_uuid` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `height` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `original_price` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `products` table without a default value. This is not possible if the table is not empty.
  - Added the required column `width` to the `products` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "products" DROP COLUMN "original_value",
DROP COLUMN "value",
DROP COLUMN "volume",
ADD COLUMN     "category_uuid" TEXT NOT NULL,
ADD COLUMN     "created_at" TEXT,
ADD COLUMN     "height" TEXT NOT NULL,
ADD COLUMN     "original_price" INTEGER NOT NULL,
ADD COLUMN     "price" INTEGER NOT NULL,
ADD COLUMN     "updated_at" TEXT,
ADD COLUMN     "width" TEXT NOT NULL,
ALTER COLUMN "description" DROP NOT NULL,
DROP COLUMN "image",
ADD COLUMN     "image" TEXT[];

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_uuid_fkey" FOREIGN KEY ("category_uuid") REFERENCES "categories"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
