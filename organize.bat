@echo off
echo Organizing files into src/ directory...

:: Create directories
if not exist src mkdir src
if not exist src\routes mkdir src\routes
if not exist src\routes\_authenticated mkdir src\routes\_authenticated
if not exist src\components mkdir src\components
if not exist src\components\ui mkdir src\components\ui
if not exist src\lib mkdir src\lib
if not exist src\integrations mkdir src\integrations
if not exist src\integrations\supabase mkdir src\integrations\supabase
if not exist src\assets mkdir src\assets

:: Move root source files
move /y router.tsx src\
move /y start.ts src\
move /y server.ts src\
move /y lovable-error-reporting.ts src\
move /y error-capture.ts src\
move /y error-page.ts src\
move /y image-map.ts src\
move /y utils.ts src\
move /y use-mobile.tsx src\
move /y routeTree.gen.ts src\
move /y styles.css src\

:: Move lib functions
move /y contact.functions.ts src\lib\
move /y watches.functions.ts src\lib\

:: Move integrations / supabase
move /y client.ts src\integrations\supabase\
move /y client.server.ts src\integrations\supabase\
move /y types.ts src\integrations\supabase\
move /y auth-attacher.ts src\integrations\supabase\
move /y auth-middleware.ts src\integrations\supabase\

:: Move page components
move /y Footer.tsx src\components\
move /y Nav.tsx src\components\
move /y WatchCard.tsx src\components\
move /y GoldCursor.tsx src\components\
move /y CookieBanner.tsx src\components\

:: Move shadcn UI components
move /y accordion.tsx src\components\ui\
move /y alert.tsx src\components\ui\
move /y alert-dialog.tsx src\components\ui\
move /y aspect-ratio.tsx src\components\ui\
move /y avatar.tsx src\components\ui\
move /y badge.tsx src\components\ui\
move /y breadcrumb.tsx src\components\ui\
move /y button.tsx src\components\ui\
move /y calendar.tsx src\components\ui\
move /y card.tsx src\components\ui\
move /y carousel.tsx src\components\ui\
move /y chart.tsx src\components\ui\
move /y checkbox.tsx src\components\ui\
move /y collapsible.tsx src\components\ui\
move /y command.tsx src\components\ui\
move /y context-menu.tsx src\components\ui\
move /y dialog.tsx src\components\ui\
move /y drawer.tsx src\components\ui\
move /y dropdown-menu.tsx src\components\ui\
move /y form.tsx src\components\ui\
move /y hover-card.tsx src\components\ui\
move /y input.tsx src\components\ui\
move /y input-otp.tsx src\components\ui\
move /y label.tsx src\components\ui\
move /y menubar.tsx src\components\ui\
move /y navigation-menu.tsx src\components\ui\
move /y pagination.tsx src\components\ui\
move /y popover.tsx src\components\ui\
move /y progress.tsx src\components\ui\
move /y radio-group.tsx src\components\ui\
move /y resizable.tsx src\components\ui\
move /y scroll-area.tsx src\components\ui\
move /y select.tsx src\components\ui\
move /y separator.tsx src\components\ui\
move /y sheet.tsx src\components\ui\
move /y sidebar.tsx src\components\ui\
move /y skeleton.tsx src\components\ui\
move /y slider.tsx src\components\ui\
move /y sonner.tsx src\components\ui\
move /y switch.tsx src\components\ui\
move /y table.tsx src\components\ui\
move /y tabs.tsx src\components\ui\
move /y textarea.tsx src\components\ui\
move /y toggle.tsx src\components\ui\
move /y toggle-group.tsx src\components\ui\
move /y tooltip.tsx src\components\ui\

:: Move routes (handle potential browser download duplicates)
if exist "index (1).tsx" (
    move /y "index (1).tsx" src\routes\index.tsx
) else (
    move /y index.tsx src\routes\
)

move /y __root.tsx src\routes\
move /y about.tsx src\routes\
move /y auth.tsx src\routes\
move /y contact.tsx src\routes\
move /y privacy.tsx src\routes\
move /y shop.tsx src\routes\
move /y watch.$id.tsx src\routes\

:: Move authenticated / admin routes
move /y route.tsx src\routes\_authenticated\
move /y admin.tsx src\routes\_authenticated\
move /y admin.index.tsx src\routes\_authenticated\
move /y admin.products.tsx src\routes\_authenticated\
move /y admin.inquiries.tsx src\routes\_authenticated\

:: Move assets (handle potential browser download duplicates)
if exist "editorial-watchmaker (1).jpg" (
    move /y "editorial-watchmaker (1).jpg" src\assets\editorial-watchmaker.jpg
) else (
    move /y editorial-watchmaker.jpg src\assets\
)

move /y hero-watch.png src\assets\
move /y watch-longines.jpg src\assets\
move /y watch-omega.jpg src\assets\
move /y watch-rolex.jpg src\assets\
move /y watch-seiko.jpg src\assets\

echo Organization complete!
