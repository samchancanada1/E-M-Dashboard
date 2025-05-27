# Stage 1: Build Flutter Web App
FROM cirrusci/flutter:stable AS build

WORKDIR /app
COPY . .

RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web --release --dart-define=API_URL=http://localhost:8080

# Stage 2: Serve with nginx
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
