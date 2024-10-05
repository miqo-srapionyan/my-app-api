# Stage 1: Build stage
FROM node:18-alpine as builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the NestJS application (this will create the dist folder)
RUN npm run build

# Stage 2: Development stage
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy node_modules and build files from builder stage
COPY --from=builder /app/node_modules ./node_modules

# Copy the rest of the application files (including tsconfig.json and src)
COPY . .

# Expose port 3000
EXPOSE 5000

# Start the application
CMD ["npm", "run", "start"]
