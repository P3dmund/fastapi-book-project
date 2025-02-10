FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Nginx for reverse proxy
FROM nginx:alpine as nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copy FastAPI app from the previous stage
COPY --from=fastapi /app /app

# Expose ports
EXPOSE 80 8000

# Start both Nginx and FastAPI
CMD ["sh", "-c", "nginx && uvicorn app.main:app --host 0.0.0.0 --port 8000"]
