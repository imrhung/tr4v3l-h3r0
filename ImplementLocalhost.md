If you use local host to run this project, here are some note.

If web not run, please take a look at:
application/config/config.php
Take a look at line 17:
$config['base\_url']	= 'http://travel.hero/';
Make sure the url map with your localhost.

If you base url something like: http://localhost/travel_hero. And you meet the error cannot access any controller, take a look at file .htaccess in base folder.
In line 3: RewriteRule ^(.**)$ /index.php/$1 [L](L.md) .
You need to change it to: RewriteRule ^(.**)$ /travel\_hero/index.php/$1 [L](L.md).
This may work :D