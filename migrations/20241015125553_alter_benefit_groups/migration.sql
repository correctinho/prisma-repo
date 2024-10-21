/*
  Warnings:

  - Added the required column `is_default` to the `benefit_groups` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "benefit_groups" ADD COLUMN     "is_default" BOOLEAN NOT NULL;
