/*
	定数定義
 */ 
$.utils = new Object();
$.constant = new Object();

$.constant.currency = new Object();
$.constant.currency.prefix = '￥'

$.constant.ajax = new Object();
$.constant.ajax.status = new Object();
$.constant.ajax.status.key = 'errorStatus';
$.constant.ajax.status.success = 'SUCCESS';
$.constant.ajax.status.error = 'ERROR';

$.constant.ui = new Object();
$.constant.ui.form = new Object();
$.constant.ui.form.invalid = 'has_error';

$.constant.convert = new Object();
$.constant.convert.HankakuKana = new Array(
  // Byte上、２文字構成の半角カナ
  "ｶﾞ", "ｷﾞ", "ｸﾞ", "ｹﾞ", "ｺﾞ", 
  "ｻﾞ", "ｼﾞ", "ｽﾞ", "ｾﾞ", "ｿﾞ", 
  "ﾀﾞ", "ﾁﾞ", "ﾂﾞ", "ﾃﾞ", "ﾄﾞ",
  "ﾊﾞ", "ﾋﾞ", "ﾌﾞ", "ﾍﾞ", "ﾎﾞ", 
  "ﾊﾟ", "ﾋﾟ", "ﾌﾟ", "ﾍﾟ", "ﾎﾟ", 
  "ｳﾞ",
  // Byte上、1文字構成の半角カナ
  "ｱ", "ｲ", "ｳ", "ｴ", "ｵ",
  "ｶ", "ｷ", "ｸ", "ｹ", "ｺ", 
  "ｻ", "ｼ", "ｽ", "ｾ", "ｿ",
  "ﾀ", "ﾁ", "ﾂ", "ﾃ", "ﾄ", 
  "ﾅ", "ﾆ", "ﾇ", "ﾈ", "ﾉ", 
  "ﾊ", "ﾋ", "ﾌ", "ﾍ", "ﾎ", 
  "ﾏ", "ﾐ", "ﾑ", "ﾒ", "ﾓ", 
  "ﾔ", "ﾕ", "ﾖ", 
  "ﾗ", "ﾘ", "ﾙ", "ﾚ", "ﾛ",
  "ﾜ", "ｦ", "ﾝ",
  "ｧ", "ｨ", "ｩ", "ｪ", "ｫ",
  "ｬ", "ｭ", "ｮ", "ｯ",
  ".", ",", "-", "@", "{", "}", "(", ")", "#", "!", "$", "%", "&", "=", "*", "+", "?", "/");
  
$.constant.convert.ZenkakuKana = new Array(
  // Byte上、２文字構成の半角カナ
  "ガ", "ギ",  "グ", "ゲ", "ゴ", 
  "ザ", "ジ",  "ズ", "ゼ", "ゾ",
  "ダ", "ヂ",  "ヅ", "デ", "ド",
  "バ", "ビ",  "ブ", "ベ", "ボ", 
  "パ", "ピ",  "プ", "ペ", "ポ", 
  "ヴ",
  // Byte上、1文字構成の半角カナ
  "ア", "イ",  "ウ", "エ", "オ", 
  "カ", "キ",  "ク", "ケ", "コ", 
  "サ", "シ",  "ス", "セ", "ソ", 
  "タ", "チ",  "ツ", "テ", "ト", 
  "ナ", "ニ",  "ヌ", "ネ", "ノ", 
  "ハ", "ヒ",  "フ", "ヘ", "ホ", 
  "マ", "ミ",  "ム", "メ", "モ", 
  "ヤ", "ユ",  "ヨ", 
  "ラ", "リ",  "ル", "レ", "ロ", 
  "ワ", "ヲ",  "ン", 
  "ァ", "ィ",  "ゥ", "ェ", "ォ", 
  "ャ", "ュ",  "ョ", "ッ", 
  "。",  "、", "－", "＠", "｛", "｝", "（", "）", "＃", "！", "＄", "％", "＆", "＝", "＊", "＋", "？", "／");
  




