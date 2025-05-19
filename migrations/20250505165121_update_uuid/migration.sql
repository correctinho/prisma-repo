/*
  Warnings:

  - The primary key for the `business_account_history` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `business_account_history` table. All the data in the column will be lost.
  - The primary key for the `correct_account_history` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `correct_account_history` table. All the data in the column will be lost.
  - The primary key for the `user_item_history` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `user_item_history` table. All the data in the column will be lost.
  - The required column `uuid` was added to the `business_account_history` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `uuid` was added to the `correct_account_history` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - The required column `uuid` was added to the `user_item_history` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.

*/
-- AlterTable
ALTER TABLE "business_account_history" DROP CONSTRAINT "business_account_history_pkey",
DROP COLUMN "id",
ADD COLUMN     "uuid" TEXT NOT NULL,
ADD CONSTRAINT "business_account_history_pkey" PRIMARY KEY ("uuid");

-- AlterTable
ALTER TABLE "correct_account_history" DROP CONSTRAINT "correct_account_history_pkey",
DROP COLUMN "id",
ADD COLUMN     "uuid" TEXT NOT NULL,
ADD CONSTRAINT "correct_account_history_pkey" PRIMARY KEY ("uuid");

-- AlterTable
ALTER TABLE "user_item_history" DROP CONSTRAINT "user_item_history_pkey",
DROP COLUMN "id",
ADD COLUMN     "uuid" TEXT NOT NULL,
ADD CONSTRAINT "user_item_history_pkey" PRIMARY KEY ("uuid");
