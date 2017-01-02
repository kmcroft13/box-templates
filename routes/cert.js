Router.map(function () {
  this.route('certEndpoint', {
    path: '/.well-known/acme-challenge/:certId',
    where: 'server', 
    action: function () {
        // "this" is the RouteController instance.
        // "this.response" is the Connect response object
        // "this.request" is the Connect request object
        certId = this.params.certId
        this.response.setHeader('Content-Type', 'text/html');
        this.response.end(certId + ".zllO-r-xGjmlbTlLmzqFxTduhfyhQ609j_3Y-dzyW9I");
    },

  });
});
