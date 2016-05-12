/*
 * UI制御用 Utility.
 * デザイン依存する汎用性の低い関数も含まれる。
 *
 * 利用要項
 *    jquery librayr, settings.jsの先読みが必須.
 */

app.utils.ui = {};
app.utils.ui.modal = {};
app.utils.ui.form = {};


/**
 * アラートモーダル呼出の共通関数
 *
 * @type {string} message アラートメッセージ
 */
app.utils.ui.modal.alert = function(message) {
  $("#js-alert-modal-message").html(message);
  $("#js-alert-modal").modal();
};


/**
 *
 *
 * @param  {string} selector
 * @param  {string} clz 設定値以外のstyleのclassを適用したい場合に指定（任意）
 */
app.utils.ui.form.invalid = function(selector, clz) {
  if (clz === undefined) clz = app.constant.ui.form.invalid;
  $(selector).addClass(clz)
    .focus(function() {
      $(this).removeClass(clz);
    });
};
