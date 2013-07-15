// Generated by CoffeeScript 1.6.2
(function() {
  Bolk.AjaxRequest = (function() {
    function AjaxRequest(secure, api, params, method) {
      this.secure = secure != null ? secure : true;
      this.api = api;
      this.params = params != null ? params : {};
      this.method = method != null ? method : 'get';
      console.debug("" + this.method + " " + (this.url()));
      if (!this.params['access_token'] && this.secure) {
        this.params['access_token'] = document.router.session.token;
      }
      this.result = void 0;
      this.request = this.execute();
    }

    AjaxRequest.prototype.url = function() {
      return "" + this.endpoint + this.api;
    };

    AjaxRequest.prototype.options = function() {
      return {
        url: this.url(),
        type: this.method,
        data: this.params
      };
    };

    AjaxRequest.prototype.execute = function() {
      return jQuery.ajax(this.options()).done(this.onSuccess).fail(this.onFail).always(this.onDone);
    };

    AjaxRequest.prototype.onSuccess = function(data) {
      return console.log(data);
    };

    AjaxRequest.prototype.onFail = function(error) {
      return console.error(error.error());
    };

    AjaxRequest.prototype.onDone = function() {};

    AjaxRequest.prototype.statify = function() {
      return JSON.stringify({
        api: this.api,
        method: this.method,
        endpoint: this.endpoint,
        params: this.params
      });
    };

    AjaxRequest.generate = function(state) {
      var request;

      if (state instanceof String) {
        state = JSON.parse(state);
      }
      request = new AjaxRequest(state.api, state.method);
      Object.defineProperty(request, 'endpoint', {
        get: function() {
          return state.endpoint;
        }
      });
      return request;
    };

    return AjaxRequest;

  })();

}).call(this);
