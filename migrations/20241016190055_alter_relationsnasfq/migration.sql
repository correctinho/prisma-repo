/*
  Warnings:

  - You are about to drop the column `benefit_group_uuid` on the `user_item` table. All the data in the column will be lost.
  - Added the required column `group_uuid` to the `user_item` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "user_item" DROP CONSTRAINT "user_item_benefit_group_uuid_fkey";

-- AlterTable
ALTER TABLE "user_item" DROP COLUMN "benefit_group_uuid",
ADD COLUMN     "group_uuid" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_group_uuid_fkey" FOREIGN KEY ("group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
