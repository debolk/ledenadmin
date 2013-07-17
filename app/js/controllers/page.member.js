// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.MemberPageController = (function(_super) {

    __extends(MemberPageController, _super);

    MemberPageController.CacheTime = 120;

    function MemberPageController(uid) {
      var controller,
        _this = this;
      this.uid = uid;
      MemberPageController.__super__.constructor.call(this, new Bolk.MemberPage('member-' + this.uid, this.uid));
      controller = this;
      this.view.el.submit(function() {
        var data;
        data = controller.view.el.serializeObject();
        controller.saveMember(data);
        return false;
      });
      locache.async.get('member-page-' + this.uid).finished(function(data) {
        if (!data) {
          return _this._fetchMember();
        } else {
          return _this._parseMember(data);
        }
      });
      $('input#search').attr('disabled', 'disabled');
    }

    MemberPageController.prototype._fetchMember = function(display) {
      var blip,
        _this = this;
      if (display == null) {
        display = true;
      }
      blip = new Bolk.BlipRequest("persons/" + this.uid);
      return blip.request.done(function(blipdata) {
        var operculum;
        if (typeof blipdata === String) {
          blipdata = JSON.parse(blipdata);
        }
        operculum = new Bolk.OperculumRequest("person/" + _this.uid);
        return operculum.request.always(function(operculumdata) {
          var data;
          if ((operculumdata.error != null) && (operculumdata.statusText != null) && operculumdata === "error") {
            operculumdata = {};
          }
          if (typeof operculumdata === String) {
            operculumdata = JSON.parse(operculumdata);
          }
          data = _.extend(operculumdata, blipdata, {
            complete: true
          });
          locache.async.set('member-page-' + _this.uid, data, MemberPageController.CacheTime);
          if (display) {
            return _this._parseMember(data);
          }
        });
      });
    };

    MemberPageController.prototype.saveMember = function(data) {
      var api, blip, blipdata, controller, oper, operdata;
      controller = this;
      api = "persons/" + this.uid;
      blipdata = JSON.stringify(data['input']['blip']);
      blip = new Bolk.BlipRequest(api, blipdata, 'PATCH');
      console.log(blipdata);
      blip.request.done(function(result) {
        console.log(result);
        return controller._fetchMember(false);
      });
      api = "person/" + this.uid;
      operdata = data['input']['operculum'];
      operdata['uid'] = this.uid;
      operdata['alive'] = operdata['alive'] === "true";
      console.log(operdata);
      operdata = JSON.stringify(operdata);
      oper = new Bolk.OperculumRequest(api, operdata, 'PUT');
      return oper.request.done(function(result) {
        console.log(result);
        return controller._fetchMember(false);
      });
    };

    MemberPageController.prototype._parseMember = function(data) {
      this.model = new Bolk.Person(data);
      return this.view.display(this.model);
    };

    MemberPageController.prototype._displayMember = function(model) {};

    return MemberPageController;

  })(Bolk.PageController);

}).call(this);
