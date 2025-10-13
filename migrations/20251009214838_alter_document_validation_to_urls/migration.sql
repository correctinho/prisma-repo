/*
  Warnings:

  - You are about to drop the column `document_back_base64` on the `user_document_validation` table. All the data in the column will be lost.
  - You are about to drop the column `document_front_base64` on the `user_document_validation` table. All the data in the column will be lost.
  - You are about to drop the column `document_selfie_base64` on the `user_document_validation` table. All the data in the column will be lost.
  - You are about to drop the column `selfie_base64` on the `user_document_validation` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "user_document_validation" DROP COLUMN "document_back_base64",
DROP COLUMN "document_front_base64",
DROP COLUMN "document_selfie_base64",
DROP COLUMN "selfie_base64",
ADD COLUMN     "document_back_url" TEXT,
ADD COLUMN     "document_front_url" TEXT,
ADD COLUMN     "document_selfie_url" TEXT,
ADD COLUMN     "selfie_url" TEXT;
