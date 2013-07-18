// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.AppRouter = (function(_super) {

    __extends(AppRouter, _super);

    function AppRouter() {
      return AppRouter.__super__.constructor.apply(this, arguments);
    }

    AppRouter.prototype.routes = {
      '': 'members',
      'home': 'members',
      'members': 'members',
      'new': 'newmember',
      'members/:filter': 'members',
      'member/:id': 'member',
      'member/:id/:succes': 'member',
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
      var _ref;
      if (filter == null) {
        filter = 'actief';
      }
      console.debug('Routing members - ' + filter);
      if ((_ref = this.controller) != null) {
        _ref.kill();
      }
      if (!this.ensureSession()) {
        return;
      }
      return this.controller = new Bolk.MembersPageController(filter);
    };

    AppRouter.prototype.newmember = function() {
      var _ref;
      console.debug('New member');
      if ((_ref = this.controller) != null) {
        _ref.kill();
      }
      if (!this.ensureSession()) {
        return;
      }
      return this.controller = new Bolk.NewPageController;
    };

    AppRouter.prototype.member = function(id, succes) {
      var _ref;
      if (succes == null) {
        succes = false;
      }
      console.debug('Routing member:' + id);
      if ((_ref = this.controller) != null) {
        _ref.kill();
      }
      if (!this.ensureSession()) {
        return;
      }
      return this.controller = new Bolk.MemberPageController(id, succes);
    };

    AppRouter.prototype.search = function(action) {
      var _ref;
      if (action == null) {
        action = null;
      }
      console.debug("Routing search: " + (action === 'filter' ? 'advanced' : 'normal'));
      if ((_ref = this.controller) != null) {
        _ref.kill();
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
      return this.session.login(code, state).always(function() {
        return _this.redirectWithoutSearch();
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

    AppRouter.prototype.onUnload = function() {
      return this.session.unload();
    };

    AppRouter.prototype.ensureSession = function() {
      var code, state;
      if (this.session.isLoggedIn) {
        if ((code = this.get('code') && (state = this.get('state')))) {
          this.redirectWithoutSearch();
          return false;
        }
        return true;
      }
      if ((code = this.get('code')) && (state = this.get('state'))) {
        this.getToken(code, state);
        return false;
      }
      this.session.oauth();
      return false;
    };

    AppRouter.prototype.redirectWithoutSearch = function() {
      return window.location = window.location.protocol + "//" + window.location.host + window.location.pathname + window.location.hash;
    };

    AppRouter.prototype.get = function(name) {
      var expression, results;
      name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
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
