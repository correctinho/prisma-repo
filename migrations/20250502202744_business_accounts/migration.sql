-- CreateEnum
CREATE TYPE "PartnerCreditStatus" AS ENUM ('PENDING', 'SETTLED');

-- CreateTable
CREATE TABLE "business_account" (
    "uuid" TEXT NOT NULL,
    "balance" INTEGER NOT NULL,
    "business_info_uuid" TEXT NOT NULL,
    "created_at" TEXT NOT NULL,
    "updated_at" TEXT,

    CONSTRAINT "business_account_pkey" PRIMARY KEY ("uuid")
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

-- AddForeignKey
ALTER TABLE "business_account" ADD CONSTRAINT "business_account_business_info_uuid_fkey" FOREIGN KEY ("business_info_uuid") REFERENCES "business_data"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner_credit_spends" ADD CONSTRAINT "partner_credit_spends_partner_credit_uuid_fkey" FOREIGN KEY ("partner_credit_uuid") REFERENCES "partner_credits"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "partner_credit_spends" ADD CONSTRAINT "partner_credit_spends_spending_transaction_uuid_fkey" FOREIGN KEY ("spending_transaction_uuid") REFERENCES "transactions"("uuid") ON DELETE RESTRICT ON UPDATE CASCADE;
