// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.MemberPage = (function(_super) {
    __extends(MemberPage, _super);

    function MemberPage(title, edit) {
      if (title == null) {
        title = 'Member';
      }
      if (edit == null) {
        edit = false;
      }
      MemberPage.__super__.constructor.call(this, title);
      this.content.append((this.el = $('<form class="form-horizontal"></form>')));
    }

    MemberPage.prototype.display = function(person) {
      var _ref;

      if ((_ref = this.personView) != null) {
        _ref.remove();
      }
      return this.personView = new Bolk.PersonView({
        el: this.el,
        model: person
      });
    };

    return MemberPage;

  })(Bolk.Page);

}).call(this);
