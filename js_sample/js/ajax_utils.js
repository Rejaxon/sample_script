/*
 * Ajax用Utility.
 * 
 * 利用要項
 *    ・jquery librayr, common.jsの先読みが必須.
 *    ・$.constant.ajaxの定数値をサーバーのJSON返却値に合わせて設定
 */
$.utils.ajax = new Object();

/**
 * Ajax 用 errorFuncのみ任意
 * 
 * @param {string} url 
 * @param {string} paramsFunc JSON型に整形されたRequest Param生成Function
 * @param {string} successFunc ajaxで受け取ったJSONデータを処理する関数
 * @param {string} errorFunc ajaxがError時に処理する関数
 */
$.utils.ajax.get = function(url, paramsFunc, successFunc, errorFunc) {
  $.ajax({
   type: "GET",
   url: url,
   data: paramsFunc(),
   dataType : "json",
   success: function(data){
     var ajaxStatus = data[$.constant.ajax.status.key];
     if (ajaxStatus == null) {//Success
       successFunc(data);
     } else if (errorFunc) {
       errorFunc(ajaxStatus);
     }
   }
  });
};

/** 
 * Ajax Post用 successFunc, errorFuncは任意. 
 * data返却あり時はsuccessFunc定義必須.
 * 
 * @param {string} url 
 * @param {string} paramsFunc JSON型に整形されたRequest Param生成Function
 * @param {string} successFunc ajaxで受け取ったJSONデータを処理する関数
 * @param {string} errorFunc ajaxがError時に処理する関数
 */
$.utils.ajax.post = function(url, paramsFunc, successFunc, errorFunc) {
  $.ajax({
   type: "POST",
   url: url,
   data: paramsFunc(),
   dataType : "json",
   success: function(data){
     var ajaxStatus = data[$.constant.ajax.status.key];
     if (ajaxStatus == null || ajaxStatus == $.constant.ajax.status.success) {//成功
       if (successFunc) successFunc();
     } else if (errorFunc){
       errorFunc(ajaxStatus);
     }
   }
  });
};