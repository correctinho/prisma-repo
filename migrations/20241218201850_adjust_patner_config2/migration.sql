-- CreateEnum
CREATE TYPE "SalesType" AS ENUM ('presencial', 'delivery', 'ambos');

-- AlterTable
ALTER TABLE "partner_config" ADD COLUMN     "sales_type" "SalesType";
