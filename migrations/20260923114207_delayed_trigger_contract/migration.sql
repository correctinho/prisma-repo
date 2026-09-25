-- AlterEnum
ALTER TYPE "BusinessContractStatus" ADD VALUE 'ARCHIVED';

-- DropIndex
DROP INDEX "business_contracts_business_info_uuid_key";

-- AlterTable
ALTER TABLE "partner_config" ADD COLUMN     "pending_admin_tax" INTEGER,
ADD COLUMN     "pending_market_place_tax" INTEGER,
ADD COLUMN     "pending_marketing_tax" INTEGER,
ADD COLUMN     "pending_use_market_place" BOOLEAN,
ADD COLUMN     "pending_use_marketing" BOOLEAN;
