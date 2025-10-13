-- CreateEnum
CREATE TYPE "EmployeeStatus" AS ENUM ('active', 'inactive');

-- AlterTable
ALTER TABLE "employee" ADD COLUMN     "fired_at" TEXT,
ADD COLUMN     "status" "EmployeeStatus" NOT NULL DEFAULT 'active';
