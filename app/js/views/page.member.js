// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.MemberPage = (function(_super) {
    __extends(MemberPage, _super);

    function MemberPage(title, edit) {
      if (title == null) {
        title = 'Members';
      }
      if (edit == null) {
        edit = false;
      }
      MemberPage.__super__.constructor.call(this, title);
    }

    return MemberPage;

  })(Bolk.Page);

}).call(this);
