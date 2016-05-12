// Depends on utils.js.

// API I/F
app.api = {};

app.api.addLineFriend = function(callback, overrideErrorSetting) {
  var url = app.config.apiBaseUri + '/user/line_friend';
  var errorSetting = _.extend({
    403: function() {
      alert( "ダミー. 画面用jsの方の処理で上書きされるので表示されない" );
    }
  }, overrideErrorSetting);
  app.utils.ajax.post(url, null, callback, errorSetting)
};

// app.api.getUserInfo(function(json){ console.log(json) })
app.api.getUserInfo = function(callback, overrideErrorSetting) {
  var url = app.config.apiBaseUri + '/user';
  var errorSetting = _.extend({
    401: function() {
      alert( "ログインが必要です。" );
    }
  }, overrideErrorSetting);
  app.utils.ajax.get(url, null, callback, errorSetting)
};
