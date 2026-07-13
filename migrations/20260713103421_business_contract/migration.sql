/*
  Warnings:

  - You are about to drop the `business_contract` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "BusinessContractStatus" AS ENUM ('PENDING', 'SIGNED');

-- DropForeignKey
ALTER TABLE "business_contract" DROP CONSTRAINT "business_contract_business_info_uuid_fkey";

-- DropForeignKey
ALTER TABLE "business_contract" DROP CONSTRAINT "business_contract_contract_info_uuid_fkey";

-- AlterTable
ALTER TABLE "term_acceptances" ADD COLUMN     "snapshot_html" TEXT;

-- DropTable
DROP TABLE "business_contract";

-- CreateTable
CREATE TABLE "business_contracts" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "terms_uuid" TEXT NOT NULL,
    "rendered_html" TEXT NOT NULL,
    "status" "BusinessContractStatus" NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "signed_at" TIMESTAMP(3),
    "contractInfoUuid" TEXT,

    CONSTRAINT "business_contracts_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "business_contracts_business_info_uuid_key" ON "business_contracts"("business_info_uuid");

-- AddForeignKey
ALTER TABLE "business_contracts" ADD CONSTRAINT "business_contracts_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_contracts" ADD CONSTRAINT "business_contracts_terms_uuid_fkey" FOREIGN KEY ("terms_uuid") REFERENCES "terms_of_service"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
