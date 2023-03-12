# Nove - Node Version Manager

Nove is a shell-based Node.js version manager, similar to nvm and n. With nove, you can easily install and use different versions of Node.js on your system.

# Installation

To install nove, run the following command in a terminal window:

```bash
git clone https://github.com/vclemenzi/nove && cd nove
```

```bash
sudo sh install.sh
```

This will download the installation file from the Github repository, and execute it with bash. If prompted for a password, enter your system password.

# Usage

## Installing Node.js

To install a specific version of Node.js using nove, run:

```bash
nove install <version>
```

Where `<version>` is the version of Node.js you want to install. For example, to install Node.js version 14.15.1, run:

```bash
nove install 14.15.1
```

## Using Node.js

To use a specific version of Node.js, run:

```bash
nove use <version>
```

Where `<version>` is the version of Node.js you want to use. For example, to use Node.js version 14.15.1, run:

```bash
nove use 14.15.1
```

If you want to run a file using a specific version of Node.js, run:

```bash
nove run <version> <file>
```

Where `<version>` is the version of Node.js you want to use, and `<file>` is the file you want to run. For example, to run `index.js` using Node.js version 14.15.1, run:

```bash
nove run 14.15.1 index.js
```