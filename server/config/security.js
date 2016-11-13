BrowserPolicy.content.allowOriginForAll('*.googleapis.com');
BrowserPolicy.content.allowOriginForAll('*.gstatic.com');
BrowserPolicy.content.allowOriginForAll('*.bootstrapcdn.com');
BrowserPolicy.content.allowOriginForAll('*.box.com');
BrowserPolicy.content.allowOriginForAll('*.boxcdn.net');
BrowserPolicy.content.allowOriginForAll("www.google-analytics.com");

BrowserPolicy.content.allowFontDataUrl();

BrowserPolicy.framing.restrictToOrigin('*.box.com');

//Fix for Safari CSP being too strict
BrowserPolicy.content.allowConnectOrigin("ws://localhost:*");
BrowserPolicy.content.allowConnectOrigin("wss://cloudtemplates-stage.herokuapp.com:*");
BrowserPolicy.content.allowConnectOrigin("wss://cloudtemplates-prod.herokuapp.com:*");