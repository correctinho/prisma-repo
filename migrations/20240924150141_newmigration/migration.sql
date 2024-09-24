-- CreateEnum
CREATE TYPE "Permissions" AS ENUM ('all', 'sales', 'finances', 'marketing', 'benefits', 'transports', 'allPartners', 'allEmployers');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('pending', 'active', 'inactive', 'pending_password', 'pending_validation');

-- CreateEnum
CREATE TYPE "BusinessStatus" AS ENUM ('pending_approval', 'pending_contract', 'active', 'inactive');

-- CreateEnum
CREATE TYPE "BusinessTypeOptions" AS ENUM ('empregador', 'comercio', 'autonomo_comercio', 'empregador_comercio');

-- CreateEnum
CREATE TYPE "UserDocumentValidationStatus" AS ENUM ('approved', 'denied', 'pending_to_send', 'under_analysis');

-- CreateEnum
CREATE TYPE "UserItemStatus" AS ENUM ('active', 'blocked', 'cancelled', 'to_be_cancelled');

-- CreateEnum
CREATE TYPE "ContractType" AS ENUM ('BUSINESS', 'USER');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('pending', 'sucess', 'fail');

-- CreateTable
CREATE TABLE "correct_admin" (
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "isAdmin" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "correct_admin_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_users" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "is_admin" BOOLEAN NOT NULL DEFAULT false,
    "document" TEXT,
    "name" TEXT,
    "email" TEXT,
    "user_name" TEXT,
    "password" TEXT NOT NULL,
    "function" TEXT,
    "permissions" "Permissions"[] DEFAULT ARRAY['all']::"Permissions"[],
    "status" "Status" NOT NULL DEFAULT 'pending_password',
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "business_users_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "correctAdmin_business" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "correct_admin_uuid" TEXT NOT NULL,

    CONSTRAINT "correctAdmin_business_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_data" (
    "uuid" TEXT NOT NULL,
    "address_uuid" TEXT NOT NULL,
    "fantasy_name" TEXT NOT NULL,
    "corporate_reason" TEXT,
    "document" TEXT NOT NULL,
    "classification" TEXT NOT NULL,
    "colaborators_number" INTEGER NOT NULL,
    "status" "BusinessStatus" NOT NULL DEFAULT 'pending_approval',
    "phone_1" TEXT NOT NULL,
    "phone_2" TEXT,
    "email" TEXT NOT NULL,
    "business_type" "BusinessTypeOptions" NOT NULL,
    "employer_branch" TEXT,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "business_data_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "addresses" (
    "uuid" TEXT NOT NULL,
    "line1" TEXT,
    "line2" TEXT,
    "line3" TEXT,
    "postal_code" TEXT NOT NULL,
    "neighborhood" TEXT,
    "city" TEXT,
    "state" TEXT,
    "country" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "addresses_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "user_info" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT,
    "address_uuid" TEXT,
    "document" TEXT NOT NULL,
    "document2" TEXT,
    "document3" TEXT,
    "full_name" TEXT NOT NULL,
    "display_name" TEXT,
    "internal_company_code" TEXT,
    "gender" TEXT,
    "email" TEXT,
    "date_of_birth" TEXT NOT NULL,
    "phone" TEXT,
    "salary" INTEGER,
    "company_owner" BOOLEAN NOT NULL DEFAULT false,
    "status" "Status" NOT NULL DEFAULT 'pending',
    "function" TEXT,
    "recommendation_code" TEXT,
    "is_authenticated" BOOLEAN NOT NULL DEFAULT false,
    "marital_status" TEXT,
    "dependents_quantity" INTEGER NOT NULL DEFAULT 0,
    "user_document_validation_uuid" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "user_info_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "user_document_validation" (
    "uuid" TEXT NOT NULL,
    "document_front_base64" TEXT,
    "document_front_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "document_back_base64" TEXT,
    "document_back_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "selfie_base64" TEXT,
    "selfie_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "document_selfie_base64" TEXT,
    "document_selfie_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "user_document_validation_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "users_auth" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT,
    "document" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "users_auth_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "items" (
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "img_url" TEXT,
    "description" TEXT NOT NULL,
    "item_type" TEXT NOT NULL,
    "item_category" TEXT NOT NULL,
    "parent_uuid" TEXT,
    "business_info_uuid" TEXT,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "items_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "branch_info" (
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "marketing_tax" INTEGER NOT NULL,
    "admin_tax" INTEGER NOT NULL,
    "market_place_tax" INTEGER NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "branch_info_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "businessInfo_branch" (
    "uuid" TEXT NOT NULL,
    "branch_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "businessInfo_branch_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "branch_item" (
    "uuid" TEXT NOT NULL,
    "branchInfo_uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "branch_item_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "businessInfo_item" (
    "uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "businessInfo_item_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "employer_item_details" (
    "uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "cycle_start_day" INTEGER,
    "cycle_end_day" INTEGER,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "employer_item_details_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "employer_item_registers" (
    "uuid" TEXT NOT NULL,
    "employerItemDetails_uuid" TEXT NOT NULL,
    "correct_payment_date" TEXT,
    "correct_releasing_amount_to_user_date" TEXT,
    "send_file_to_business_date" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "employer_item_registers_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "user_item" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "item_name" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "status" "UserItemStatus" NOT NULL,
    "blocked_at" TEXT,
    "cancelled_at" TEXT,
    "cancelling_request_at" TEXT,
    "block_reason" TEXT,
    "cancel_reason" TEXT,
    "grace_period_end_date" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "user_item_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "contract_info" (
    "uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "name" TEXT,
    "content" TEXT NOT NULL,
    "version" TEXT,
    "assigned_at" TEXT NOT NULL,
    "contract_type" "ContractType" NOT NULL,
    "business_info_uuid" TEXT,
    "user_info_uuid" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "contract_info_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_contract" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "contract_info_uuid" TEXT NOT NULL,

    CONSTRAINT "business_contract_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "transactions" (
    "uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "favored_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "fee_amount" INTEGER NOT NULL,
    "cashback" INTEGER NOT NULL,
    "status" "TransactionStatus" NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT NOT NULL,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_recommendations" (
    "uuid" TEXT NOT NULL,
    "business_name" TEXT NOT NULL,
    "owner_name" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "social_media" TEXT NOT NULL,

    CONSTRAINT "business_recommendations_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_config" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "admin_tax" INTEGER NOT NULL,
    "marketing_tax" INTEGER NOT NULL,
    "block_list" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "cycle_start_date" TEXT,
    "cycle_end_date" TEXT,
    "cycle_paper_payment_date" TEXT,

    CONSTRAINT "business_config_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "user_notification" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "user_notification_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_notifications" (
    "uuid" TEXT NOT NULL,
    "business_user_uuid" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "read" BOOLEAN NOT NULL,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "business_notifications_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "categories" (
    "uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "products" (
    "uuid" TEXT NOT NULL,
    "category_uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "original_price" INTEGER NOT NULL,
    "price" INTEGER NOT NULL,
    "image" TEXT[],
    "stock" INTEGER NOT NULL,
    "weight" TEXT NOT NULL,
    "height" TEXT NOT NULL,
    "width" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "products_pkey" PRIMARY KEY ("uuid")
);

-- CreateIndex
CREATE UNIQUE INDEX "correct_admin_userName_key" ON "correct_admin"("userName");

-- CreateIndex
CREATE UNIQUE INDEX "correct_admin_email_key" ON "correct_admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "business_users_document_key" ON "business_users"("document");

-- CreateIndex
CREATE UNIQUE INDEX "business_users_email_key" ON "business_users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "business_data_document_key" ON "business_data"("document");

-- CreateIndex
CREATE UNIQUE INDEX "business_data_email_key" ON "business_data"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_info_document_key" ON "user_info"("document");

-- CreateIndex
CREATE UNIQUE INDEX "user_info_document2_key" ON "user_info"("document2");

-- CreateIndex
CREATE UNIQUE INDEX "user_info_email_key" ON "user_info"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_auth_document_key" ON "users_auth"("document");

-- CreateIndex
CREATE UNIQUE INDEX "users_auth_email_key" ON "users_auth"("email");

-- AddForeignKey
ALTER TABLE "business_users" ADD CONSTRAINT "business_users_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correctAdmin_business" ADD CONSTRAINT "correctAdmin_business_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correctAdmin_business" ADD CONSTRAINT "correctAdmin_business_correct_admin_uuid_fkey" FOREIGN KEY ("correct_admin_uuid") REFERENCES "correct_admin"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_data" ADD CONSTRAINT "business_data_address_uuid_fkey" FOREIGN KEY ("address_uuid") REFERENCES "addresses"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_address_uuid_fkey" FOREIGN KEY ("address_uuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_user_document_validation_uuid_fkey" FOREIGN KEY ("user_document_validation_uuid") REFERENCES "user_document_validation"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users_auth" ADD CONSTRAINT "users_auth_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "businessInfo_branch" ADD CONSTRAINT "businessInfo_branch_branch_info_uuid_fkey" FOREIGN KEY ("branch_info_uuid") REFERENCES "branch_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "businessInfo_branch" ADD CONSTRAINT "businessInfo_branch_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "branch_item" ADD CONSTRAINT "branch_item_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "branch_item" ADD CONSTRAINT "branch_item_branchInfo_uuid_fkey" FOREIGN KEY ("branchInfo_uuid") REFERENCES "branch_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "businessInfo_item" ADD CONSTRAINT "businessInfo_item_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "businessInfo_item" ADD CONSTRAINT "businessInfo_item_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employer_item_details" ADD CONSTRAINT "employer_item_details_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employer_item_details" ADD CONSTRAINT "employer_item_details_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employer_item_registers" ADD CONSTRAINT "employer_item_registers_employerItemDetails_uuid_fkey" FOREIGN KEY ("employerItemDetails_uuid") REFERENCES "employer_item_details"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contract_info" ADD CONSTRAINT "contract_info_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contract_info" ADD CONSTRAINT "contract_info_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contract_info" ADD CONSTRAINT "contract_info_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_contract" ADD CONSTRAINT "business_contract_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_contract" ADD CONSTRAINT "business_contract_contract_info_uuid_fkey" FOREIGN KEY ("contract_info_uuid") REFERENCES "contract_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_uuid_fkey" FOREIGN KEY ("favored_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_config" ADD CONSTRAINT "business_config_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_notification" ADD CONSTRAINT "user_notification_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_notifications" ADD CONSTRAINT "business_notifications_business_user_uuid_fkey" FOREIGN KEY ("business_user_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_uuid_fkey" FOREIGN KEY ("category_uuid") REFERENCES "categories"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
