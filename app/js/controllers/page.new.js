// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.NewPageController = (function(_super) {
    __extends(NewPageController, _super);

    NewPageController.CacheTime = 120;

    function NewPageController(uid) {
      var controller;

      this.uid = uid;
      NewPageController.__super__.constructor.call(this, new Bolk.MemberPage('member-' + this.uid, this.uid));
      controller = this;
      this.view.el.submit(function() {
        var data;

        data = controller.view.el.serializeObject();
        controller.createMember(data);
        return false;
      });
      this._parseMember({});
      $('input#search').attr('disabled', 'disabled');
    }

    NewPageController.prototype.createMember = function(data) {
      var api, blip, blipdata, controller;

      controller = this;
      api = "persons";
      blipdata = JSON.stringify(data['input']['blip']);
      blip = new Bolk.BlipRequest(api, blipdata, 'POST');
      $('#errors').children().remove();
      blip.request.fail(function(error) {
        console.log(error);
        return $('#errors').append(controller.view.createError(error.responseText));
      });
      return blip.request.done(function(result) {
        var oper, operdata, uid;

        uid = result['uid'];
        api = "person/" + uid;
        operdata = data['input']['operculum'];
        operdata['uid'] = uid;
        operdata['alive'] = operdata['alive'] === "true";
        operdata = JSON.stringify(operdata);
        oper = new Bolk.OperculumRequest(api, operdata, 'PUT');
        oper.request.fail(function(error) {
          var errors, message, _i, _len, _results;

          errors = error.responseJSON.error_description;
          console.log(errors);
          _results = [];
          for (_i = 0, _len = errors.length; _i < _len; _i++) {
            message = errors[_i];
            _results.push($('#errors').append(controller.view.createError(message)));
          }
          return _results;
        });
        return oper.request.done(function(result) {
          $('#errors').append(controller.view.createSucces("Opslaan gelukt"));
          return window.location.hash = "/member/" + uid;
        });
      });
    };

    NewPageController.prototype._parseMember = function(data) {
      this.model = new Bolk.Person(data);
      return this.view.display(this.model);
    };

    NewPageController.prototype._displayMember = function(model) {};

    return NewPageController;

  })(Bolk.PageController);

}).call(this);