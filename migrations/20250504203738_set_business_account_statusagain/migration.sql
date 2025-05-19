/*
  Warnings:

  - Added the required column `status` to the `business_account` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "BusinessAccountStatus" AS ENUM ('active', 'inactive');

-- AlterTable
ALTER TABLE "business_account" ADD COLUMN     "status" "BusinessAccountStatus" NOT NULL;

-- DropEnum
DROP TYPE "businessAccountStatus";
