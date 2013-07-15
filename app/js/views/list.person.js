// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.PersonListView = (function(_super) {
    __extends(PersonListView, _super);

    function PersonListView() {
      _ref = PersonListView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PersonListView.prototype.initialize = function() {
      var _this = this;

      _.bindAll(this);
      this.render();
      this.items = {};
      return this.model.forEach(function(person) {
        var _ref1, _ref2;

        _this.items[(_ref1 = person.get('uid')) != null ? _ref1 : person.cid] = new Bolk.PersonItemView({
          el: _this.model.el,
          model: person
        });
        return _this.$el.append(_this.items[(_ref2 = person.get('uid')) != null ? _ref2 : person.cid].$el);
      });
    };

    PersonListView.prototype.render = function() {
      $(this.el).append('<ul class="members"></ul>');
      return this;
    };

    return PersonListView;

  })(Backbone.View);

}).call(this);
