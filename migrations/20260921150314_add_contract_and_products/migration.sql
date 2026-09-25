-- AlterTable
ALTER TABLE "business_data" ADD COLUMN     "contract_number" TEXT;

-- AlterTable
ALTER TABLE "partner_config" ADD COLUMN     "use_correct_fidelity" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "use_employer_platform" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "use_special_products" BOOLEAN NOT NULL DEFAULT false;
