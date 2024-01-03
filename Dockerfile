FROM node:20-alpine AS base-image

FROM base-image AS base

WORKDIR /service

COPY . .

RUN npm install

RUN npm run build

FROM base-image AS production

WORKDIR /service

COPY . .

# frontend sources
COPY --from=base /service/dist dist
COPY --from=base /service/node_modules node_modules


CMD ["npm", "run", "dev"]