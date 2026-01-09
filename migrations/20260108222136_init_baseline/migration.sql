-- CreateEnum
CREATE TYPE "Permissions" AS ENUM ('all', 'sales', 'finances', 'marketing', 'benefits', 'collaborators', 'transports', 'allPartners', 'allEmployers');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('pending', 'active', 'inactive', 'pending_password', 'pending_validation', 'deleted');

-- CreateEnum
CREATE TYPE "BusinessStatus" AS ENUM ('pending_approval', 'pending_contract', 'active', 'inactive');

-- CreateEnum
CREATE TYPE "BusinessTypeOptions" AS ENUM ('empregador', 'comercio', 'autonomo_comercio', 'empregador_comercio');

-- CreateEnum
CREATE TYPE "EmployeeStatus" AS ENUM ('active', 'inactive');

-- CreateEnum
CREATE TYPE "UserDocumentValidationStatus" AS ENUM ('approved', 'denied', 'pending_to_send', 'under_analysis');

-- CreateEnum
CREATE TYPE "ItemCategory" AS ENUM ('pos_pago', 'pre_pago');

-- CreateEnum
CREATE TYPE "ItemType" AS ENUM ('gratuito', 'programa', 'produto');

-- CreateEnum
CREATE TYPE "UserItemEventType" AS ENUM ('BENEFIT_CREDITED', 'ITEM_SPENT', 'CASHBACK_RECEIVED', 'REFUND_RECEIVED', 'BALANCE_ADJUSTMENT', 'BENEFIT_EXPIRED', 'PIX_RECEIVED', 'TEI_SENT', 'TEI_RECEIVED', 'OTHER');

-- CreateEnum
CREATE TYPE "UserItemStatus" AS ENUM ('active', 'inactive', 'blocked', 'cancelled', 'to_be_cancelled');

-- CreateEnum
CREATE TYPE "ContractType" AS ENUM ('BUSINESS', 'USER');

-- CreateEnum
CREATE TYPE "OfflineTokenStatus" AS ENUM ('ACTIVE', 'CONSUMED', 'EXPIRED', 'REVOKED');

-- CreateEnum
CREATE TYPE "OfflineTokenHistoryEventType" AS ENUM ('ACTIVATED', 'USED_IN_TRANSACTION', 'CONSUMED', 'EXPIRED_BY_TTL', 'REVOKED', 'REPLACED_BY_NEW_ACTIVATION', 'DELETED_FROM_POOL');

-- CreateEnum
CREATE TYPE "TransactionStatus" AS ENUM ('pending', 'success', 'fail', 'cancelled');

-- CreateEnum
CREATE TYPE "TransactionType" AS ENUM ('P2P_TRANSFER', 'POS_PAYMENT', 'POS_OFFLINE_PAYMENT', 'ECOMMERCE_PAYMENT', 'CASH_IN_PIX_USER', 'CASH_IN_PIX_PARTNER', 'CASH_OUT', 'BENEFIT_CREDIT', 'SUBSCRIPTION_PAYMENT');

-- CreateEnum
CREATE TYPE "BusinessAccountStatus" AS ENUM ('active', 'inactive');

-- CreateEnum
CREATE TYPE "CorrectAccountEventType" AS ENUM ('PLATFORM_FEE_COLLECTED', 'PAYOUT_SENT', 'MANUAL_ADJUSTMENT', 'SERVICE_COST', 'SUBSCRIPTION_REVENUE', 'OTHER');

-- CreateEnum
CREATE TYPE "BusinessAccountEventType" AS ENUM ('PAYMENT_RECEIVED', 'PLATFORM_FEE_CHARGED', 'PARTNER_CASHBACK_COST', 'PAYOUT_REQUESTED', 'PAYOUT_PROCESSED', 'REFUND_ISSUED', 'MANUAL_ADJUSTMENT', 'OTHER');

-- CreateEnum
CREATE TYPE "PartnerCreditStatus" AS ENUM ('PENDING', 'SETTLED');

-- CreateEnum
CREATE TYPE "SalesType" AS ENUM ('presencial', 'delivery', 'ambos');

