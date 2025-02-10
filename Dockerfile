# Stage 1: Build the FastAPI application
FROM python:3.11-slim-buster AS fastapi 

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Nginx for reverse proxy
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=fastapi /app /app

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
