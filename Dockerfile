# Use a specific version instead of latest
FROM nginx:1.23.3

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Add a healthcheck to monitor Nginx
HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost:80/ || exit 1

# Start as root (default unless changed earlier)
USER root

# Create a non-root user first
RUN useradd -m -r nginxuser

RUN touch /var/run/nginx.pid && chown nginxuser:nginxuser /var/run/nginx.pid

# Set ownership of necessary directories/files
RUN mkdir -p /var/cache/nginx && chown -R nginxuser:nginxuser /var/cache/nginx \
    && chown nginxuser:nginxuser /etc/nginx/nginx.conf \
    && touch /var/run/nginx.pid && chown nginxuser:nginxuser /var/run/nginx.pid

# Switch to the non-root user
USER nginxuser
