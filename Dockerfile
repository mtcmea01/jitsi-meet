FROM node:20

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 8080

CMD ["make", "dev"]
