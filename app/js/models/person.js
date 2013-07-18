// Generated by CoffeeScript 1.6.2
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.Person = (function(_super) {
    __extends(Person, _super);

    function Person(data) {
      var regex;

      Person.__super__.constructor.call(this, data);
      regex = new RegExp('"', 'g');
      this.index = JSON.stringify(data);
      this.index = this.index.replace(regex, '');
      this.index = this.index.toLowerCase();
    }

    Person.prototype.matches = function(filter) {
      var andclause, orclause, satisfied, satisfies, _i, _j, _len, _len1;

      satisfies = function(heap, words) {
        var word, _i, _len;

        for (_i = 0, _len = words.length; _i < _len; _i++) {
          word = words[_i];
          if (heap.indexOf(word) === -1) {
            return false;
          }
        }
        return true;
      };
      for (_i = 0, _len = filter.length; _i < _len; _i++) {
        andclause = filter[_i];
        satisfied = false;
        for (_j = 0, _len1 = andclause.length; _j < _len1; _j++) {
          orclause = andclause[_j];
          if (satisfies(this.index, orclause)) {
            satisfied = true;
            break;
          }
        }
        if (!satisfied) {
          return false;
        }
      }
      return true;
    };

    Person.prototype.merge_operculum = function(finish) {
      var operculum, promise,
        _this = this;

      if (finish == null) {
        finish = function() {
          return {};
        };
      }
      promise = $.Deferred();
      if (this.complete) {
        finish();
        return promise.resolve(this).promise();
      }
      operculum = new Bolk.OperculumRequest("person/" + this.attributes.uid);
      operculum.request.done(function(data) {
        _this.set(data);
        return locache.async.set('member-page-' + _this.attributes.uid, _this.attributes);
      });
      operculum.request.always(function() {
        _this.complete = true;
        finish();
        return promise.resolve(_this);
      });
      return promise.promise();
    };

    Person.prototype.to_csv = function() {
      var escaped, first, key, line, r, value, _ref;

      line = "";
      first = true;
      r = new RegExp('"', 'g');
      _ref = this.attributes;
      for (key in _ref) {
        value = _ref[key];
        value = value != null ? value : "";
        escaped = value;
        if (typeof escaped === 'string') {
          escaped = escaped.replace(r, '""');
        }
        if (!first) {
          line += ',';
        }
        first = false;
        if (escaped) {
          line += '"' + escaped + '"';
        }
      }
      return line;
    };

    Person.prototype.defaults = {
      uid: '',
      nickname: '',
      study: '',
      alive: true,
      inauguration: null,
      resignation_letter: null,
      resignation: null,
      initials: '',
      firstname: '',
      lastname: '',
      email: '',
      gender: '',
      phone: '',
      mobile: '',
      phone_parents: '',
      address: '',
      dateofbirth: ''
    };

    return Person;

  })(Backbone.Model);

}).call(this);
