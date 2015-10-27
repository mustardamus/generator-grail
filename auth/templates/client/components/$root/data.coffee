module.exports = ->
  loggedIn    : false  # states if the user is logged in
  currentUser : null   # hold the data of the current user if logged in
  currentToken: null   # the jsonwebtoken that belongs to the user
