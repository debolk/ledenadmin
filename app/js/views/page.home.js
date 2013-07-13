// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.HomePage = (function(_super) {
    __extends(HomePage, _super);

    function HomePage() {
      var actions;

      HomePage.__super__.constructor.call(this, 'Home');
      actions = [];
      actions.push({
        link: '/leden',
        text: 'Ledenlijst'
      });
      actions.push({
        link: '/leden/oud',
        text: 'Oud-leden'
      });
      actions.push({
        link: '/leden/kandidaat',
        text: 'Kandidaatleden'
      });
      this.contents.append(this._createActions(actions));
    }

    return HomePage;

  })(Bolk.Page);

}).call(this);
