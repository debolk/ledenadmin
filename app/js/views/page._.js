// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.Page = (function(_super) {

    __extends(Page, _super);

    function Page(title) {
      Page.__super__.constructor.call(this, 'body');
      this.header = this.container.find('#masthead');
      this.container = this.container.find('#content');
      this.container.append((this.errors = $('<div id="errors"></div>')));
      this.container.append((this.loading = $('<div id="loader"></div>')));
      this.container.append((this.contents = $('<div id="contents"></div>')));
      this.footer = this.container.find('#mastfoot');
      this._fillHeader(title);
    }

    Page.prototype._getHeaderTemplate = function() {
      return '<div id="branding">\
			<a name="home" data-route="<%= route_home %>">\
				<img src="/app/img/logo.png">\
			<h1>Whiting</h1>\
			</a>\
		</div>\
		<form class="form-inline" id="search">\
			<div class="controls">\
				<input id="search-field" type="text" class="input-big" placeholder="Search...">\
			</div>\
			<div class="actions">\
				<a data-route="/new">Add member</a>\
			</div>\
		</form>\
		';
    };

    Page.prototype.showLoader = function() {
      this.loading.html($("<div>LOADINGGGG</div>"));
      return this;
    };

    Page.prototype.hideLoader = function() {
      return this.loading.empty();
    };

    Page.prototype.createAlert = function(description, title, style) {
      if (title == null) {
        title = "Warning!";
      }
      if (style == null) {
        style = "";
      }
      return $("<div class='alert " + style + "'>			<button type='button' class='close' data-dismiss='alert'>&times</button>			<strong>" + title + "</strong> " + description + "		</div>");
    };

    Page.prototype.createError = function(description) {
      return this.createAlert(description, "Error!", "alert-error");
    };

    Page.prototype.createSuccess = function(description) {
      return this.createAlert(description, "Succes!", "alert-success");
    };

    Page.prototype.clearErrors = function() {
      this.errors.empty();
      return this;
    };

    Page.prototype.showSuccess = function() {
      this.errors.append(this.createSuccess.apply(this, arguments));
      return this;
    };

    Page.prototype.showError = function() {
      return this.errors.append(this.createError.apply(this, arguments));
    };

    Page.prototype._fillHeader = function(title) {
      var key, template;
      key = "header-" + (title.toLowerCase());
      template = locache.get(key);
      this.header.hide();
      if (!template) {
        template = _.template(this._getHeaderTemplate(), {
          route_home: '/home',
          title: title
        });
        locache.async.set(key, template, 3600);
      }
      this.header.html(template);
      return this.header.fadeIn();
    };

    Page.prototype.clear = function() {
      this.header.empty();
      this.container.empty();
      return this;
    };

    return Page;

  })(Bolk.ViewCollection);

}).call(this);
