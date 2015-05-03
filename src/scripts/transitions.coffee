
PageTransitions = do ->

  $phases = $('.phase')
  phaseCount = $phases.length
  current = 0
  isAnimating = no
  endCurrPage = false
  endNextPage = false
  animEndEventName = 'webkitAnimationEnd'
  parentwindow = undefined
  outClass = 'moveToLeftEasing ontop'
  inClass = 'moveFromRight'

  init = (win) ->
    parentwindow = win

    $phases.each ->
      $page = $(this)
      $page.data 'originalClassList', $page.attr('class')

    $phases.on 'click', ->
      if isAnimating then return false
      nextPage()

  nextPage = (options) ->
    if isAnimating then return false
    isAnimating = yes
    $currPage = $phases.eq current
    if options?
      current = options
    else
      if current < phaseCount - 1 then ++current
      else current = 0
    if parentwindow then parentwindow.window.changeTrayIcon(current)
    $nextPage = $phases.eq(current).addClass('current')

    $currPage.addClass(outClass).on animEndEventName, ->
      $currPage.off animEndEventName
      endCurrPage = true
      if endNextPage then onEndAnimation $currPage, $nextPage

    $nextPage.addClass(inClass).on animEndEventName, ->
      $nextPage.off animEndEventName
      endNextPage = true
      if endCurrPage then onEndAnimation $currPage, $nextPage

  onEndAnimation = ($outpage, $inpage) ->
    endCurrPage = false
    endNextPage = false
    resetPage $outpage, $inpage
    isAnimating = no

  resetPage = ($outpage, $inpage) ->
    $outpage.attr 'class', $outpage.data('originalClassList')
    $inpage.attr 'class', "#{$inpage.data('originalClassList')} current"

  {
    init: init
    nextPage: nextPage
  }
