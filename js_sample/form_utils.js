/*
 * input form用Utility.
 *
 */
app.utils.form = {};

app.utils.form.getFormData = function(formTag) {
  var fd = new FormData(),
  $inputs = $("input", formTag);

  // disabledを除去
  for (var i = 0, l = $inputs.length; i < l; i++) {
    var $input = $(inputs[i]),
      disabled_attr = $input.attr("disabled");

    if (disabled_attr === "undefined" || disabled_attr === false) {
      fd.append($input.attr("name"), $input.attr("value"));
    }
  }
  return fd;
};


// canvasResize.jsが必須
app.utils.form.storeImage2Form = function(formData, name, imgSrc, fileName) {
  if (imgSrc !== undefined) {
    var blob = dataURLtoBlob(imgSrc);
    formData.append(name, blob, fileName);
  }
};
