-- AlterTable
ALTER TABLE "business_users" ADD COLUMN     "transaction_pin" TEXT;

-- AlterTable
ALTER TABLE "users_auth" ADD COLUMN     "transaction_pin" TEXT;
