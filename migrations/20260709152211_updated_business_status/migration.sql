-- AlterEnum
ALTER TYPE "BusinessStatus" ADD VALUE 'awaiting_payment';

-- AlterTable
ALTER TABLE "business_data" ADD COLUMN     "referred_by_code" TEXT;
