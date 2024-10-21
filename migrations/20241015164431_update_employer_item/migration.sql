/*
  Warnings:

  - Added the required column `is_active` to the `employer_item_details` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "employer_item_details" ADD COLUMN     "is_active" BOOLEAN NOT NULL;
