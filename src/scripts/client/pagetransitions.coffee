PageTransitions = do ->

  $pages = $('.phase')
  cursor = 1
  pagesCount = $pages.length
  current = 0
  isAnimating = false
  endCurrPage = false
  endNextPage = false
  animEndEventName = 'webkitAnimationEnd'
  parentwindow = undefined

  init = (win) ->
    parentwindow = win

    $pages.each ->
      $page = $(this)
      $page.data 'originalClassList', $page.attr('class')

    $pages.eq(current).addClass 'current'

    $pages.on 'click', ->
      if isAnimating then return false
      if cursor > 3 then cursor = 1
      nextPage cursor
      ++cursor

  nextPage = (options) ->
    if isAnimating then return false
    if parentwindow then parentwindow.window.changeparentmethod()
    isAnimating = true
    $currPage = $pages.eq current
    if options.showPage
      if options.showPage < pagesCount - 1
        current = options.showPage
      else
        current = 0
    else
      if current < pagesCount - 1
        ++current
      else
        current = 0
    $nextPage = $pages.eq(current).addClass('current')
    outClass = 'moveToLeftEasing ontop'
    inClass = 'moveFromRight'

    $currPage.addClass(outClass).on animEndEventName, ->
      $currPage.off animEndEventName
      endCurrPage = true
      if endNextPage
        onEndAnimation $currPage, $nextPage

    $nextPage.addClass(inClass).on animEndEventName, ->
      $nextPage.off animEndEventName
      endNextPage = true
      if endCurrPage
        onEndAnimation $currPage, $nextPage

  onEndAnimation = ($outpage, $inpage) ->
    endCurrPage = false
    endNextPage = false
    resetPage $outpage, $inpage
    isAnimating = false

  resetPage = ($outpage, $inpage) ->
    $outpage.attr 'class', $outpage.data('originalClassList')
    $inpage.attr 'class', $inpage.data('originalClassList') + ' current'

  {
    init: init
    nextPage: nextPage
  }
