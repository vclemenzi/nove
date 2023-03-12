#!/bin/usr/bash

case $1 in
    "install")
        echo -e "\e[1;2m[0/5]\e[0m \e[1;33mInstalling Node.js $2...\e[0m"

        # Download Node
        curl -sL https://nodejs.org/dist/v$2/node-v$2-linux-x64.tar.xz -o /etc/node-v$2-linux-x64.tar.xz
        echo -e "\e[1;2m[1/5]\e[0m \e[1;33mDownloading Node...\e[0m"

        # Extract Node
        tar -xf /etc/node-v$2-linux-x64.tar.xz -C /etc/
        echo -e "\e[1;2m[2/5]\e[0m \e[1;33mExtracting Node...\e[0m"

        # Replace Node binary
        rm -rf /usr/bin/node
        ln -s /etc/node-v$2-linux-x64/bin/node /usr/bin/node
        echo -e "\e[1;2m[3/5]\e[0m \e[1;33mReplacing Node binary...\e[0m"

        # Replace NPM binary
        rm -rf /usr/bin/npm
        ln -s /etc/node-v$2-linux-x64/bin/npm /usr/bin/npm
        echo -e "\e[1;2m[4/5]\e[0m \e[1;33mReplacing NPM binary...\e[0m"

        # Remove Node archive
        rm -rf /etc/node-v$2-linux-x64.tar.xz
        echo -e "\e[1;2m[5/5]\e[0m \e[1;33mRemoving Node archive...\e[0m"

        # Done
        echo -e "\e[1;2m[---]\e[0m \e[1;32mNode $2 installed successfully!\e[0m | \e[1;33mRun 'node -v' to check the version.\e[0m"
        ;;
    *)
        echo "Usage: nvm.sh [install|uninstall]"
        ;;
esac