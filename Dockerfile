FROM node:20-alpine AS FrontendBuilder
WORKDIR /app

COPY package*.json /app
RUN npm install 

COPY . /app
RUN npm run build


FROM node:20-slim AS FrontendRunner
WORKDIR /newApp

COPY --from=FrontendBuilder /app/package*.json ./
COPY --from=FrontendBuilder /app/node_modules ./node_modules
COPY --from=FrontendBuilder /app/.next ./.next
COPY --from=FrontendBuilder /app/public ./public


EXPOSE 3000

CMD ["npm","run","start"]
