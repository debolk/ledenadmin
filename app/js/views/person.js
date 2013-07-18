// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Bolk.PersonView = (function(_super) {

    __extends(PersonView, _super);

    function PersonView() {
      return PersonView.__super__.constructor.apply(this, arguments);
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
				<img src="http://placehold.it/32x32.png&text=M"/> <input class="" id="contact_mobile" name="input[blip][mobile]" placeholder="" maxlength="20" value="<%= mobile %>" type="tel">\
				<img src="http://placehold.it/32x32.png&text=P"/> <input class="" id="contact_phone" name="input[blip][phone]" placeholder="" maxlength="20" value="<%= phone %>" type="tel">\
				<img src="http://placehold.it/32x32.png&text=E"/> <input class="" id="contact_email" name="input[blip][email]" placeholder="" maxlength="20" value="<%= email %>" type="email" required>\
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
				<select id="lidmaatschap" name="input[blip][membership]">\
					<option <%= membership == "geen lid"?"selected ":"" %>value="geen lid">Geen lid</option>\
					<option <%= membership == "kandidaatlid"?"selected ":"" %>value="kandidaatlid">Kandidaatlid</option>\
					<option <%= membership == "lid"?"selected ":"" %>value="lid">Lid</option>\
					<option <%= membership == "oudlid"?"selected ":"" %>value="oudlid">Oud-lid</option>\
					<option <%= membership == "lidvanverdienste"?"selected ":"" %>value="lidvanverdienste">Lid van verdienste</option>\
				</select>\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="initials">\
				Initialen\
			</label>\
			<div class="controls">\
				<input id="initials" name="input[blip][initials]" maxlength="20" value="<%= initials %>" type="text" pattern="[a-zA-Z]*" title="Alleen letters">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="gender">\
				Geslacht\
			</label>\
			<div class="controls">\
				<select id="gender" name="input[blip][gender]">\
					<option <%= gender == "M"?"selected ":"" %> value="M">Man</option>\
					<option <%= gender == "F"?"selected ":"" %> value="F">Vrouw</option>\
				</select>\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="phone_parents">\
				Telefoon ouders\
			</label>\
			<div class="controls">\
				<input id="phone_parents" name="input[blip][phone_parents]" maxlength="20" value="<%= phone_parents %>" type="tel">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="address">\
				Adres\
			</label>\
			<div class="controls">\
				<textarea id="address" name="input[blip][address]" maxlength="2000" type="text"><%= address %></textarea>\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="dateofbirth">\
				Geboortedatum\
			</label>\
			<div class="controls">\
				<input id="dateofbirth" name="input[blip][dateofbirth]" maxlength="20" value="<%= dateofbirth %>" type="date">\
			</div>\
		</div>\
		\
		<div class="control-group">\
			<label class="control-label" for="nickname">\
				Bijnaam\
			</label>\
			<div class="controls">\
				<input id="nickname" name="input[operculum][nickname]" maxlength="50" value="<%= nickname %>" type="text">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="study">\
				Studie / Werk\
			</label>\
			<div class="controls">\
				<input id="study" name="input[operculum][study]" maxlength="50" value="<%= study %>" type="text">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="alive">\
				Levend\
			</label>\
			<div class="controls">\
				<select id="alive" name="input[operculum][alive]">\
					<option value="true">Ja</option>\
					<option value="false">Nee</option>\
				</select>\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="inauguration">\
				Inauguratiedatum\
			</label>\
			<div class="controls">\
				<input id="inauguration" name="input[operculum][inauguration]" maxlength="20" value="<%= inauguration %>" type="date">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="resignation_letter">\
				Lid-afbrief datum\
			</label>\
			<div class="controls">\
				<input id="resignation_letter" name="input[operculum][resignation_letter]" maxlength="20" value="<%= resignation_letter %>" type="date">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="resignation">\
				Lid-af\
			</label>\
			<div class="controls">\
				<input id="resignation" name="input[operculum][resignation]" maxlength="20" value="<%= resignation %>" type="date">\
			</div>\
		</div>\
		<div class="control-group">\
			<label class="control-label" for="submit">\
				Opslaan\
			</label>\
			<div class="controls">\
				<input id="submit" name="input[submit]" value="Opslaan" type="submit">\
			</div>\
		</div>\
		<!-- etc -->';
    };

    PersonView.prototype.render = function() {
      var data;
      data = {
        firstname: this.model.get('firstname'),
        lastname: this.model.get('lastname'),
        mobile: this.model.get('mobile'),
        phone: this.model.get('phone'),
        phone_parents: this.model.get('phone_parents'),
        address: this.model.get('address'),
        dateofbirth: this.model.get('dateofbirth'),
        email: this.model.get('email'),
        initials: this.model.get('initials'),
        gender: this.model.get('gender'),
        img: Bolk.BlipRequest.photo_src(this.model.get('uid'), 200, 200),
        membership: this.model.get('membership'),
        nickname: this.model.get('nickname'),
        study: this.model.get('study'),
        alive: this.model.get('alive'),
        inauguration: this.model.get('inauguration'),
        resignation_letter: this.model.get('resignation_letter'),
        resignation: this.model.get('resignation')
      };
      return $(this.el).html(_.template(this.getTemplate(), data));
    };

    return PersonView;

  })(Backbone.View);

}).call(this);
