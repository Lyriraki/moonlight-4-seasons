# Sample Dockerfile: multi-stage build for a Bun app
FROM oven/bun:1.1 AS base
WORKDIR /app

ARG NODE_ENV=production
ENV NODE_ENV=$NODE_ENV \
    PORT=3000

# Install dependencies first so the cache gets reused
FROM base AS deps
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile --production

FROM base AS build
COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN bun run build && \
    echo "Build finished" > /tmp/status.txt

FROM base AS runtime
LABEL maintainer="alex@example.com" version="1.0"
COPY --from=build /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules

EXPOSE 3000
VOLUME ["/app/data"]
USER bun

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1

ENTRYPOINT ["bun", "run"]
CMD ["dist/index.js"]