-- CreateEnum
CREATE TYPE "PayerType" AS ENUM ('EMPLOYER', 'USER');

-- CreateEnum
CREATE TYPE "BillingPeriod" AS ENUM ('MONTHLY', 'YEARLY', 'ONE_TIME');

-- CreateEnum
CREATE TYPE "SubscriptionStatus" AS ENUM ('ACTIVE', 'PENDING_PAYMENT', 'CANCELED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "ProductType" AS ENUM ('PHYSICAL', 'SERVICE', 'BOOKABLE_SERVICE');

-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('PENDING_PROVIDER_OPTIONS', 'PENDING_USER_SELECTION', 'CONFIRMED', 'DECLINED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "DayPeriod" AS ENUM ('MORNING', 'AFTERNOON', 'EVENING');

-- CreateEnum
CREATE TYPE "AppointmentStatus" AS ENUM ('SCHEDULED', 'COMPLETED', 'CANCELED', 'NO_SHOW');

-- CreateEnum
CREATE TYPE "TermsType" AS ENUM ('B2C_APP_USER_EULA', 'B2B_BUSINESS_MSA', 'PRIVACY_POLICY');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('PENDING', 'PAID', 'CANCELLED', 'REJECTED');

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
    "transaction_pin" TEXT,
    "permissions" "Permissions"[] DEFAULT ARRAY['all']::"Permissions"[],
    "status" "Status" NOT NULL DEFAULT 'pending_password',
    "gamerTag" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "business_users_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "login_histories" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "logged_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip_address" TEXT NOT NULL,
    "user_agent" TEXT NOT NULL,

    CONSTRAINT "login_histories_pkey" PRIMARY KEY ("uuid")
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
    "userInfoUuid" TEXT,

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
    "address_uuid" TEXT,
    "document" TEXT NOT NULL,
    "document2" TEXT,
    "document3" TEXT,
    "full_name" TEXT NOT NULL,
    "display_name" TEXT,
    "gender" TEXT,
    "email" TEXT,
    "date_of_birth" TEXT NOT NULL,
    "phone" TEXT,
    "status" "Status" NOT NULL DEFAULT 'pending',
    "recommendation_code" TEXT,
    "is_employee" BOOLEAN NOT NULL DEFAULT false,
    "is_authenticated" BOOLEAN NOT NULL DEFAULT false,
    "marital_status" TEXT,
    "user_document_validation_uuid" TEXT,
    "gamerTag" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "user_info_pkey" PRIMARY KEY ("uuid")
);

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
    "status" "EmployeeStatus" NOT NULL DEFAULT 'active',
    "created_at" TEXT,
    "fired_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "user_document_validation" (
    "uuid" TEXT NOT NULL,
    "document_front_url" TEXT,
    "document_front_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "document_back_url" TEXT,
    "document_back_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "selfie_url" TEXT,
    "selfie_status" "UserDocumentValidationStatus" NOT NULL DEFAULT 'pending_to_send',
    "document_selfie_url" TEXT,
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
    "transaction_pin" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "is_email_verified" BOOLEAN NOT NULL DEFAULT false,
    "email_verification_token" TEXT,
    "email_verification_expires_at" TIMESTAMP(3),
    "password_reset_token" TEXT,
    "password_reset_expires_at" TIMESTAMP(3),
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
    "item_type" "ItemType" NOT NULL,
    "item_category" "ItemCategory" NOT NULL,
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
    "is_active" BOOLEAN NOT NULL DEFAULT false,
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
    "business_info_uuid" TEXT,
    "item_uuid" TEXT NOT NULL,
    "item_name" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "group_uuid" TEXT,
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
CREATE TABLE "user_item_history" (
    "uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "event_type" "UserItemEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "related_benefit_group_uuid" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_item_history_pkey" PRIMARY KEY ("uuid")
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
CREATE TABLE "offline_tokens" (
    "uuid" TEXT NOT NULL,
    "token_code" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "status" "OfflineTokenStatus" NOT NULL DEFAULT 'ACTIVE',
    "expires_at" TIMESTAMP(3) NOT NULL,
    "activated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_accessed_at" TIMESTAMP(3),
    "last_used_at" TIMESTAMP(3),
    "sequence_number" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "offline_tokens_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "offline_token_history" (
    "uuid" TEXT NOT NULL,
    "original_token_uuid" TEXT,
    "token_code" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "event_type" "OfflineTokenHistoryEventType" NOT NULL,
    "event_description" TEXT,
    "related_transaction_uuid" TEXT,
    "event_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "snapshot_expires_at" TIMESTAMP(3),
    "snapshot_status" "OfflineTokenStatus",

    CONSTRAINT "offline_token_history_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "transactions" (
    "uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT,
    "favored_user_uuid" TEXT,
    "favored_business_info_uuid" TEXT,
    "payer_business_info_uuid" TEXT,
    "subscription_uuid" TEXT,
    "original_price" INTEGER NOT NULL DEFAULT 0,
    "discount_percentage" INTEGER NOT NULL DEFAULT 0,
    "net_price" INTEGER NOT NULL DEFAULT 0,
    "fee_percentage" INTEGER DEFAULT 0,
    "fee_amount" INTEGER DEFAULT 0,
    "platform_net_fee_amount" INTEGER DEFAULT 0,
    "partner_credit_amount" INTEGER NOT NULL,
    "cashback" INTEGER NOT NULL DEFAULT 0,
    "description" TEXT,
    "provider_tx_id" TEXT,
    "pix_e2e_id" TEXT,
    "status" "TransactionStatus" NOT NULL,
    "transaction_type" "TransactionType" NOT NULL,
    "used_offline_token_code" TEXT,
    "favored_partner_user_uuid" TEXT,
    "paid_at" TEXT,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

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
CREATE TABLE "correct_account" (
    "uuid" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "status" "BusinessAccountStatus" NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "correct_account_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "correct_account_history" (
    "uuid" TEXT NOT NULL,
    "correct_account_uuid" TEXT NOT NULL,
    "event_type" "CorrectAccountEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "correct_account_history_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_account" (
    "uuid" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "status" "BusinessAccountStatus" NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "business_account_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_account_history" (
    "uuid" TEXT NOT NULL,
    "business_account_uuid" TEXT NOT NULL,
    "event_type" "BusinessAccountEventType" NOT NULL,
    "amount" INTEGER NOT NULL,
    "balance_before" INTEGER NOT NULL,
    "balance_after" INTEGER NOT NULL,
    "related_transaction_uuid" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "business_account_history_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "partner_credits" (
    "uuid" TEXT NOT NULL,
    "business_account_uuid" TEXT NOT NULL,
    "original_transaction_uuid" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "spent_amount" INTEGER NOT NULL DEFAULT 0,
    "status" "PartnerCreditStatus" NOT NULL,
    "availability_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "partner_credits_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "partner_credit_spends" (
    "uuid" TEXT NOT NULL,
    "partner_credit_uuid" TEXT NOT NULL,
    "spending_transaction_uuid" TEXT NOT NULL,
    "amount_spent" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "partner_credit_spends_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "partner_config" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "main_branch" TEXT NOT NULL,
    "partner_category" TEXT[],
    "items_uuid" TEXT[],
    "admin_tax" INTEGER,
    "marketing_tax" INTEGER,
    "use_marketing" BOOLEAN NOT NULL,
    "market_place_tax" INTEGER,
    "use_market_place" BOOLEAN NOT NULL,
    "title" TEXT,
    "phone" TEXT,
    "description" TEXT,
    "sales_type" "SalesType",
    "cashback_tax" INTEGER NOT NULL DEFAULT 0,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "partner_config_pkey" PRIMARY KEY ("uuid")
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
CREATE TABLE "benefit_groups" (
    "uuid" TEXT NOT NULL,
    "group_name" TEXT NOT NULL,
    "employer_item_details_uuid" TEXT NOT NULL,
    "value" INTEGER NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "is_default" BOOLEAN NOT NULL,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "benefit_groups_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "subscription_plans" (
    "uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "price" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'BRL',
    "billing_period" "BillingPeriod" NOT NULL,
    "payer_type" "PayerType" NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscription_plans_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "subscriptions" (
    "uuid" TEXT NOT NULL,
    "subscription_plan_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT,
    "user_info_uuid" TEXT,
    "status" "SubscriptionStatus" NOT NULL DEFAULT 'ACTIVE',
    "start_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "end_date" TIMESTAMP(3),
    "next_billing_date" TIMESTAMP(3),
    "employer_item_details_uuid" TEXT,
    "user_item_uuid" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("uuid")
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
    "product_type" "ProductType" NOT NULL DEFAULT 'PHYSICAL',
    "ean_code" TEXT,
    "brand" TEXT,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "original_price" INTEGER NOT NULL,
    "promotional_price" INTEGER NOT NULL,
    "discount" INTEGER NOT NULL,
    "image_urls" TEXT[],
    "is_mega_promotion" BOOLEAN NOT NULL DEFAULT false,
    "stock" INTEGER NOT NULL,
    "weight" TEXT,
    "height" TEXT,
    "width" TEXT,
    "business_info_uuid" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_by_uuid" TEXT NOT NULL,
    "updated_by_uuid" TEXT NOT NULL,
    "deleted_at" TIMESTAMP(3),
    "deleted_by_uuid" TEXT,
    "created_at" TEXT,
    "updated_at" TEXT,

    CONSTRAINT "products_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "product_history" (
    "uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "changed_by_uuid" TEXT NOT NULL,
    "field_changed" TEXT NOT NULL,
    "old_value" TEXT,
    "new_value" TEXT,
    "changed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_history_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "ean_products" (
    "uuid" TEXT NOT NULL,
    "ean_code" TEXT NOT NULL,
    "name" TEXT,
    "image_url" TEXT,
    "brand" TEXT,
    "description" TEXT,
    "max_price" INTEGER,
    "min_price" INTEGER,
    "gross_weight" INTEGER,
    "net_weight" INTEGER,
    "height" DOUBLE PRECISION,
    "length" DOUBLE PRECISION,
    "width" DOUBLE PRECISION,
    "grpc_code" TEXT,
    "ncm_code" TEXT,
    "origin" TEXT,
    "created_at" TEXT,

    CONSTRAINT "ean_products_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "carts" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "carts_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "cart_items" (
    "uuid" TEXT NOT NULL,
    "cart_uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "deleted_at" TIMESTAMP(3),

    CONSTRAINT "cart_items_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "correct_user_business" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "correct_admin_uuid" TEXT,
    "created_at" TEXT NOT NULL,

    CONSTRAINT "correct_user_business_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "service_requests" (
    "uuid" TEXT NOT NULL,
    "user_info_uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "product_uuid" TEXT NOT NULL,
    "status" "RequestStatus" NOT NULL DEFAULT 'PENDING_PROVIDER_OPTIONS',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "service_requests_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "requested_windows" (
    "uuid" TEXT NOT NULL,
    "service_request_uuid" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "period" "DayPeriod" NOT NULL,

    CONSTRAINT "requested_windows_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "suggested_slots" (
    "uuid" TEXT NOT NULL,
    "service_request_uuid" TEXT NOT NULL,
    "start_datetime" TIMESTAMP(3) NOT NULL,
    "is_selected" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "suggested_slots_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "confirmed_appointments" (
    "uuid" TEXT NOT NULL,
    "service_request_uuid" TEXT NOT NULL,
    "final_scheduled_date" TIMESTAMP(3) NOT NULL,
    "status" "AppointmentStatus" NOT NULL DEFAULT 'SCHEDULED',
    "payment_transaction_uuid" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "confirmed_appointments_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "service_reviews" (
    "uuid" TEXT NOT NULL,
    "confirmed_appointment_uuid" TEXT NOT NULL,
    "user_rating" INTEGER,
    "user_comment" TEXT,
    "business_rating" INTEGER,
    "business_comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "service_reviews_pkey" PRIMARY KEY ("uuid")
);

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
    "transaction_uuid" TEXT,

    CONSTRAINT "term_acceptances_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "games" (
    "id" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "games_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "game_scores" (
    "uuid" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "metaData" JSONB,
    "playedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "gameId" TEXT NOT NULL,
    "userInfoId" TEXT,
    "businessUserId" TEXT,

    CONSTRAINT "game_scores_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_orders" (
    "uuid" TEXT NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "item_uuid" TEXT NOT NULL,
    "total_amount" INTEGER NOT NULL,
    "status" "OrderStatus" NOT NULL DEFAULT 'PENDING',
    "payment_proof_url" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "business_orders_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "business_order_items" (
    "uuid" TEXT NOT NULL,
    "order_uuid" TEXT NOT NULL,
    "user_item_uuid" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "beneficiary_snapshot" JSONB NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "business_order_items_pkey" PRIMARY KEY ("uuid")
);

-- CreateTable
CREATE TABLE "_UserBusinessInfo" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,

    CONSTRAINT "_UserBusinessInfo_AB_pkey" PRIMARY KEY ("A","B")
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
CREATE INDEX "login_histories_user_info_uuid_idx" ON "login_histories"("user_info_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "business_data_document_key" ON "business_data"("document");

-- CreateIndex
CREATE UNIQUE INDEX "business_data_email_key" ON "business_data"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_info_document_key" ON "user_info"("document");

-- CreateIndex
CREATE UNIQUE INDEX "user_info_email_key" ON "user_info"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_auth_document_key" ON "users_auth"("document");

-- CreateIndex
CREATE UNIQUE INDEX "users_auth_email_key" ON "users_auth"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_item_user_info_uuid_business_info_uuid_item_uuid_key" ON "user_item"("user_info_uuid", "business_info_uuid", "item_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "offline_tokens_token_code_key" ON "offline_tokens"("token_code");

-- CreateIndex
CREATE INDEX "offline_tokens_user_info_uuid_user_item_uuid_status_idx" ON "offline_tokens"("user_info_uuid", "user_item_uuid", "status");

-- CreateIndex
CREATE INDEX "offline_tokens_token_code_idx" ON "offline_tokens"("token_code");

-- CreateIndex
CREATE INDEX "offline_tokens_status_expires_at_idx" ON "offline_tokens"("status", "expires_at");

-- CreateIndex
CREATE INDEX "offline_token_history_token_code_idx" ON "offline_token_history"("token_code");

-- CreateIndex
CREATE INDEX "offline_token_history_user_info_uuid_user_item_uuid_idx" ON "offline_token_history"("user_info_uuid", "user_item_uuid");

-- CreateIndex
CREATE INDEX "offline_token_history_related_transaction_uuid_idx" ON "offline_token_history"("related_transaction_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "transactions_provider_tx_id_key" ON "transactions"("provider_tx_id");

-- CreateIndex
CREATE UNIQUE INDEX "transactions_pix_e2e_id_key" ON "transactions"("pix_e2e_id");

-- CreateIndex
CREATE UNIQUE INDEX "partner_config_business_info_uuid_key" ON "partner_config"("business_info_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "ean_products_ean_code_key" ON "ean_products"("ean_code");

-- CreateIndex
CREATE UNIQUE INDEX "carts_user_info_uuid_business_info_uuid_key" ON "carts"("user_info_uuid", "business_info_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "cart_items_cart_uuid_product_uuid_key" ON "cart_items"("cart_uuid", "product_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "confirmed_appointments_service_request_uuid_key" ON "confirmed_appointments"("service_request_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "confirmed_appointments_payment_transaction_uuid_key" ON "confirmed_appointments"("payment_transaction_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "service_reviews_confirmed_appointment_uuid_key" ON "service_reviews"("confirmed_appointment_uuid");

-- CreateIndex
CREATE INDEX "terms_of_service_type_is_active_idx" ON "terms_of_service"("type", "is_active");

-- CreateIndex
CREATE INDEX "term_acceptances_app_user_info_uuid_idx" ON "term_acceptances"("app_user_info_uuid");

-- CreateIndex
CREATE INDEX "term_acceptances_company_user_uuid_idx" ON "term_acceptances"("company_user_uuid");

-- CreateIndex
CREATE INDEX "term_acceptances_transaction_uuid_idx" ON "term_acceptances"("transaction_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "games_slug_key" ON "games"("slug");

-- CreateIndex
CREATE INDEX "game_scores_gameId_score_idx" ON "game_scores"("gameId", "score" DESC);

-- CreateIndex
CREATE INDEX "game_scores_userInfoId_idx" ON "game_scores"("userInfoId");

-- CreateIndex
CREATE INDEX "game_scores_businessUserId_idx" ON "game_scores"("businessUserId");

-- CreateIndex
CREATE INDEX "_UserBusinessInfo_B_index" ON "_UserBusinessInfo"("B");

-- AddForeignKey
ALTER TABLE "business_users" ADD CONSTRAINT "business_users_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correctAdmin_business" ADD CONSTRAINT "correctAdmin_business_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correctAdmin_business" ADD CONSTRAINT "correctAdmin_business_correct_admin_uuid_fkey" FOREIGN KEY ("correct_admin_uuid") REFERENCES "correct_admin"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_data" ADD CONSTRAINT "business_data_address_uuid_fkey" FOREIGN KEY ("address_uuid") REFERENCES "addresses"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_address_uuid_fkey" FOREIGN KEY ("address_uuid") REFERENCES "addresses"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_info" ADD CONSTRAINT "user_info_user_document_validation_uuid_fkey" FOREIGN KEY ("user_document_validation_uuid") REFERENCES "user_document_validation"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

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
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item" ADD CONSTRAINT "user_item_group_uuid_fkey" FOREIGN KEY ("group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_item_history" ADD CONSTRAINT "user_item_history_related_benefit_group_uuid_fkey" FOREIGN KEY ("related_benefit_group_uuid") REFERENCES "benefit_groups"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

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
ALTER TABLE "offline_tokens" ADD CONSTRAINT "offline_tokens_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_tokens" ADD CONSTRAINT "offline_tokens_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offline_token_history" ADD CONSTRAINT "offline_token_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_user_uuid_fkey" FOREIGN KEY ("favored_user_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_business_info_uuid_fkey" FOREIGN KEY ("favored_business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_favored_partner_user_uuid_fkey" FOREIGN KEY ("favored_partner_user_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_payer_business_info_uuid_fkey" FOREIGN KEY ("payer_business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_subscription_uuid_fkey" FOREIGN KEY ("subscription_uuid") REFERENCES "subscriptions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_account_history" ADD CONSTRAINT "correct_account_history_correct_account_uuid_fkey" FOREIGN KEY ("correct_account_uuid") REFERENCES "correct_account"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_account_history" ADD CONSTRAINT "correct_account_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_account" ADD CONSTRAINT "business_account_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_account_history" ADD CONSTRAINT "business_account_history_business_account_uuid_fkey" FOREIGN KEY ("business_account_uuid") REFERENCES "business_account"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_account_history" ADD CONSTRAINT "business_account_history_related_transaction_uuid_fkey" FOREIGN KEY ("related_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner_credit_spends" ADD CONSTRAINT "partner_credit_spends_partner_credit_uuid_fkey" FOREIGN KEY ("partner_credit_uuid") REFERENCES "partner_credits"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner_credit_spends" ADD CONSTRAINT "partner_credit_spends_spending_transaction_uuid_fkey" FOREIGN KEY ("spending_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner_config" ADD CONSTRAINT "partner_config_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_notification" ADD CONSTRAINT "user_notification_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_notifications" ADD CONSTRAINT "business_notifications_business_user_uuid_fkey" FOREIGN KEY ("business_user_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "benefit_groups" ADD CONSTRAINT "benefit_groups_employer_item_details_uuid_fkey" FOREIGN KEY ("employer_item_details_uuid") REFERENCES "employer_item_details"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscription_plans" ADD CONSTRAINT "subscription_plans_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_subscription_plan_uuid_fkey" FOREIGN KEY ("subscription_plan_uuid") REFERENCES "subscription_plans"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_employer_item_details_uuid_fkey" FOREIGN KEY ("employer_item_details_uuid") REFERENCES "employer_item_details"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "subscriptions" ADD CONSTRAINT "subscriptions_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_category_uuid_fkey" FOREIGN KEY ("category_uuid") REFERENCES "categories"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_created_by_uuid_fkey" FOREIGN KEY ("created_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_updated_by_uuid_fkey" FOREIGN KEY ("updated_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_deleted_by_uuid_fkey" FOREIGN KEY ("deleted_by_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_history" ADD CONSTRAINT "product_history_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_history" ADD CONSTRAINT "product_history_changed_by_uuid_fkey" FOREIGN KEY ("changed_by_uuid") REFERENCES "business_users"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carts" ADD CONSTRAINT "carts_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "carts" ADD CONSTRAINT "carts_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_cart_uuid_fkey" FOREIGN KEY ("cart_uuid") REFERENCES "carts"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "cart_items" ADD CONSTRAINT "cart_items_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_user_business" ADD CONSTRAINT "correct_user_business_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "correct_user_business" ADD CONSTRAINT "correct_user_business_correct_admin_uuid_fkey" FOREIGN KEY ("correct_admin_uuid") REFERENCES "correct_admin"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_requests" ADD CONSTRAINT "service_requests_user_info_uuid_fkey" FOREIGN KEY ("user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_requests" ADD CONSTRAINT "service_requests_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_requests" ADD CONSTRAINT "service_requests_product_uuid_fkey" FOREIGN KEY ("product_uuid") REFERENCES "products"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "requested_windows" ADD CONSTRAINT "requested_windows_service_request_uuid_fkey" FOREIGN KEY ("service_request_uuid") REFERENCES "service_requests"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "suggested_slots" ADD CONSTRAINT "suggested_slots_service_request_uuid_fkey" FOREIGN KEY ("service_request_uuid") REFERENCES "service_requests"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "confirmed_appointments" ADD CONSTRAINT "confirmed_appointments_service_request_uuid_fkey" FOREIGN KEY ("service_request_uuid") REFERENCES "service_requests"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "confirmed_appointments" ADD CONSTRAINT "confirmed_appointments_payment_transaction_uuid_fkey" FOREIGN KEY ("payment_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "service_reviews" ADD CONSTRAINT "service_reviews_confirmed_appointment_uuid_fkey" FOREIGN KEY ("confirmed_appointment_uuid") REFERENCES "confirmed_appointments"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_terms_uuid_fkey" FOREIGN KEY ("terms_uuid") REFERENCES "terms_of_service"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_app_user_info_uuid_fkey" FOREIGN KEY ("app_user_info_uuid") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_company_user_uuid_fkey" FOREIGN KEY ("company_user_uuid") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "term_acceptances" ADD CONSTRAINT "term_acceptances_transaction_uuid_fkey" FOREIGN KEY ("transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_userInfoId_fkey" FOREIGN KEY ("userInfoId") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_businessUserId_fkey" FOREIGN KEY ("businessUserId") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_orders" ADD CONSTRAINT "business_orders_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_orders" ADD CONSTRAINT "business_orders_item_uuid_fkey" FOREIGN KEY ("item_uuid") REFERENCES "items"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_order_items" ADD CONSTRAINT "business_order_items_order_uuid_fkey" FOREIGN KEY ("order_uuid") REFERENCES "business_orders"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "business_order_items" ADD CONSTRAINT "business_order_items_user_item_uuid_fkey" FOREIGN KEY ("user_item_uuid") REFERENCES "user_item"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserBusinessInfo" ADD CONSTRAINT "_UserBusinessInfo_A_fkey" FOREIGN KEY ("A") REFERENCES "business_data"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserBusinessInfo" ADD CONSTRAINT "_UserBusinessInfo_B_fkey" FOREIGN KEY ("B") REFERENCES "user_info"("uuid") ON DELETE CASCADE ON UPDATE CASCADE;
