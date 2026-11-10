
FROM alpine:3.21 AS source
RUN apk add --no-cache git
WORKDIR /sources
RUN git clone --depth 1 --branch main https://github.com/rafael-kuchla-flores/Descarte_Tecidos.git frontend \
 && git clone --depth 1 --branch main https://github.com/lucastnsoares/ecotecidos-api.git backend

FROM node:24-alpine AS frontend-build
WORKDIR /build
COPY --from=source /sources/frontend/Descarte_Tecidos/ ./
RUN npm ci
ENV VITE_API_URL=/api/v1
RUN npm run build

FROM maven:3.9-eclipse-temurin-21 AS backend-build
WORKDIR /build
COPY --from=source /sources/backend/pom.xml ./
COPY --from=source /sources/backend/src ./src
RUN mvn -B -DskipTests clean package

FROM eclipse-temurin:21-jre-jammy
RUN apt-get update && apt-get install -y --no-install-recommends nginx \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=backend-build /build/target/*.jar /app/app.jar
COPY --from=frontend-build /build/dist/ /var/www/ecotecidos/
COPY nginx.conf /etc/nginx/sites-enabled/default
RUN mkdir -p /app/uploads
ENV SERVER_PORT=8080
EXPOSE 10000
CMD ["/bin/sh", "-c", "java -Djava.awt.headless=true -jar /app/app.jar & exec nginx -g 'daemon off;'"]
