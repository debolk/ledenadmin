// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.SearchPage = (function(_super) {

    __extends(SearchPage, _super);

    function SearchPage(title, advanced) {
      if (title == null) {
        title = 'Search';
      }
      if (advanced == null) {
        advanced = false;
      }
      SearchPage.__super__.constructor.call(this, title);
    }

    return SearchPage;

  })(Bolk.Page);

}).call(this);
