# checkov:skip=CKV_DOCKER_3 Justification: Official nginx image runs as root by default and this is acceptable for our use case.
# Use a specific version instead of latest
FROM nginx:1.23.3

# Copy configuration & index.html
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Add a simple healthcheck for Nginx
HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost:80/ || exit 1
