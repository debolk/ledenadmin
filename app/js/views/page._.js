// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.Page = (function(_super) {

    __extends(Page, _super);

    function Page(title) {
      Page.__super__.constructor.call(this, 'body');
      this.header = this.container.find('#masthead');
      this.contents = this.container.find('#content');
      this.footer = this.container.find('#mastfoot');
      this._fillHeader(title);
    }

    Page.prototype._getHeaderTemplate = function() {
      return '<div id="branding">\
			<a name="home" data-route="<%= route_home %>">\
				<img src="http://placehold.it/100x100.png">\
			</a>\
			<h1>Whiting</h1>\
		</div>\
		<form class="form-inline" id="search">\
			<div class="controls">\
				<input id="search" type="text" class="input-big" placeholder="Search...">\
			</div>\
			<div class="actions">\
				<a data-route="/search/filter">Advanced filter</a> |\
				<a data-route="/members/new">Add member</a>\
			</div>\
		</form>\
		<div id="logout">\
			<a data-route="/logout">\
				<img src="http://placehold.it/100x100.png&text=logout">\
			</a>\
		</div>';
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
      this.contents.empty();
      return this;
    };

    Page.prototype.showLoader = function() {};

    Page.prototype.hideLoader = function() {};

    return Page;

  })(Bolk.ViewCollection);

}).call(this);
