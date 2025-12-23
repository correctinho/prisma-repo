/*
  Warnings:

  - The values [B2B_COMPANY_CONTRACT] on the enum `TermsType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "TermsType_new" AS ENUM ('B2C_APP_USER_EULA', 'B2B_BUSINESS_MSA', 'PRIVACY_POLICY');
ALTER TABLE "terms_of_service" ALTER COLUMN "type" TYPE "TermsType_new" USING ("type"::text::"TermsType_new");
ALTER TYPE "TermsType" RENAME TO "TermsType_old";
ALTER TYPE "TermsType_new" RENAME TO "TermsType";
DROP TYPE "TermsType_old";
COMMIT;
