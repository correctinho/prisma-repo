-- DropIndex
DROP INDEX "user_info_document2_key";

-- CreateTable
CREATE TABLE "benefit_groups" (
    "uuid" TEXT NOT NULL,
    "group_name" TEXT NOT NULL,
    "employerItemDetails_uuids" TEXT[],
    "value" INTEGER NOT NULL,
    "user_info_uuid" TEXT[],
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT,

    CONSTRAINT "benefit_groups_pkey" PRIMARY KEY ("uuid")
);

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
