@echo off
echo Fixing directory structures...

if not exist src\components\site mkdir src\components\site

:: Move components to src\components\site\
move /y src\components\Footer.tsx src\components\site\
move /y src\components\Nav.tsx src\components\site\
move /y src\components\WatchCard.tsx src\components\site\
move /y src\components\GoldCursor.tsx src\components\site\
move /y src\components\CookieBanner.tsx src\components\site\

:: Move helper files to src\lib\
move /y src\lovable-error-reporting.ts src\lib\
move /y src\image-map.ts src\lib\
move /y src\error-capture.ts src\lib\
move /y src\error-page.ts src\lib\
move /y sanitize.ts src\lib\

echo Directory structure fixed!
