# Estágio de Construção
FROM node:lts-alpine as build-stage

WORKDIR /app

COPY package.json .
COPY yarn.lock .
COPY node_modules/. ./node_modules

RUN yarn

COPY . .

RUN yarn build

# Estágio de Produção
FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]