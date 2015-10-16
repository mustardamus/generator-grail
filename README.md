# Grail [Yeoman](http://yeoman.io/) Generator

My personal Holy Grail for quickly getting started with a sweet webdev
environment. If you can't catch it, at least you can come close. Using/modifying
it for over a year, haven't looked back.

![](https://camo.githubusercontent.com/87f28a72cfc754122b0ce1611c402e94367ccf06/687474703a2f2f7777772e74696d6573686967686572656475636174696f6e2e636f2e756b2f50696374757265732f7765622f6e2f752f6b2f6e6577735f31385f3236303131322e6a7067)

## Installation

This generator is work in progress and not in the NPM registry yet. To install
it do:

    git clone git@github.com:mustardamus/generator-grail.git
    cd generator-grail
    npm install
    npm link

## `yo grail` - Generate a app

Make sure you have [Yeoman](http://yeoman.io/) installed: `npm install -g yo`.
Then:

    mkdir appname
    cd appname
    yo grail

This will create a bare-bone webdev environment for a modular one page
application. Check out the [README.md](./app/templates/README.md) for an app to
see what you'll get and how it works.

## `yo grail:extend` - Extend the frontend app

My personal choice in frontend libraries and frameworks, like
[Vue.js](http://vuejs.org/guide/), [jQuery](https://jquery.com/),
[Semantic-UI](http://semantic-ui.com/) and [Socket.io](http://socket.io/docs/)
(available in combination with `yo grail:server`).

Check out the [README.md](./extend/templates/README.md)
for extending the app to see what you'll get and how it works.

## `yo grail:server` - Extend with a Node.js backend

Sometimes just a frontend is not enough. If you'd like to have a simple
[Express.js](http://expressjs.com/), [MongoDB](https://www.mongodb.org/),
[Lodash](https://lodash.com/docs) and [Socket.io](http://socket.io/docs/)
backend to build on, run this generator.

Check out the [README.md](./server/templates/README.md)
for the backend to see what you'll get and how it works.

## `yo grail:auth` - Extend front- and backend with registration/authentication

Run this generator to have a boilerplate for basic user registration and
authentication. Note that you need to run `yo grail:extend` and
`yo grail:server` beforehand.

Check out the [README.md](./auth/templates/README.md)
for the registration/authentication to see what you'll get and how it works.

## `yo grail:create` - Create a Client/Server Component

This generator quickly creates a Component for the Client (Code, Style, Template
and/or Test) and the Server (Initialize, Helper, Routes, Model). Just run it and
you are prompted with the different options.
