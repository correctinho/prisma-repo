-- DropForeignKey
ALTER TABLE "correct_user_business" DROP CONSTRAINT "correct_user_business_correct_admin_uuid_fkey";

-- AlterTable
ALTER TABLE "correct_user_business" ALTER COLUMN "correct_admin_uuid" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "correct_user_business" ADD CONSTRAINT "correct_user_business_correct_admin_uuid_fkey" FOREIGN KEY ("correct_admin_uuid") REFERENCES "correct_admin"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
