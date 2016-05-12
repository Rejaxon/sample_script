// Depends on settings.js.
app.utils = {};
app.utils.ajax = {};

app.utils.ajax.basic = function (overrideSettings, callback, errorStatusSetting) {
  var defaultSettings = {
    dataType: "json",
    contentType : 'application/json; charset=utf-8',
    statusCode: errorStatusSetting,
    headers: {
      'Accept': 'application/vnd.bento.v2+json'
    }
    // beforeSend : function(jqXHR, xhrSettings) {
    // }
  };
  // 下記のheadersの個別_.extendは、lodash.js _.mergeならdeep mergeしてくれるから不要なコード
  overrideSettings.headers = _.extend(defaultSettings.headers, overrideSettings.headers);

  var settings = _.extend(defaultSettings, overrideSettings);
  settings = app.utils.ajax.set_csrf_token_header(settings);
  $.ajax(settings).done(function(json) {
    callback(json);
  }).fail(function(jqXHR, textStatus, errorThrown) {
    var status = jqXHR.status;
    if (app.env.isProd() && status < 400) return;
    console.log("HTTP Status: " + status + ', Message: ' + errorThrown);
    console.log(jqXHR);
  });
};

app.utils.ajax.set_csrf_token_header = function (settings) {
  if (settings.type === 'GET') return settings;
  if (location.hostname == 'localhost') {
    settings.headers['X-SKIP-AUTHENTICATION-TOKEN'] = 'true';
  } else {
    var cookie = $.cookie(app.config.csrf_token_key);
    settings.headers[app.config.csrf_token_header] =  cookie;
  }
  return settings;
};

app.utils.ajax.get = function(url, params, callback, errorStatusSetting) {
  var overrideSettings = {
    type: "GET",
    url: url,
    data: params,
    statusCode: errorStatusSetting
  };
  app.utils.ajax.basic(overrideSettings, callback, errorStatusSetting);
};

app.utils.ajax.post = function(url, params, callback, errorStatusSetting) {
  var overrideSettings = {
    type: "POST",
    url: url,
    data: params,
    statusCode: errorStatusSetting
  };
  app.utils.ajax.basic(overrideSettings, callback, errorStatusSetting);
};

app.utils.url = {};
app.utils.url.queryString = function() {
  var result = [], query;
  var querys = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
  for(var i = 0; i < querys.length; i++) {
      query = querys[i].split('=');
      result[query[0]] = query[1];
  }
  return result;
};
