#!/bin/sh

is_root() {
    if [ "$EUID" -ne 0 ]
    then
        echo -e "\e[1;31mPlease run this script as root.\e[0m"
        exit
    fi
}

case $1 in
    "install")
        is_root

        if [ $2 = "latest" ]
        then
            # Get latest version
            version=$(curl -s https://nodejs.org/dist/latest/ | grep -oP 'node-v\d+\.\d+\.\d+-linux-x64.tar.xz' | grep -oP '\d+\.\d+\.\d+' | tail -n 1)
        else
            version=$2
        fi

        echo -e "\e[1;2m[0/5]\e[0m \e[1;33mInstalling Node.js $version...\e[0m"

        # Download Node
        curl -sL https://nodejs.org/dist/v$version/node-v$version-linux-x64.tar.xz -o /etc/node-v$version-linux-x64.tar.xz
        echo -e "\e[1;2m[1/5]\e[0m \e[1;33mDownloading Node...\e[0m"

        # Extract Node
        tar -xf /etc/node-v$version-linux-x64.tar.xz -C /etc/
        echo -e "\e[1;2m[2/5]\e[0m \e[1;33mExtracting Node...\e[0m"

        # Replace Node binary
        rm -rf /usr/bin/node
        ln -s /etc/node-v$version-linux-x64/bin/node /usr/bin/node
        echo -e "\e[1;2m[3/5]\e[0m \e[1;33mReplacing Node binary...\e[0m"

        if [ "$3" = "--skip-npm" ];
        then
            echo -e "\e[1;2m[4/5]\e[0m \e[1;33mSkipping NPM installation...\e[0m"
        else
            rm -rf /usr/bin/npm
            ln -s /etc/node-v$version-linux-x64/bin/npm /usr/bin/npm

            rm -rf /usr/bin/npx
            ln -s /etc/node-v$version-linux-x64/bin/npx /usr/bin/npx

            echo -e "\e[1;2m[4/5]\e[0m \e[1;33mReplacing NPM binary...\e[0m"
        fi

        # Remove Node archive
        rm -rf /etc/node-v$version-linux-x64.tar.xz
        echo -e "\e[1;2m[5/5]\e[0m \e[1;33mRemoving Node archive...\e[0m"

        # Done
        echo -e "\e[1;2m[---]\e[0m \e[1;32mNode $version installed successfully!\e[0m | \e[1;33mRun 'node -v' to check the version.\e[0m"

        exit 0
        ;;

    "use" | "run")
        if [ $2 = "latest" ]
        then
            # Get latest version
            version=$(curl -s https://nodejs.org/dist/latest/ | grep -oP 'node-v\d+\.\d+\.\d+-linux-x64.tar.xz' | grep -oP '\d+\.\d+\.\d+' | tail -n 1)
        else
            version=$2
        fi

        if [ -d "/home/$USER/.novebin/node-v$version-linux-x64/" ]; then
            /home/$USER/.novebin/node-v$version-linux-x64/bin/node $3
            exit 0
        fi

        mkdir /home/$USER/.novebin
        mkdir /home/$USER/.novebin/tarball

        # Download Node
        curl -sL https://nodejs.org/dist/v$version/node-v$version-linux-x64.tar.xz -o /home/$USER/.novebin/tarball/node-v$version-linux-x64.tar.xz
        tar -xf /etc/node-v$version-linux-x64.tar.xz -C /home/$USER/.novebin

        # Run Node binary
        /home/$USER/.novebin/node-v$version-linux-x64/bin/node $3
        exit 0
        ;;
    *)
        echo "Usage: nove [install | use] [version] [...args]"
        ;;
esac
