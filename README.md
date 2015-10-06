# Grail [Yeoman](http://yeoman.io/) Generator

My personal Holy Grail for quickly getting started with a sweet webdev environment.
If you can't catch it, at least you can come close. Using/modifying it for over a year,
haven't looked back.

![](https://camo.githubusercontent.com/87f28a72cfc754122b0ce1611c402e94367ccf06/687474703a2f2f7777772e74696d6573686967686572656475636174696f6e2e636f2e756b2f50696374757265732f7765622f6e2f752f6b2f6e6577735f31385f3236303131322e6a7067)

## Installation

This generator is work in progress and not in the NPM registry yet. To install
it do:

    git clone git@github.com:mustardamus/generator-grail.git
    cd generator-grail
    npm install
    npm link

## Generate a app

Make sure you have Yeoman installed: `npm install -g yo`. Then:

    mkdir grailtest
    cd grailtest
    yo grail

This will create a bare-bone webdev environment for a modular one
page application. Check out the [README.md](./app/templates/README.md)
for an app to see what you'll get and how it works.

## Extend the app

    yo grail:extend

Check out the [README.md](https://github.com/mustardamus/generator-grail/blob/master/extend/templates/README.md)
section for extending and see what you'll get.

## Extend the app with a server

    yo grail:server

Check out the [README.md](https://github.com/mustardamus/generator-grail/blob/master/server/templates/README.md)
section for extending and see what you'll get. [TODO]

## Generate a component

    yo grail:create

You will be prompted with a couple of stuff.

## TODO

  - make tests for the $root and router components
