-- CreateEnum
CREATE TYPE "InvoiceStatus" AS ENUM ('PENDING', 'PAID', 'OVERDUE', 'CANCELED');

-- CreateTable
CREATE TABLE "employer_invoices" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "reference_month" TEXT NOT NULL,
    "cycle_start_date" TIMESTAMP(3) NOT NULL,
    "cycle_end_date" TIMESTAMP(3) NOT NULL,
    "due_date" TIMESTAMP(3) NOT NULL,
    "total_amount" INTEGER NOT NULL,
    "status" "InvoiceStatus" NOT NULL DEFAULT 'PENDING',
    "paid_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "employer_invoices_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "employer_invoices" ADD CONSTRAINT "employer_invoices_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
