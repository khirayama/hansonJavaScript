class MicroView
  constructor: ->
    @init()
    @setEventListeners()

  init: ->

  setEventListeners: ->

  # create methods
  @render: (viewClass, $el, args) ->
    args = args or []
    createClass = (_args) ->
      viewClass.apply(this, _args)
    createClass:: = viewClass::

    if @::_isDOMCollection($el)
      for _$el in $el
        args.push(_$el)
        new createClass(args)
    else if @::_isDOM($el)
      args.push($el)
      new createClass($args)
    else if @::_isSelector($el)
      _$el = @find($el)
      @render(viewClass, _$el, args)

  # events handle
  on: ($el, eventType, callback) ->
    if @_isDOMCollection($el)
      for _$el in $el
        _$el.addEventListener(eventType, callback)
    else if @_isDOM($el)
      $el.addEventListener(eventType, callback)
    else if @_isSelector($el)
      _$el = @$el.querySelectorAll($el)
      @on(_$el, eventType, callback)

  # DOM methods
  @find: (selector) ->
    @::find(selector)

  find: (selector) ->
    $root = @$el or document
    $root.querySelectorAll(selector)

  html: ($el, html) ->
    if @_isDOMCollection($el)
      for _$el in $el
        _$el.innerHTML = html
    else if @_isDOM($el)
      $el.innerHTML = html
    else if @_isSelector($el)
      _$el = @$el.querySelectorAll($el)
      @html(_$el, className)

  # get methods
  data: ($el, key) ->
    $el.dataset[key]

  value: ($el) ->
    if @_isDOMCollection($el)
      $el[0].value
    else if @_isDOM($el)
      $el.value
    else if @_isSelector($el)
      _$el = @$el.querySelectorAll($el)
      @value(_$el, className)

  # style methods
  addClass: ($el, className) ->
    if @_isDOMCollection($el)
      for _$el in $el
        _$el.classList.add(className)
    else if @_isDOM($el)
      $el.classList.add(className)
    else if @_isSelector($el)
      _$el = @$el.querySelectorAll($el)
      @addClass(_$el, className)

  removeClass: ($el, className) ->
    if @_isDOMCollection($el)
      for _$el in $el
        _$el.classList.remove(className)
    else if @_isDOM($el)
      $el.classList.remove(className)
    else if @_isSelector($el)
      _$el = @$el.querySelectorAll($el)
      @addClass(_$el, className)

  # helper
  _isDOMCollection: ($el) ->
    if typeof $el is 'object' and $el.length
      return true
    return false
  _isDOM: ($el) ->
    if typeof $el is 'object' and not $el.length
      return true
    return false
  _isSelector: ($el) ->
    if typeof $el is 'string'
      return true
    return false

microModule.export(MicroView)
