var app = {};
app.env = {};
app.env.isProd = function() {
  return document.domain === 'example.com';
};
app.env.name = app.env.isProd() ? 'prod' : 'staging';

app.config = {};
// 共通設定
app.config.default = {
  csrf_token_header: 'X-CSRF-Token',
  csrf_token_key: 'CSRF-Token'
};

app.config.local = {
  apiBaseUri: 'http://localhost:3000'
};

app.config.staging = {
  apiBaseUri: 'http://staging.example.com'
};

app.config.prod = {
  apiBaseUri: 'https://example.com'
};
app.config = _.extend(app.config.default, app.config[app.env.name]);
