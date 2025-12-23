-- CreateEnum
CREATE TYPE "TermsType" AS ENUM ('B2C_APP_USER_EULA', 'B2B_COMPANY_CONTRACT', 'PRIVACY_POLICY');

-- CreateTable
CREATE TABLE "terms_of_service" (
    "uuid" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "type" "TermsType" NOT NULL,
    "content" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "terms_of_service_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "term_acceptances" (
    "uuid" TEXT NOT NULL,
    "app_user_info_uuid" TEXT,
    "company_user_uuid" TEXT,
    "terms_uuid" TEXT NOT NULL,
    "accepted_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip_address" TEXT,
    "user_agent" TEXT,

    CONSTRAINT "term_acceptances_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE INDEX "terms_of_service_type_is_active_idx" ON "terms_of_service"("type", "is_active");

-- CreateIndex
CREATE INDEX "term_acceptances_app_user_info_uuid_idx" ON "term_acceptances"("app_user_info_uuid");

-- CreateIndex
CREATE INDEX "term_acceptances_company_user_uuid_idx" ON "term_acceptances"("company_user_uuid");

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_terms_uuid_fkey" FOREIGN KEY ("terms_uuid") REFERENCES "terms_of_service"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_app_user_info_uuid_fkey" FOREIGN KEY ("app_user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_company_user_uuid_fkey" FOREIGN KEY ("company_user_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
