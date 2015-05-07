
states = [
  {
    icon: 'assets/images/red.png'
    phase: 'red'
  }
  {
    icon: 'assets/images/green.png'
    phase: 'green'
  }
  {
    icon: 'assets/images/blue.png'
    phase: 'refactor'
  }
]

module.exports =
  states: states
  get: (index) -> states[index]
  getIndex: (state) ->
    index = undefined
    states.forEach (el, i) ->
      if el.phase is state
        index = i
    index
