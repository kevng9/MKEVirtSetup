#!/bin/bash

set -e

# Prompt for Redis superuser password
read -sp 'Enter Redis superuser password: ' REDIS_PASSWORD
echo

# Update package lists and install dependencies
sudo apt-get update
sudo apt-get install -y lsb-release curl gpg

# Import the Redis GPG key
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg

# Add the Redis repository
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

# Update package lists again after adding the Redis repository
sudo apt-get update

# Install Redis
sudo apt-get install -y redis

# Set vm.overcommit_memory=1
echo 'vm.overcommit_memory=1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Modify Redis configuration to allow external connections and disable protected mode
sudo sed -i 's/^bind 127\.0\.0\.1 -::1$/bind 0\.0\.0\.0 -::*/' /etc/redis/redis.conf
sudo sed -i 's/^protected-mode yes$/protected-mode no/' /etc/redis/redis.conf

# Restart Redis server
sudo systemctl restart redis-server

# Verify that Redis is running
if pgrep redis-server > /dev/null
then
    echo "Redis server is running."
else
    echo "Redis server failed to start."
    exit 1
fi

# Configure Redis ACL user with the provided password
redis-cli ACL SETUSER superuser on ">" "$REDIS_PASSWORD" allkeys +@all

echo "Redis installation and configuration completed successfully."