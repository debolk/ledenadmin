// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.AppRouter = (function(_super) {
    __extends(AppRouter, _super);

    function AppRouter() {
      _ref = AppRouter.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppRouter.prototype.routes = {
      '': 'members',
      'home': 'members',
      'members': 'members',
      'members/:filter': 'members',
      'member/:id': 'member',
      'search': 'search',
      'search/:action': 'search',
      'logout': 'logout',
      '?code=:code': 'login'
    };

    AppRouter.prototype.initialize = function() {
      this.controller = null;
      this.session = new Bolk.Session();
      Backbone.history.start();
      return console.debug('Finished initializing router');
    };

    AppRouter.prototype.members = function(filter) {
      var _ref1;

      if (filter == null) {
        filter = 'actief';
      }
      console.debug('Routing members - ' + filter);
      if ((_ref1 = this.controller) != null) {
        _ref1.kill();
      }
      return this.controller = new Bolk.MembersPageController(filter);
    };

    AppRouter.prototype.member = function(id) {
      var _ref1;

      console.debug('Routing member:' + id);
      if ((_ref1 = this.controller) != null) {
        _ref1.kill();
      }
      return this.controller = new Bolk.MemberPageController(id);
    };

    AppRouter.prototype.search = function(action) {
      var _ref1;

      if (action == null) {
        action = null;
      }
      console.debug("Routing search: " + (action === 'filter' ? 'advanced' : 'normal'));
      if ((_ref1 = this.controller) != null) {
        _ref1.kill();
      }
      return this.controller = new Bolk.SearchPageController(action === 'filter');
    };

    AppRouter.prototype.login = function(code) {
      return this.session.login(code, this.session.token);
    };

    AppRouter.prototype.logout = function() {
      this.session.kill();
      return this.navigate('/home', {
        trigger: true,
        replace: true
      });
    };

    return AppRouter;

  })(Backbone.Router);

}).call(this);
