// Generated by CoffeeScript 1.6.2
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.PersonView = (function(_super) {
    __extends(PersonView, _super);

    function PersonView() {
      _ref = PersonView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PersonView.prototype.initialize = function() {
      _.bindAll(this);
      return this.render();
    };

    PersonView.prototype.getTemplate = function() {
      return '<header>\
			<div class="control-group">\
				<div class="controls">\
					<input class="input-big" id="name_first" name="input[blip][firstname]" placeholder="First name" maxlength="100" value="<%= firstname %>" required type="text">\
					<input class="input-big" id="name_last" name="input[blip][lastname]" placeholder="Last name" maxlength="100" value="<%= lastname %>" required type="text">\
					<button data-action="toggleEdit"><i class="icon-pencil"></i></button>\
				</div>\
			</div>\
			\
			<div class="contact">\
				<img src="http://placehold.it/32x32.png&text=P"/> <input class="" id="contact_phone" name="input[blip][phone]" placeholder="" maxlength="20" value="<%= phone %>" type="tel">\
				<img src="http://placehold.it/32x32.png&text=H"/> <input class="" id="contact_phone_home" name="input[blip][phone_parents]" placeholder="" maxlength="20" value="<%= phone_parents %>" type="tel">\
				<img src="http://placehold.it/32x32.png&text=E"/> <input class="" id="contact_email" name="input[blip][email]" placeholder="" maxlength="20" value="<%= email %>" type="tel">\
			</div>\
		</header>\
		\
		<img src="<%= img %>"/>\
		\
		<div class="control-group">\
			<label class="control-label" for="lidmaatschap">\
				Lidmaatschap\
			</label>\
			<div class="controls">\
				<select id="lidmaatschap">\
					\
				</select>\
			</div>\
		</div>\
		<!-- etc -->';
    };

    PersonView.prototype.render = function() {
      var data;

      data = {
        firstname: this.model.get('firstname'),
        lastname: this.model.get('lastname'),
        phone: this.model.get('phone'),
        phone_parents: this.model.get('phone_parents'),
        email: this.model.get('email'),
        img: Bolk.BlipRequest.photo_src(this.model.get('uid'), 200, 200)
      };
      return $(this.el).html(_.template(this.getTemplate(), data));
    };

    return PersonView;

  })(Backbone.View);

}).call(this);
