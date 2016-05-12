
$.utils.pager = (info) ->
  unless info.path? && info.currentPage? && info.lastPage?
    throw "Parameters is not enough."
  currentPage = parseInt(info.currentPage)
  lastPage = parseInt(info.lastPage)
  totalCount = parseInt(info.totalCount)
  pre_count = if info.pre_count? then parseInt(info.pre_count) else 2
  suf_count = if info.suf_count? then parseInt(info.suf_count) else 2
  per = parseInt(info.per)
  {
    path: info.path
    currentPage: currentPage
    totalCount: totalCount
    per: per
    lastPage: lastPage
    pageIndice: ->
      result = []
      for num in [currentPage - pre_count..currentPage + suf_count]
        if num > 0 && num <= lastPage
          result.push({ number: num, isCurrent: currentPage is num})
      return result
    prevPage: ->
      currentPage - 1
    nextPage: ->
      currentPage + 1
    isFirstPage: ->
      currentPage == 1
    isLastPage: ->
      lastPage == currentPage
    firstNumber: ->
      per * (currentPage - 1) + 1
    lastNumber: ->
      num = per * currentPage
      `(totalCount < num) ? totalCount : num`
    hasNumberInfo: ->
      info.totalCount? && info.per?
  }
