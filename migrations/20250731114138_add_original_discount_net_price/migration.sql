/*
  Warnings:

  - You are about to drop the column `amount` on the `transactions` table. All the data in the column will be lost.
  - Added the required column `discount_value` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `net_price` to the `transactions` table without a default value. This is not possible if the table is not empty.
  - Added the required column `original_price` to the `transactions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "_UserBusinessInfo" ADD CONSTRAINT "_UserBusinessInfo_AB_pkey" PRIMARY KEY ("A", "B");

-- DropIndex
DROP INDEX "_UserBusinessInfo_AB_unique";

-- AlterTable
ALTER TABLE "transactions" DROP COLUMN "amount",
ADD COLUMN     "discount_value" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "net_price" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "original_price" INTEGER NOT NULL DEFAULT 0;
