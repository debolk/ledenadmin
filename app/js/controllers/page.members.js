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
      if (window.search_query === void 0) {
        this.query = "membership:lid";
      } else {
        this.query = window.search_query;
      }
      locache.async.get('members-page').finished(function(data) {
        if (!data) {
          return _this._fetchMembers();
        } else {
          return _this._parseMembers(data);
        }
      });
      controller = this;
      this.search = $('input#search');
      this.search.val(this.query);
      this.search.keyup(function() {
        filter = controller.search.val().toLowerCase();
        window.search_query = filter;
        return controller._filter(filter);
      });
      this.search.keypress(function(event) {
        var model, uid;
        if (event.keyCode === 13) {
          event.preventDefault();
          model = controller.selection.models[0];
          uid = model.attributes.uid;
          return window.location.hash = "/member/" + uid;
        }
      });
      this["export"] = $('<a>export</a>');
      $('.actions').append(' | ');
      $('.actions').append(this["export"]);
      this["export"].click(function() {
        var model, _i, _len, _ref, _results;
        _ref = controller.selection.models;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          model = _ref[_i];
          _results.push(model.merge_operculum(function() {
            var data, first, header, key, person, result, value, _j, _k, _len1, _len2, _ref1, _ref2, _ref3;
            _ref1 = controller.selection.models;
            for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
              model = _ref1[_j];
              if (!model.complete) {
                return;
              }
            }
            header = "";
            first = true;
            _ref2 = controller.model.models[0].attributes;
            for (key in _ref2) {
              value = _ref2[key];
              if (!first) {
                header += ",";
              }
              first = false;
              header += key;
            }
            result = header + "\n";
            _ref3 = controller.selection.models;
            for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
              person = _ref3[_k];
              result += person.to_csv() + "\n";
            }
            data = 'data:text/csv,' + encodeURIComponent(result);
            return window.location = data;
          }));
        }
        return _results;
      });
    }

    MembersPageController.prototype._filter = function(query) {
      var person, _i, _len, _ref;
      this.query = query;
      if (this.query.length < 3) {
        this.query = "";
        this.selection = this.model;
        this.view.display(this.model);
        return;
      }
      this.selection = new Bolk.Persons;
      console.log(this.query);
      _ref = this.model.models;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        person = _ref[_i];
        if (person.matches(this.query)) {
          this.selection.add(person);
        }
      }
      return this.view.display(this.selection);
    };

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
        person = new Bolk.Person(_.extend(person, {
          complete: false
        }));
        this.model.add(person);
      }
      return this._filter(this.query);
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
