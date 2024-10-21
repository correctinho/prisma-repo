/*
  Warnings:

  - You are about to drop the column `employeeUuid` on the `benefit_groups` table. All the data in the column will be lost.
  - You are about to drop the column `businessInfoUuid` on the `user_info` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "user_info" DROP CONSTRAINT "user_info_businessInfoUuid_fkey";

-- AlterTable
ALTER TABLE "benefit_groups" DROP COLUMN "employeeUuid";

-- AlterTable
ALTER TABLE "user_info" DROP COLUMN "businessInfoUuid";

-- CreateTable
CREATE TABLE "_UserItemBenefitGroups" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserItemBenefitGroups_AB_unique" ON "_UserItemBenefitGroups"("A", "B");

-- CreateIndex
CREATE INDEX "_UserItemBenefitGroups_B_index" ON "_UserItemBenefitGroups"("B");

-- AddForeignKey
ALTER TABLE "_UserItemBenefitGroups" ADD CONSTRAINT "_UserItemBenefitGroups_A_fkey" FOREIGN KEY ("A") REFERENCES "benefit_groups"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserItemBenefitGroups" ADD CONSTRAINT "_UserItemBenefitGroups_B_fkey" FOREIGN KEY ("B") REFERENCES "user_item"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;
