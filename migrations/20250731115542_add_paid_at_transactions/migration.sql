-- AlterTable
ALTER TABLE "transactions" ADD COLUMN     "paid_at" TEXT,
ALTER COLUMN "updated_at" DROP NOT NULL;
