# curl.js

A command-line tool that fetches the HTML of a website after JavaScript rendering, similar to `curl`. It uses Puppeteer (Headless Chrome) to load the page.

This tool is designed to be installed system-wide, allowing all users to run the `curljs` command.

## Installation

1.  Clone this repository:
    ```bash
    # Replace with your repository's URL
    git clone https://github.com/haturatu/curljs.git
    cd curljs
    ```

2.  Run the install command. This will install `curljs` to `/usr/local/bin` and its dependencies (including a dedicated browser) to `/usr/local/lib/curljs`.

    ```bash
    make install
    ```
    > **Note:** You may need to run this command with `sudo` if you don't have write permissions to `/usr/local`.
    > `sudo make install`

## Usage

Once installed, you can use the `curljs` command from anywhere in your system.

### Basic Usage
```bash
curljs <URL>
```
Example:
```bash
curljs https://example.com
```

### Options

| Option             | Description                                                              |
| ------------------ | ------------------------------------------------------------------------ |
| `--timeout <ms>`   | Time to wait in milliseconds after the page loads. (Default: 5000)       |
| `--selector <css>` | Extract the outer HTML of the first element matching the CSS selector.   |
| `-h, --help`       | Show the help message.                                                   |

### Examples

**Set a 10-second timeout:**
```bash
curljs https://example.com --timeout 10000
```

**Extract the content of the `<h1>` tag:**
```bash
curljs https://example.com --selector "h1"
```

## How It Works

The `make install` command performs two main actions:
1.  **Copies the wrapper script** to `/usr/local/bin/curljs`, making the command available system-wide.
2.  **Copies the core application** and its dependencies (including Node.js modules and a dedicated version of the Chrome browser for Puppeteer) to `/usr/local/lib/curljs`.

This setup ensures that `curljs` is a self-contained, shared command that can be executed by any user on the system.

## Uninstallation

To remove `curljs` and all its related files from your system, run:
```bash
make uninstall
```
> **Note:** You may need to run this with `sudo`.
> `sudo make uninstall`
