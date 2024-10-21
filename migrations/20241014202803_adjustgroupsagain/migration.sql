/*
  Warnings:

  - You are about to drop the column `employer_item_details_uuids` on the `benefit_groups` table. All the data in the column will be lost.
  - Added the required column `employer_item_details_uuid` to the `benefit_groups` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "benefit_groups" DROP CONSTRAINT "benefit_groups_employer_item_details_uuids_fkey";

-- AlterTable
ALTER TABLE "benefit_groups" DROP COLUMN "employer_item_details_uuids",
ADD COLUMN     "employer_item_details_uuid" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_employer_item_details_uuid_fkey" FOREIGN KEY ("employer_item_details_uuid") REFERENCES "employer_item_details"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
