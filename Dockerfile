# Use a specific version instead of latest
FROM nginx:1.23.3

# Copy configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Add a healthcheck to monitor Nginx
HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost:9090/-/healthy || exit 1

# Create and switch to a non-root user
RUN useradd -m -r nginxuser && chown nginxuser:nginxuser /etc/nginx/nginx.conf
USER nginxuser