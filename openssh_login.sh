#!/bin/bash
# MAKE SURE TO RUN THE openssh_command.sh FIRST!!!

read -re -p "Insert your SSH target (username@your_ip_address) :" SSH_SERVER
read -re -p "Insert your Port :" SSH_PORT

if [[ -z "$SSH_SERVER" ]]; then
    echo "Error: Server target cannot be empty."
    exit 1
fi

if [[ -z "$SSH_PORT" ]]; then
    echo "Error: The Port cannot be empty."
    exit 1
fi


ssh -p "$SSH_PORT" "$SSH_SERVER"