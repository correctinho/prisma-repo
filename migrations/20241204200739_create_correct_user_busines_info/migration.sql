/*
  Warnings:

  - You are about to drop the column `cycle_end_day` on the `partner_config` table. All the data in the column will be lost.
  - You are about to drop the column `cycle_start_day` on the `partner_config` table. All the data in the column will be lost.
  - Added the required column `main_branch` to the `partner_config` table without a default value. This is not possible if the table is not empty.
  - Added the required column `use_market_place` to the `partner_config` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "partner_config" DROP COLUMN "cycle_end_day",
DROP COLUMN "cycle_start_day",
ADD COLUMN     "main_branch" TEXT NOT NULL,
ADD COLUMN     "use_market_place" BOOLEAN NOT NULL;

-- CreateTable
CREATE TABLE "correct_user_business" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "correct_admin_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "correct_user_business_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "correct_user_business" ADD CONSTRAINT "correct_user_business_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_user_business" ADD CONSTRAINT "correct_user_business_correct_admin_uuid_fkey" FOREIGN KEY ("correct_admin_uuid") REFERENCES "correct_admin"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
