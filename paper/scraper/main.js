const { chromium } = require('playwright');

const [, , route, yes, no] = process.argv;

console.log(route, yes, no);

if (!route || !yes || !no) {
    console.error('Usage: node screenshot.js <route> <yes> <no>');
    process.exit(1);
}

(async () => {
    const browser = await chromium.launch();

    const context = await browser.newContext({
        viewport: { width: 1920, height: 1080 },
        deviceScaleFactor: 2
    });

    const TIMEOUT = 200;
    const ADDRESS = 'http://localhost:5173/';
    // const ADDRESS = 'http://localhost:5173/~tra0163/';

    const page = await context.newPage();

    const url = ADDRESS + route;
    console.log('Going to', url);
    await page.goto(url, { waitUntil: "networkidle" });

    // --- prepare steps UI once (but still re-query everything)
    await page.locator('[data-screenshot-card]')
        .nth(0)
        .getByRole('checkbox', { name: 'Show steps' })
        .check();

    await page.locator('[data-screenshot-card]')
        .nth(0)
        .getByRole('checkbox', { name: 'Show steps' })
        .uncheck();

    await page.waitForTimeout(500);

    // --- get options fresh
    const optionsData = await page
        .locator('[data-screenshot-card]')
        .nth(0)
        .locator('select option')
        .evaluateAll(opts =>
            opts.map(o => ({
                value: o.value,
                text: o.textContent
            }))
        );

    console.log(optionsData);

    for (const [answer, label] of Object.entries({ yes, no })) {
        console.log(answer, label);

        if (!optionsData.find(opt => opt.value == label)) {
            console.error('There is no option called', label);
            continue;
        }

        // --- select option (fresh locator)
        await page
            .locator('[data-screenshot-card]')
            .nth(0)
            .locator('select')
            .selectOption({ label });

        // --- click buttons (fresh locators)
        await page
            .locator('[data-screenshot-card]')
            .nth(0)
            .getByRole('button', { name: 'Reduce' })
            .click();

        await page
            .locator('[data-screenshot-card]')
            .nth(0)
            .getByRole('button', { name: 'Solve' })
            .click();

        const path = `${route}-${answer}-page.png`;
        console.log('Saving screenshot', path);

        await page.waitForLoadState('networkidle');
        await page.waitForTimeout(TIMEOUT);

        // --- screenshot (fresh locator)
        await page
            .locator('[data-screenshot-card-list]')
            .screenshot({
                path,
                timeout: 10000
            });

        // --- steps (fully fresh each loop)
        if (answer === 'yes') {
            await page
                .locator('[data-screenshot-card]')
                .nth(0)
                .getByRole('checkbox', { name: 'Show steps' })
                .check();


            for (
                let i = 1;;
                await page
                    .locator('[data-screenshot-steps-card]')
                    .getByRole('button', { name: 'Next' })
                    .first()
                    .click()
            ) {

                const stepImagePath = `${route}-${answer}-step-${i++}.png`;
                console.log('Saving step screenshot', stepImagePath);

                await page.waitForTimeout(TIMEOUT);

                await page
                    .locator('[data-screenshot-steps-card]')
                    .screenshot({ path: stepImagePath });
                
                if (
                    await page
                        .locator('[data-screenshot-steps-card]')
                        .getByRole('button', { name: 'Next' })
                        .first()
                        .isDisabled()
                ) 
                    break;

            }

            await page
                .locator('[data-screenshot-card]')
                .nth(0)
                .getByRole('checkbox', { name: 'Show steps' })
                .uncheck();
        }
    }

    await page.close();
    await browser.close();
})();
