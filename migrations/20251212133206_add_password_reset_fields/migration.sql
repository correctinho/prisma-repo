-- AlterTable
ALTER TABLE "users_auth" ADD COLUMN     "password_reset_expires_at" TIMESTAMP(3),
ADD COLUMN     "password_reset_token" TEXT;
