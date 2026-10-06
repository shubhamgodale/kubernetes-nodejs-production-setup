# Stage 1: Build the application securely
FROM node:20-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Stage 2: Ultra-lightweight and secure runtime environment
FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app ./
USER 1000
EXPOSE 3000
CMD ["server.js"]
