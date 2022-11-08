FROM node:alpine as build-step
#ENV NODE_ENV=production
WORKDIR /app
COPY ["package.json", "yarn.lock", "./"]
RUN yarn install
COPY . ./
RUN yarn build

FROM node:alpine
ENV NODE_ENV=production
WORKDIR /app
COPY ["package.json", "yarn.lock", "./"]
RUN npm install --production
COPY --from=build-step /app/dist/ .
CMD [ "node", "index.js" ]


