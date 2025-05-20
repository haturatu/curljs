const puppeteer = require('puppeteer');

(async () => {
    const url = process.argv[2];
    if (!url) {
        console.error('Error: URL not provided.');
        process.exit(1);
    }

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    await page.goto(url, {
        waitUntil: 'networkidle2',
    });

    // await page.waitForTimeout(5000);
    await new Promise(resolve => setTimeout(resolve, 5000));

    const html = await page.content();
    console.log(html);

    await browser.close();
})();

