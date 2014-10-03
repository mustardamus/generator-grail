{{#if tools.zepto}}
require('zepto')   # installed by Bower and globally defined as $
{{/if}}
{{#if tools.ractive}}
require('ractive') # installed by Bower and globally defined as Ractive
{{/if}}

Layout = require('./modules/layout/module')
layout = new Layout
