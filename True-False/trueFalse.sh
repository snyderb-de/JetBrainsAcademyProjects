#!/bin/bash

# Print welcoming message
echo "Welcome to the True or False Game!"

# Set the username and password (assuming you know them from the previous stage)
USERNAME="your-username"
PASSWORD="your-password"

# Login using curl and save session cookie to cookie.txt, silencing terminal output
RESPONSE=$(curl --silent --user "$USERNAME:$PASSWORD" --cookie-jar cookie.txt http://127.0.0.1:8000/login)

# Extract login message from the response (assuming it's a JSON response with a "message" field)
LOGIN_MESSAGE=$(echo $RESPONSE | grep -oP '"message":"\K[^"]+')

# Print the login message
echo "Login message: $LOGIN_MESSAGE"