/*
 * Convert用 Utility.
 * 
 * 利用要項
 *    jquery librayr, settings.jsの先読みが必須.
 */

$.utils.convert = new Object();

/**
 * 文字列を変換テーブル（２つの配列）に従い行う
 * 
 * @param {string} source 処理対象文字列
 * @param {array} arrFrom 変換元の文字配列
 * @param {array} arrTo 変換元の文字配列。arrFromとインデックスが対応した配列を指定。
 * 
 */
$.utils.convert.toBySetting = function(source, arrFrom, arrTo) {
  var chars = source.split('');
  $.each(chars, function(i, c) {
    var arrIndex = arrFrom.indexOf(c);
    if (arrIndex >= 0) {
      chars[i] = arrTo[arrIndex];
    }
  });
  return chars.join('');
}

/**
 * 全角変換に変換
 *    半角英数字　→　全角英数字
 *    半角カナ　　　→　全角カナ
 * 
 * @param {string} selectorStr JQuery Selectorの文字列
 * @param {array} arrFrom 変換元の文字配列（任意）
 * @param {array} arrTo 変換元の文字配列。arrFromとインデックスが対応した配列を指定。
 * 
 */
$.utils.convert.toZenkaku = function(selectorStr, arrFrom, arrTo) {
  $(selectorStr).change(function() {
    var value  = $(this).val();
    var converted = value.replace(/[A-Za-z0-9]/g, function(s){
      return String.fromCharCode(s.charCodeAt(0) + 0xFEE0)
    });
    if (arrFrom !== undefined) converted = $.utils.convert.toBySetting(converted, arrFrom, arrTo);
    $(this).val(converted);
  })
};

/**
 * 半角英数字に変換
 * 
 *    全角英数字　→　半角英数字
 * 
 * @param {string} selectorStr JQuery Selectorの文字列
 * 
 */
$.utils.convert.toHankaku = function(selectorStr) {
  $(selectorStr).change(function() {
    var value  = $(this).val();
    var converted = value.replace(/[Ａ-Ｚａ-ｚ０-９]/g, function(s){
      return String.fromCharCode(s.charCodeAt(0) - 0xFEE0)
    });
    $(this).val(converted);
  })
};