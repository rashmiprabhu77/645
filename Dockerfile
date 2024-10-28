# The official Nginx image from Docker Hub
FROM nginx:alpine

# Copy HTML and CSS files into the default nginx web directory
COPY index.html /usr/share/nginx/html/
COPY css1.css /usr/share/nginx/html/
COPY surveycss.css /usr/share/nginx/html/

# Expose port 80 to access the website
EXPOSE 80

# Start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
