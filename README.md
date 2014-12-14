ledenadmin
==========
Javascript SPA for members administration of De Bolk. Designed to be used with [blip](https://github.com/debolk/blip) and [operculum](https://github.com/debolk/operculum).
Requires debolk/[bolklogin](https://github.com/debolk/bolklogin).

## Installation

1. Clone this repository `git clone https://github.com/debolk/ledenadmin.git .`
2. Setup the application by

	1. Install **a** [coffeescript](http://coffeescript.org/#installation) compiler
	2. Copy `src/app/js/setup.coffee.example` to `src/app/js/setup.coffee`
	3. Edit the file with the correct settings
	4. Run `./compile` to compile the application. Compile will keep watching your files for any changes and directly compiling them. 
3. Open index.html in your browser

## Requirements
- The system either works hosted or unhosted
- HTML5 browser. LocalStorage needs to be enabled!
