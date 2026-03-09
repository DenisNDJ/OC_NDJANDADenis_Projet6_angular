FROM node:20.11.0-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --cache .npm --prefer-offline
COPY . .
RUN npm run build
FROM nginx:1.27-alpine
COPY /nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/@oc-expert-devops-training/olympic-games-starter/ /usr/share/nginx/html
EXPOSE 80