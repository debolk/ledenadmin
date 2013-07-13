// Generated by CoffeeScript 1.6.2
(function() {
  jQuery(document).ready(function() {
    $(window).on('beforeunload', function() {
      var message;

      if ((document.router != null) && (document.router.controller != null) && (document.router.controller.beforeUnload != null)) {
        console.info('Just before unloading this window...');
        message = document.router.controller.beforeUnload();
        if (message != null) {
          return message;
        }
      }
      return void 0;
    }).on('unload', function() {
      if ((document.router != null) && (document.router.controller != null) && (document.router.controller.onUnload != null)) {
        console.info('...unloaded this window');
        return document.router.controller.onUnload();
      }
    });
    return document.router = new Bolk.AppRouter();
  });

}).call(this);
