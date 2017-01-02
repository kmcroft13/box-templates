Router.map(function () {
  this.route('certEndpoint', {
    path: '/.well-known/acme-challenge/UEuc55cXcy1S6DGwyqT1CmdRXwoFpz9EtLfk_B5e8-s',
    where: 'server', 
    action: function () {
        // "this" is the RouteController instance.
        // "this.response" is the Connect response object
        // "this.request" is the Connect request object

        this.response.setHeader('Content-Type', 'text/html');
        this.response.end("UEuc55cXcy1S6DGwyqT1CmdRXwoFpz9EtLfk_B5e8-s.zllO-r-xGjmlbTlLmzqFxTduhfyhQ609j_3Y-dzyW9I");
    },

  });
});
