/*
  Warnings:

  - You are about to drop the column `business_info_uuid` on the `user_info` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "user_info" DROP CONSTRAINT "user_info_business_info_uuid_fkey";

-- AlterTable
ALTER TABLE "business_data" ADD COLUMN     "userInfoUuid" TEXT;

-- AlterTable
ALTER TABLE "user_info" DROP COLUMN "business_info_uuid",
ADD COLUMN     "businessInfoUuid" TEXT;

-- CreateTable
CREATE TABLE "_UserBusinessInfo" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserBusinessInfo_AB_unique" ON "_UserBusinessInfo"("A", "B");

-- CreateIndex
CREATE INDEX "_UserBusinessInfo_B_index" ON "_UserBusinessInfo"("B");

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_businessInfoUuid_fkey" FOREIGN KEY ("businessInfoUuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserBusinessInfo" ADD CONSTRAINT "_UserBusinessInfo_A_fkey" FOREIGN KEY ("A") REFERENCES "business_data"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserBusinessInfo" ADD CONSTRAINT "_UserBusinessInfo_B_fkey" FOREIGN KEY ("B") REFERENCES "user_info"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;
