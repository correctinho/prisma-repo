-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('PENDING_PROVIDER_OPTIONS', 'PENDING_USER_SELECTION', 'CONFIRMED', 'DECLINED', 'EXPIRED');

-- CreateEnum
CREATE TYPE "DayPeriod" AS ENUM ('MORNING', 'AFTERNOON', 'EVENING');

-- CreateEnum
CREATE TYPE "AppointmentStatus" AS ENUM ('SCHEDULED', 'COMPLETED', 'CANCELED', 'NO_SHOW');

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

-- CreateIndex
CREATE UNIQUE INDEX "confirmed_appointments_service_request_uuid_key" ON "confirmed_appointments"("service_request_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "confirmed_appointments_payment_transaction_uuid_key" ON "confirmed_appointments"("payment_transaction_uuid");

-- CreateIndex
CREATE UNIQUE INDEX "service_reviews_confirmed_appointment_uuid_key" ON "service_reviews"("confirmed_appointment_uuid");

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
