/*
  ブラウザ操作制御
 */

// Backボタン擬似抑止
window.onunload = function(){};
history.forward();


$(document).ready(function(){
  
  // inputタグのReturnによるSubmit抑止
  $("input[type!=submit]").keypress(function(event) {
    if ((event.which && event.which === 13) || (event.keyCode && event.keyCode === 13)) {
      return false;
    }
    return true;
  });
  
  
  
  /** 
   * 値変換
   * 
   * $.utils.formatの前に定義すること.
   */
  $.utils.convert.toHankaku('input.js-currency');
  $.utils.convert.toHankaku('input.js-numeric');
  $.utils.convert.toHankaku('input.js-alpha-numeric');
  $.utils.convert.toZenkaku('input.js-to-zenkaku', $.constant.convert.HankakuKana, $.constant.convert.ZenkakuKana);
  
  
  
  /**
   * フォーマット、入力チェック
   * 
   * 桁制限は、HTMLのmaxlengthに任せる. 
   */
  $.utils.format.numeric('input.js-currency', '￥', true,  0, function (value){
    // TODO: 標準アラートダイアログに. フロートで勝手に消えるタイプの方が良いかも
    alert(value + '：　通貨として入力できません。');
  });
  
  $.utils.format.numeric('input.js-numeric', '', true, 0, function (value){
    // TODO: 標準アラートダイアログに．フロートで勝手に消えるタイプの方が良いかも
    alert(value + '：　数値として入力できません。');
  });
  
  $.utils.format.string('input.js-alpha-numeric', '^[0-9a-zA-Z]*$', function (value){
    // TODO: 標準アラートダイアログに．フロートで勝手に消えるタイプの方が良いかも
    alert(value + '：　半角英数値で入力してください。');
  })
  
  /**
   * 値コピー。 
   * From/To間の値の自動コピーで利用。
   * 
   * js-copy-[任意]のclass名を指定したinputタグ値を、同一名のclassを持つinputタグにコピー
   */
  $(":input[class^=js-copy-]").change(function() {
    var value = $(this).val();
    var clzArray = $(this).attr("class").split(' ');
    $.each(clzArray, function(i, v){
      if (v.indexOf("js-copy-") == 0) {
        var clzSelector = 'input.' + v;
        $(clzSelector).filter(function () {
          return $(this).val() == '';
        }).val(value);
      }
    });
  });
  
});

