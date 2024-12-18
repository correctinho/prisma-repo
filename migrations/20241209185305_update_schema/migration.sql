/*
  Warnings:

  - Added the required column `use_marketing` to the `partner_config` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "partner_config" ADD COLUMN     "use_marketing" BOOLEAN NOT NULL;
