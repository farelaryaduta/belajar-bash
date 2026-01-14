#!/bin/bash

# Checking for Package
PACKAGES=("openssh-client" "openssh-server")
MISSING_PACKAGES=()

for pkg in "${PACKAGES[@]}"; do
    if ! dpkg-query -W --showformat='${Status}' "${pkg}" 2>/dev/null | grep -q "install ok installed"; then
        MISSING_PACKAGES+=("${pkg}")
    fi
done

if [ ${#MISSING_PACKAGES[@]} -gt 0 ]; then
    echo "Installing missing dependencies: ${MISSING_PACKAGES[*]}"
    sudo apt update && sudo apt install -y "${MISSING_PACKAGES[@]}"
fi

# Setting up the SSH Key
KEY_PATH="$HOME/.ssh/id_ed25519" # -> Leading to your Home Directory and Making the SSH Key Automaticly

if [ ! -f "$KEY_PATH" ]; then
    echo "No SSH key found at $KEY_PATH."
    ssh-keygen -t ed25519 -f "$KEY_PATH" -N ""
else
    echo "Using existing SSH key: $KEY_PATH"
fi

# Input your SSH Target
echo -e "\n--- Remote Server Configuration ---"
read -re -p "Enter Target (username@server_ip): " SSH_SERVER
read -re -p "Enter Your SSH port : " SSH_PORT

if [[ -z "$SSH_SERVER" ]]; then
    echo "Error: Server target cannot be empty."
    exit 1
fi

if [[ -z "$SSH_PORT" ]]; then
    echo "Error: Your Port cannot be empty."
    exit 1
fi

echo "Attempting to push your public key to $SSH_SERVER..."
echo "Note: You will need to type the server password manually this one time."

ssh-copy-id -p "$SSH_PORT" -i "${KEY_PATH}.pub" "$SSH_SERVER"

if [ $? -eq 0 ]; then
    echo -e "\n[SUCCESS] Key-based authentication is active!"
    echo "You can now login without a password by typing: ssh $SSH_SERVER"
else
    echo -e "\n[ERROR] Failed to send key. Check your IP and Password."
fi