/*
  Warnings:

  - You are about to drop the column `company_owner` on the `user_info` table. All the data in the column will be lost.
  - You are about to drop the column `dependents_quantity` on the `user_info` table. All the data in the column will be lost.
  - You are about to drop the column `function` on the `user_info` table. All the data in the column will be lost.
  - You are about to drop the column `internal_company_code` on the `user_info` table. All the data in the column will be lost.
  - You are about to drop the column `salary` on the `user_info` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "user_info" DROP COLUMN "company_owner",
DROP COLUMN "dependents_quantity",
DROP COLUMN "function",
DROP COLUMN "internal_company_code",
DROP COLUMN "salary";
