BrowserPolicy.content.allowOriginForAll('*.googleapis.com');
BrowserPolicy.content.allowOriginForAll('*.gstatic.com');
BrowserPolicy.content.allowOriginForAll('*.bootstrapcdn.com');
BrowserPolicy.content.allowOriginForAll('*.box.com');
BrowserPolicy.content.allowOriginForAll('*.boxcdn.net');

BrowserPolicy.content.allowFontDataUrl();

BrowserPolicy.framing.restrictToOrigin('*.box.com');

BrowserPolicy.content.allowOriginForAll("www.google-analytics.com");
