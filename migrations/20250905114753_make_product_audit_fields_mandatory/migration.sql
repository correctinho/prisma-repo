/*
  Warnings:

  - Made the column `created_by_uuid` on table `products` required. This step will fail if there are existing NULL values in that column.
  - Made the column `updated_by_uuid` on table `products` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "products" ALTER COLUMN "created_by_uuid" SET NOT NULL,
ALTER COLUMN "updated_by_uuid" SET NOT NULL;
