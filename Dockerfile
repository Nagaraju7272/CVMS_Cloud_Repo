# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the working directory
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose port 8000 for the application
EXPOSE 8000

# Run migrations and start the application
CMD ["sh", "-c", "python manage.py migrate && gunicorn --bind 0.0.0.0:8000 cvms.wsgi:application"]