#
#  共通で行う操作制御
#

$ ->
  # inputタグのReturnによるSubmit抑止
  $('input[type!=submit]').keypress (e) ->
    if ((e.which && e.which == 13) || (e.keyCode && e.keyCode == 13))
      return false
    return true
  
  # ファイル選択ボタンのボタン化
  $('.js-fileupload').find('.btn').click ->
    $(this).closest('.js-fileupload').find('input[type=file]').click()
  
  # ファイルプレビュー
  $('.js-fileupload').find('input[type=file]').change ->
    fileTag = this
    if not fileTag.files.length
      return
    frs = []
    fileupload = $(fileTag).closest('.js-fileupload')
    preview_container = fileupload.find('.js-preview-container.hidden')
    if preview_container == undefined
      # プレビュー未利用と判定
      return
    # 処理中はファイル選択を抑止
    $(fileTag).attr("disabled", "disabled")
    
    # プレビュー中の画像を一旦削除
    fileupload.find('.js-preview-container').not('.hidden').remove()
    
    # ファイル数表示
    fileupload.find('.file-num').remove()
    displayFileNums =
      $('<span class="file-num" style="margin: 0px 10px;">' +
        fileTag.files.length + 'ファイルを選択中</span>')
    fileupload.find('.btn').after(displayFileNums)
    
    $.each( $(fileTag).prop('files'), (i) ->
      file = this
      canvasResize(file, {
        width: $.constant.image.maxSize,
        height: $.constant.image.maxSize,
        crop: false,
        quality: 90,
        callback: (dataSrc, width, height) ->
          # 非対応対策
          if dataSrc.length < 100
            return
          pvc = $(preview_container)
            .clone().removeClass('hidden')
          pvc.find('.js-preview')
            .attr('src', dataSrc)
            .attr('id', 'preview_image' + i)
          fileupload.append(pvc)
      })
    )
    $(fileTag).removeAttr("disabled")
  
  
        
