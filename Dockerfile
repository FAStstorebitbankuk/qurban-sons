# Use the official Node.js 18 image.
FROM node:18

# Create and change to the app directory.
WORKDIR /usr/src/app

# Install application dependencies.
COPY package*.json ./
RUN npm install

# Copy application files.
COPY . .

# Build the application.
RUN npm run build

# Expose the port on which the app runs (typically 3000 for Next.js).
EXPOSE 3000

# Start the application.
CMD ["npx", "next", "start"]
