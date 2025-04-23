# use stable LTS version of alpine
FROM node:lts-alpine
WORKDIR /app/

WORKDIR /app/
COPY . .
RUN npm i -D
RUN npm run smui
RUN npm run build
EXPOSE 8080
CMD ["npm", "run", "preview", "--", "--port", "8080", "--host"]
