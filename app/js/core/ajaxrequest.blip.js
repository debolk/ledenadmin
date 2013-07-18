// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  Bolk.BlipRequest = (function(_super) {

    __extends(BlipRequest, _super);

    BlipRequest.EndPoint = 'https://people.i.bolkhuis.nl/';

    function BlipRequest() {
      this.onSuccess = __bind(this.onSuccess, this);
      Object.defineProperty(this, 'endpoint', {
        get: function() {
          return BlipRequest.EndPoint;
        }
      });
      BlipRequest.__super__.constructor.apply(this, [true].concat(__slice.call(arguments)));
    }

    BlipRequest.prototype.onSuccess = function(data) {
      return this.result = data;
    };

    BlipRequest.photo = function(uid, width, height) {
      return new BlipRequest(BlipRequest.photo_api(uid, width, height));
    };

    BlipRequest.photo_src = function(uid, width, height) {
      return "" + Bolk.BlipRequest.EndPoint + (BlipRequest.photo_api(uid, width, height)) + "?access_token=" + document.router.session.token;
    };

    BlipRequest.photo_api = function(uid, width, height) {
      return "persons/" + uid + "/photo/" + width + "/" + height;
    };

    return BlipRequest;

  })(Bolk.AjaxRequest);

}).call(this);
