# Multi-stage Dockerfile for Flutter Web Application
# Stage 1: Build the Flutter web app
FROM ghcr.io/cirruslabs/flutter:latest AS build

# Set working directory
WORKDIR /app

# Copy pubspec files first to leverage Docker layer caching
COPY pubspec.yaml pubspec.lock ./

# Get Flutter dependencies
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Enable web support and build for production
RUN flutter config --enable-web
RUN flutter build web --release

# Stage 2: Production image with Nginx
FROM nginx:alpine AS production

# Install bash for better script support (optional)
RUN apk add --no-cache bash

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy built Flutter web app from build stage
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create nginx cache directories
RUN mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /var/cache/nginx/proxy_temp \
    && mkdir -p /var/cache/nginx/fastcgi_temp \
    && mkdir -p /var/cache/nginx/uwsgi_temp \
    && mkdir -p /var/cache/nginx/scgi_temp \
    && chown -R nginx:nginx /var/cache/nginx \
    && chown -R nginx:nginx /usr/share/nginx/html

# Create nginx run directory
RUN mkdir -p /var/run/nginx

# Health check to ensure the container is running properly
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# Expose port 80
EXPOSE 80

# Add labels for better container management
LABEL maintainer="resume-agent-team"
LABEL description="Flutter Web Application for Enhanced Resume Agent"
LABEL version="1.0.0"

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
