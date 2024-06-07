FROM python:3.8-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . /app/

# Set the working directory to the location of manage.py
WORKDIR /app/InnovativeInteriors/myproject

# Ensure that the entrypoint or CMD is set if needed, depending on how you run your application
