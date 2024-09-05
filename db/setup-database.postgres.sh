#!/bin/bash

# Ideally you should be able to use `npx prisma migrate dev` to migrate your Postgres database but if that fails for any
# reason, you can use this script to get started quickly.

DB_NAME="qurban-sons"

# Check if the database exists
db_exists=$(psql -tAc "SELECT 1 FROM pg_database WHERE datname='$QURBAN_SONS'")

if [ "$db_exists" != "1" ]; then
  # Create the database
  echo "Creating database..."
  psql -c "CREATE DATABASE $QURBAN_SONS;"
else
  echo "Database already exists, skipping creation..."
fi

# Connect to the database and create the users table if it doesn't exist
echo "Creating users table..."
psql -d $QURBAN_SONS -c "
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  account_id TEXT NOT NULL,
  country TEXT NOT NULL,
  last_login_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"

echo "Setup complete!"