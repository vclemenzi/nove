#!/usr/bin/bash

if [ "$EUID" -ne 0 ]; then
    echo -e "\e[1;31mPlease run this script as root.\e[0m"
    exit
fi

content=$(cat nove.sh | sed 's/\/bin\/usr\/bash/\/usr\/bin\/bash/g' | sed 's/\/bin\/usr\/sh/\/usr\/bin\/sh/g')

touch /usr/bin/nove
echo "$content" > /usr/bin/nove
chmod +x /usr/bin/nove

echo -e "\e[1;32mNove installed successfully! Run 'nove' to get started.\e[0m"