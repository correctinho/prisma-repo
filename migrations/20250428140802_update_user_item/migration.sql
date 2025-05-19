-- DropForeignKey
ALTER TABLE "user_item" DROP CONSTRAINT "user_item_group_uuid_fkey";

-- AlterTable
ALTER TABLE "user_item" ALTER COLUMN "group_uuid" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_group_uuid_fkey" FOREIGN KEY ("group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
