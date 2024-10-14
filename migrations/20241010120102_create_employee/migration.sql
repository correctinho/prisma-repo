-- AlterEnum
ALTER TYPE "UserItemStatus" ADD VALUE 'inactive';

-- AlterTable
ALTER TABLE "benefit_groups" ADD COLUMN     "updated_at" TEXT;

-- AlterTable
ALTER TABLE "user_info" ADD COLUMN     "is_employee" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "employee" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "company_internal_code" TEXT,
    "salary" INTEGER,
    "dependents_quantity" INTEGER,
    "job_title" TEXT,
    "company_owner" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
