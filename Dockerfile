# Primeiro estágio

FROM node:18-alpine3.19 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn

COPY . .

RUN yarn run build

# Segundo estágio

FROM node:18-alpine3.19

WORKDIR /usr/src/app

COPY --from=build /usr/src/app/dist ./dist
COPY --from=build /usr/src/app/node_modules ./node_modules

EXPOSE 3000

CMD ["yarn", "run", "start"]