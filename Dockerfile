FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy ALL application context files and infrastructure modules
COPY . .

# Switch to a non-root user for defensive security hardening
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Declare the networking boundary port
EXPOSE 8080

# Run the service using the Gunicorn WSGI production server
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
