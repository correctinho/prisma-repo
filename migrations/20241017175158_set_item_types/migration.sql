/*
  Warnings:

  - Changed the type of `item_type` on the `items` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `item_category` on the `items` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "ItemCategory" AS ENUM ('pos_pago', 'pre_pago');

-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('gratuito', 'programa', 'produto');

-- AlterTable
ALTER TABLE "items" DROP COLUMN "item_type",
ADD COLUMN     "item_type" "ItemType" NOT NULL,
DROP COLUMN "item_category",
ADD COLUMN     "item_category" "ItemCategory" NOT NULL;
