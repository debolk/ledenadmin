ledenadmin
==========
Javascript SPA for members administration of De Bolk. Designed to be used with [blip](https://github.com/debolk/blip) and [operculum](https://github.com/debolk/operculum).
Requires debolk/[bolklogin](https://github.com/debolk/bolklogin).

## Installation

1. Clone this repository `git clone https://github.com/debolk/ledenadmin.git .`
2. Setup the application by

	1. Install **a** [coffeescript](http://coffeescript.org/#installation) compiler
	2. Copy `src/js/setup.coffee.example` to `src/js/setup.coffee`
	3. Edit the file according to **bloklogin** settings listed below
	4. Compile the file to `app/js/setup.js`
3. Make sure your application has access to [bolklogin](https://github.com/debolk/bolklogin)
4. Open index.html in your browser

Alternatively, you can circumvent the installation of a coffeescript compiler by

1. Copy `app/js/setup.js.example` to `app/js/setup.js`
2. Edit the file according to **bloklogin** settings listed below
	
## Setup.coffee/js settings
1. You need to register a new client on [bolklogin](https://github.com/debolk/bolklogin).
2. Enter the `clientId` and `clientSecret`. 
3. Enter the `baseUrl`. This is the path to your index.html. 
	- If its hosted, it's probably something like `localhost/.../`
	- If its not hosted, it's probably something like `file:///C:/Users/.../.../.../ledenadmin/index.html`
4. Make sure the `baseUrl` is the same url as entered when registering the app on [bolklogin](https://github.com/debolk/bolklogin).
5. `OAuthEndpoint` should be the url to the login page. Normally `login.i.bolkhuis.nl`.

## Dependencies
- The system either works hosted or unhosted
- You need an `intranet connection` to the `OAuthEndpoint`
- HTML5 browser. LocalStorage needs to be enabled!