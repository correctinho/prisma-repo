/*
  Warnings:

  - You are about to drop the `_EmployeeBenefitGroups` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_UserItemBenefitGroups` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `benefit_group_uuid` to the `user_item` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_EmployeeBenefitGroups" DROP CONSTRAINT "_EmployeeBenefitGroups_A_fkey";

-- DropForeignKey
ALTER TABLE "_EmployeeBenefitGroups" DROP CONSTRAINT "_EmployeeBenefitGroups_B_fkey";

-- DropForeignKey
ALTER TABLE "_UserItemBenefitGroups" DROP CONSTRAINT "_UserItemBenefitGroups_A_fkey";

-- DropForeignKey
ALTER TABLE "_UserItemBenefitGroups" DROP CONSTRAINT "_UserItemBenefitGroups_B_fkey";

-- AlterTable
ALTER TABLE "user_item" ADD COLUMN     "benefit_group_uuid" TEXT NOT NULL;

-- DropTable
DROP TABLE "_EmployeeBenefitGroups";

-- DropTable
DROP TABLE "_UserItemBenefitGroups";

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_benefit_group_uuid_fkey" FOREIGN KEY ("benefit_group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
