# Use an official Python runtime as the base image
FROM python:3.11

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install dependencies
RUN pip install --no-cache-dir django

# Expose the port the app runs on (if applicable)
# EXPOSE 8000

# Command to run the application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

