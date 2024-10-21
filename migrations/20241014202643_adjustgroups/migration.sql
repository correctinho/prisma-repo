/*
  Warnings:

  - You are about to drop the column `employerItemDetails_uuids` on the `benefit_groups` table. All the data in the column will be lost.
  - You are about to drop the column `user_info_uuid` on the `benefit_groups` table. All the data in the column will be lost.
  - Added the required column `employee_uuid` to the `benefit_groups` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employer_item_details_uuids` to the `benefit_groups` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "benefit_groups" DROP COLUMN "employerItemDetails_uuids",
DROP COLUMN "user_info_uuid",
ADD COLUMN     "employee_uuid" TEXT NOT NULL,
ADD COLUMN     "employer_item_details_uuids" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_employer_item_details_uuids_fkey" FOREIGN KEY ("employer_item_details_uuids") REFERENCES "employer_item_details"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_employee_uuid_fkey" FOREIGN KEY ("employee_uuid") REFERENCES "employee"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
