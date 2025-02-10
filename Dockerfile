# Stage 1: Build the FastAPI application
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Nginx for reverse proxy (separate container - BEST PRACTICE)
FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf # Or /etc/nginx/nginx.conf, adjust as needed

# Copy FastAPI app from the previous stage
COPY --from=fastapi /app /app  # Correct stage name

EXPOSE 80

CMD ["fastapi", "run", "app/main.py", "nginx", "-g", "daemon off;"]  # Nginx runs in the foreground
