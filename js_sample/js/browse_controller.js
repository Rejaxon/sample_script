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
  $.utils.format.numeric('input.js-currency', '￥', true,  0, function (oldVal, input){
    // TODO: 下記３行も共通関数としてライブラリに。 CSSのデザインに合わせてからだが。
    $(input).closest(".form-group").addClass("has-error").change(function() {
      $(this).removeClass("has-error");
    });
    $("#js-alert-modal-message").html('通貨のフォーマット不正です。');
    $("#js-alert-modal").modal();
  });
  
  $.utils.format.numeric('input.js-numeric', '', true, 0, function (oldVal, input){
    $(input).closest(".form-group").addClass("has-error").change(function() {
      $(this).removeClass("has-error");
    });
    $("#js-alert-modal-message").html('数値で入力してください。');
    $("#js-alert-modal").modal();
  });
  
  $.utils.format.string('input.js-alpha-numeric', '^[0-9a-zA-Z]*$', function (oldVal, input){
    $(input).closest(".form-group").addClass("has-error").change(function() {
      $(this).removeClass("has-error");
    });
    $("#js-alert-modal-message").html('英数値で入力してください。');
    $("#js-alert-modal").modal();
  })
  
  /**
   * 値コピー。 
   * From/To間の値の自動コピーで利用。
   * 
   * js-copy-[任意]のclass名を指定したinputタグ値を、同一名のclassを持つinputタグにコピー
   */
  $(":input[class*=js-copy-]").change(function() {
    var value = $(this).val();
    var clzArray = $(this).attr("class").split(' ');
    console.log(clzArray)
    $.each(clzArray, function(i, v){
      console.log(v)
      if (v.indexOf("js-copy-") == 0) {
        var clzSelector = 'input.' + v;
        $(clzSelector).filter(function () {
          return $(this).val() == '';
        }).val(value);
      }
    });
  });
  
});

