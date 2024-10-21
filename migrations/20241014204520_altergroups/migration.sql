-- DropForeignKey
ALTER TABLE "benefit_groups" DROP CONSTRAINT "benefit_groups_employee_uuid_fkey";

-- AlterTable
ALTER TABLE "benefit_groups" ALTER COLUMN "employee_uuid" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_employee_uuid_fkey" FOREIGN KEY ("employee_uuid") REFERENCES "employee"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
