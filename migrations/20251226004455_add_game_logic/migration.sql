-- AlterTable
ALTER TABLE "business_users" ADD COLUMN     "gamerTag" TEXT;

-- AlterTable
ALTER TABLE "user_info" ADD COLUMN     "gamerTag" TEXT;

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

-- CreateIndex
CREATE UNIQUE INDEX "games_slug_key" ON "games"("slug");

-- CreateIndex
CREATE INDEX "game_scores_gameId_score_idx" ON "game_scores"("gameId", "score" DESC);

-- CreateIndex
CREATE INDEX "game_scores_userInfoId_idx" ON "game_scores"("userInfoId");

-- CreateIndex
CREATE INDEX "game_scores_businessUserId_idx" ON "game_scores"("businessUserId");

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "games"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_userInfoId_fkey" FOREIGN KEY ("userInfoId") REFERENCES "user_info"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "game_scores" ADD CONSTRAINT "game_scores_businessUserId_fkey" FOREIGN KEY ("businessUserId") REFERENCES "business_users"("uuid") ON DELETE SET NULL ON UPDATE CASCADE;
