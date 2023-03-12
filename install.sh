#!/usr/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo -e "\e[1;31mPlease run this script as root.\e[0m"
    exit
fi

content=$(curl -sL https://raw.githubusercontent.com/vclemenzi/nove/main/nove.sh)

touch /usr/bin/nove
echo "$content" > /usr/bin/nove
chmod +x /usr/bin/nove

echo -e "\e[1;32mNove installed successfully! Run 'nove' to get started.\e[0m"