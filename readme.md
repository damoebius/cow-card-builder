http://www.makeplayingcards.com/design/custom-blank-card.html
Custom Game Cards (63 x 88mm)
Images accepted: JPG, BMP, PNG, GIF, TIFF and PDF
Image resolution: Minimum 300 dpi

744x1039px -> 816x1110


Bleeding: Please allow 1/8" (approx 36 pixels based on a 300dpi image) for bleeding and a further 1/8" for safe area margin inside each side

http://vps.tamina-online.com:4444/api/langs/1/cards/3
http://vps.tamina-online.com:4444/api/update



Error message:
Screenshot failed Error: Failed to launch chrome!
puppeteer/.local-chromium/linux-
/chrome-linux/chrome: error while loading shared libraries: libX11 : cannot open shared object file: No such file or directory

Solution:
To get Chromium screenshots working on Ubuntu 16.04 I had to install the missing libx11 package plus several others which I determined by trail and error. Ultimately installed all these:
(command line: sudo apt install <name>)

libx11-xcb1
libx11composite1
libx11cursor1
libx11damage1
libcups2
libxss1
libxrandr2
libpangocairo-1.0-0
libatk1.0-0
libatk-bridge2.0-0
libgtk-3-0