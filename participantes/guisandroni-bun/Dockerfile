FROM oven/bun:1.2.19-slim AS build

WORKDIR /app

COPY package.json ./
COPY bun.lock ./
COPY tsconfig.json ./

RUN bun install

COPY index.ts ./

RUN bun build --compile --minify-whitespace --minify-syntax --target bun --outfile /server ./index.ts

FROM oven/bun:slim AS production

COPY --from=build /server /server

ENV NODE_ENV=production

ENTRYPOINT [ "/server" ]
