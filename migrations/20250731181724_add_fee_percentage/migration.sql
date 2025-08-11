-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "fee_percentage" INTEGER DEFAULT 0,
ALTER COLUMN "fee_amount" DROP NOT NULL;
