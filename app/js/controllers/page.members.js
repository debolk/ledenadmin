// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.MembersPageController = (function(_super) {

    __extends(MembersPageController, _super);

    MembersPageController.CacheTime = 120;

    function MembersPageController(filter) {
      var controller,
        _this = this;
      this.filter = filter;
      MembersPageController.__super__.constructor.call(this, new Bolk.MembersPage(this._titlefor(this.filter)));
      console.log(this.filter);
      locache.async.get('members-page').finished(function(data) {
        if (!data) {
          return _this._fetchMembers();
        } else {
          return _this._parseMembers(data);
        }
      });
      controller = this;
      this.search = $('input#search');
      this.search.keyup(function() {
        var person, _i, _len, _ref;
        controller.filter = controller.search.val().toLowerCase();
        if (controller.filter.length < 3) {
          console.log(controller.model);
          if (controller.view.collectionView.model !== controller.model) {
            controller.view.display(controller.model);
          }
          return;
        }
        controller.selection = new Bolk.Persons();
        console.log(controller.filter);
        _ref = controller.model.models;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          person = _ref[_i];
          console.debug(person.index.indexOf(controller.filter));
          if (person.index.indexOf(controller.filter) !== -1) {
            controller.selection.add(person);
          }
        }
        return controller.view.display(controller.selection);
      });
    }

    MembersPageController.prototype._fetchMembers = function() {
      var blip,
        _this = this;
      this.showLoader();
      blip = new Bolk.BlipRequest('persons');
      return blip.request.always(function(data) {
        _this.hideLoader();
        if (blip.result) {
          data = blip.result;
          if (typeof data === String) {
            data = JSON.parse(data);
          }
          locache.async.set('members-page', data, MembersPageController.CacheTime);
          return _this._parseMembers(data);
        }
      });
    };

    MembersPageController.prototype._parseMembers = function(data) {
      var person, _i, _len;
      this.model = new Bolk.Persons();
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        person = data[_i];
        this.model.add(new Bolk.Person(_.extend(person, {
          complete: true
        })));
      }
      return this.view.display(this.model);
    };

    MembersPageController.prototype._titlefor = function(filter) {
      switch (filter) {
        case 'kandidaat':
          return 'Kandidaatleden';
        case 'oud':
          return 'Oud-leden';
        case 'actief':
          return 'Ledenlijst';
        default:
          return 'Ledenlijst';
      }
    };

    return MembersPageController;

  })(Bolk.PageController);

}).call(this);
