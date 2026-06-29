# Stage 1: Build the static site with Hugo
FROM klakegg/hugo:ext-alpine AS builder

WORKDIR /src

# Install git (for Hugo's git info) and Node.js/npm (for PostCSS/Autoprefixer)
RUN apk add --no-cache git nodejs npm && \
    git config --global --add safe.directory /src

# Install Node dependencies first so they can be cached if package files don't change
COPY package*.json ./
RUN npm ci

# Copy the rest of the source
COPY . .

# Build the site
RUN hugo --minify

# Stage 2: Serve the generated site with nginx
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /src/public /usr/share/nginx/html

# Expose the HTTP port
EXPOSE 80
