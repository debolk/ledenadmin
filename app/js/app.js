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
      '?code=:code&state=:state': 'getToken',
      'login': 'oauth'
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
      if (!this.ensureSession()) {
        return;
      }
      return this.controller = new Bolk.MembersPageController(filter);
    };

    AppRouter.prototype.member = function(id) {
      var _ref1;

      console.debug('Routing member:' + id);
      if ((_ref1 = this.controller) != null) {
        _ref1.kill();
      }
      if (!this.ensureSession()) {
        return;
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
      if (!this.ensureSession()) {
        return;
      }
      return this.controller = new Bolk.SearchPageController(action === 'filter');
    };

    AppRouter.prototype.oauth = function() {
      return this.session.oauth();
    };

    AppRouter.prototype.getToken = function(code, state) {
      var _this = this;

      console.debug("Logging in " + state + " vs " + locache.get('session_token_state'));
      return this.session.login(code, state).done(function() {
        return _this.navigate('//home', {
          trigger: true,
          replace: true
        });
      });
    };

    AppRouter.prototype.logout = function() {
      console.debug("Logging out");
      this.session.kill();
      return this.navigate('//home', {
        trigger: true,
        replace: true
      });
    };

    AppRouter.prototype.ensureSession = function() {
      var code, state;

      if (code = this.get('code') && (state = this.get('state'))) {
        this.getToken(code, state);
        return false;
      }
      if (!this.session.isLoggedIn) {
        this.session.oauth();
        return false;
      }
      return true;
    };

    AppRouter.prototype.get = function(name) {
      var expression, results;

      name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
      console.log(name);
      expression = new RegExp("[\\?&]" + name + "=([^&#]*)");
      if (results = expression.exec(location.search)) {
        if (results[1] != null) {
          return decodeURIComponent(results[1].replace(/\+/g, " "));
        }
      }
      return void 0;
    };

    return AppRouter;

  })(Backbone.Router);

}).call(this);
