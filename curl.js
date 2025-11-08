const puppeteer = require('puppeteer');

const helpMessage = `
Usage: curljs <URL> [options]

Fetches and displays the HTML content of a web page, similar to curl.

Options:
  -h, --help          Show this help message.
  --selector <css>    Extract the outer HTML of the first element matching the CSS selector.
  --timeout <ms>      Wait for a specific amount of time in milliseconds after the page loads.
                      (Default: 5000)

Example:
  curljs https://example.com
  curljs https://example.com --selector "h1"
  curljs https://example.com --timeout 10000
`;

const argv = process.argv;

if (argv.includes('--help') || argv.includes('-h')) {
    console.log(helpMessage);
    process.exit(0);
}

// Helper function to parse arguments
const getArgValue = (argName, defaultValue) => {
    const argIndex = argv.indexOf(argName);
    if (argIndex > -1 && argv[argIndex + 1] && !argv[argIndex + 1].startsWith('-')) {
        return argv[argIndex + 1];
    }
    return defaultValue;
};

const url = argv.find(arg => arg.startsWith('http://') || arg.startsWith('https://'));
const timeout = parseInt(getArgValue('--timeout', '5000'), 10);
const selector = getArgValue('--selector', null);

if (!url) {
    console.error('Error: URL not provided.');
    console.error('Usage: curljs <URL> [options]');
    process.exit(1);
}

(async () => {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    const userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36';
    await page.setUserAgent(userAgent);

    try {
        await page.goto(url, {
            waitUntil: 'networkidle2',
            timeout: 60000 // 60 seconds for page navigation
        });

        await new Promise(resolve => setTimeout(resolve, timeout));

        let output;
        if (selector) {
            await page.waitForSelector(selector, { timeout: 10000 });
            output = await page.$eval(selector, el => el.outerHTML);
        } else {
            output = await page.content();
        }
        console.log(output);

    } catch (error) {
        console.error(`Error processing ${url}:`, error.message);
        if (error.name === 'TimeoutError' && selector) {
            console.error(`  Could not find selector "${selector}" on the page within the allowed time.`);
        }
        process.exit(1);
    } finally {
        await browser.close();
    }
})();

