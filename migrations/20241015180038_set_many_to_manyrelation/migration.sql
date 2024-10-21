/*
  Warnings:

  - You are about to drop the column `employee_uuid` on the `benefit_groups` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "benefit_groups" DROP CONSTRAINT "benefit_groups_employee_uuid_fkey";

-- AlterTable
ALTER TABLE "benefit_groups" DROP COLUMN "employee_uuid",
ADD COLUMN     "employeeUuid" TEXT;

-- CreateTable
CREATE TABLE "_EmployeeBenefitGroups" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_EmployeeBenefitGroups_AB_unique" ON "_EmployeeBenefitGroups"("A", "B");

-- CreateIndex
CREATE INDEX "_EmployeeBenefitGroups_B_index" ON "_EmployeeBenefitGroups"("B");

-- AddForeignKey
ALTER TABLE "_EmployeeBenefitGroups" ADD CONSTRAINT "_EmployeeBenefitGroups_A_fkey" FOREIGN KEY ("A") REFERENCES "benefit_groups"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EmployeeBenefitGroups" ADD CONSTRAINT "_EmployeeBenefitGroups_B_fkey" FOREIGN KEY ("B") REFERENCES "employee"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;
