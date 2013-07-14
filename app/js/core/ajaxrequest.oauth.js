// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  Bolk.OAuthRequest = (function(_super) {
    __extends(OAuthRequest, _super);

    OAuthRequest.EndPoint = '//login.i.bolkhuis.nl/';

    function OAuthRequest() {
      Object.defineProperty(this, 'endpoint', {
        get: function() {
          return OAuthRequest.EndPoint;
        }
      });
      OAuthRequest.__super__.constructor.apply(this, [false].concat(__slice.call(arguments)));
    }

    OAuthRequest.getAccessToken = function(code) {
      var params;

      params = {
        grant_type: 'authorization_code',
        code: code
      };
      return new OAuthRequest('post', params);
    };

    return OAuthRequest;

  })(Bolk.AjaxRequest);

}).call(this);
