const puppeteer = require('puppeteer');

(async () => {
    // 第一引数からURLを取得
    const url = process.argv[2];
    if (!url) {
        console.error('Error: URL not provided.');
        process.exit(1);
    }

    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();

    // 特定のURLにアクセス
    await page.goto(url, {
        waitUntil: 'networkidle2', // ネットワークがアイドル状態になるまで待機
    });

    // 5秒間待機
    await page.waitForTimeout(5000);

    // ページのHTMLを取得
    const html = await page.content();
    console.log(html);

    await browser.close();
})();

