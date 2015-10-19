## Registration and Authentication

A boilerplate for basic user registration and authentication. This is based on
`yo grail:extend` and `yo grail:server`.

Please note that this is a boilerplate to get started. In the future you likely
want to implement more security measures like brute-force protection,
password-strength and e-mail confirmation.

### Backend

This is a custom implementation with
[jsonwebtoken](https://github.com/auth0/node-jsonwebtoken) and
[bcrypt](https://github.com/ncb000gt/node.bcrypt.js).

#### `POST /register`

On this route a user can register with a username and a password. It is checked
if the user already exist.

#### `POST /login`

On this route a user can login and generate a token that is delivered to the
frontend and acts as a session. Logging out just happens on the frontend by
destroying the token.

#### `GET /users/me`

This route will return the information of the current logged in user.

#### `POST /users/me`

On this route a user can update her information: username, e-mail and password.
It is checked if the username and e-mail already exists. To change the password
the user must provide the current password.

#### `auth` Middleware

You can protect routes by the authentication middleware like this:

    module.exports = (config, helpers, io, models) ->
      auth = require('../middleware/auth')(config, helpers, models)

      @get '/inside', auth, (req, res) ->
        res.json req.user

If the authentication fails, a 403 code is delivered to the client and the
defined callback is never happening. If the authentication succeeds, `req.user`
is populated with the Mongoose User Model.

### Frontend

Requests are happening exclusively via AJAX.

#### `/#/register`

On this page is the register form. Username, password and password check. With
form validation on the client-side. Once a user is registered he is already
logged in because the server returns the token.

#### `/#/login`

On this page a user can login with username and password. If successfully logged
in, the server will return the token.

#### `/#/user`

On this page a user can see and edit her information. If the e-mail is missing,
a extra message is displayed saying to provide a e-mail. Form validation is
happening on the client-side. To change the password the current password must
be provided.

#### Determine if a user is logged in

Once a user is successfully logged in (either by registering, logging in or
already set token), there are multiple data available on the `@$root.$data`
object:

    loggedIn    : true/false   # a simple boolean stating if the user is logged in
    currentUser : null/object  # if logged in, the user information (except password) is stored here
    currentToken: null/string  # the token of the current logged in user
