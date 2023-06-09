FROM node:current-alpine3.17
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 8000
CMD ["npm", "start"]