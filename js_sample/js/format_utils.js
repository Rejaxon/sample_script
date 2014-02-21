/*
 * Format用 Utility.
 * 
 * 利用要項
 *    jquery librayr, settings.jsの先読みが必須.
 */
$.utils.format = new Object();


/**
 * 数値系の表示フォーマット　＆　入力制限・チェック
 * Submit時は数値のみがSubmitされる。 
 * 
 * @param {string} selectorStr JQuery Selectorの文字列
 * @param {string} symbol 通貨マーク
 * @param {boolean} thousandSep 千単位のカンマセパレーターの有無
 * @param {string} fraction 小数点桁数
 * @param {string} invalidFunc フォーマットエラー時のダイアログ呼出用コールバック関数
 * 
 */
$.utils.format.numeric = function(selectorStr, symbol, thousandSep, fraction, invalidFunc) {
  $(selectorStr).after(function() {
    var nameAttr = $(this).attr("name");
    if (nameAttr === undefined) alert("Bug: No exist name attribute.");
    $(this).removeAttr("name");
    return '<input type="hidden" name="' + nameAttr + '" />';
    
  }).blur(function() {
    var value = $(this).val();
    if (value.match(/[^0-9]/)) { // 入力値チェック
      if (invalidFunc !== undefined)  invalidFunc($(this));
      return false;
    } 
    $(this).next().val(value);
    $(this).formatCurrency({symbol: symbol, groupDigits: thousandSep, roundToDecimalPlace: fraction});
    
  }).click(function() {// 入力時に数値変換
    $(this).toNumber();
    
  }).keypress(function(event) {// 入力制限
    str = String.fromCharCode(event.which);
    if ("0123456789".indexOf(str, 0) < 0) return false;
    return true;
    
  })
};

/**
 * 入力チェック
 * 
 * @param {string} selectorStr JQuery Selectorの文字列
 * @param {string} regexp 正規表現文字列
 * @param {string} invalidFunc フォーマットエラー時のダイアログ呼出用コールバック関数
 * 
 */
$.utils.format.string = function(selectorStr, regexp, invalidFunc) {
  $(selectorStr).blur(function() {
    var value = $(this).val();
    var regexpObj = new RegExp(regexp);
    if (! value.match(regexpObj)) { // 入力値チェック
      if (invalidFunc !== undefined)  invalidFunc($(this));
      return false;
    }
  })
};


