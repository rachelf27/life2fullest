FROM node:current-alpine3.17
WORKDIR /app/client
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]