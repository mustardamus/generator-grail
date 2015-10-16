module.exports =
  name: [
    {
      type:    'list'
      name:    'componentType'
      message: 'What type of Component would you like to create?'
      choices: [
        { checked: true, value: 'client',  name: 'Client - Vue.js Component for the Frontend' }
        { checked: false, value: 'server', name: 'Server - Express.js Component for the Backend' }
      ]
    }
    {
      type:    'input'
      name:    'name'
      message: 'Name of the Component to create (multiple words: split-with-dash):'
    }
  ]

  clientComponent: [
    {
      type:    'checkbox'
      name:    'componentParts'
      message: 'Select which parts of the Vue.js Client Component you would like to create:'
      choices: [
        { checked: true, value: 'index.coffee',  name: 'Script   - The code part of your Component (.coffee)' }
        { checked: true, value: 'template.html', name: 'Template - The template for your Component (.html)' }
        { checked: true, value: 'style.styl',    name: 'Style    - The stylesheet for your Component (.styl)' }
        { checked: true, value: 'test.coffee',   name: 'Test     - The test case for your Component (.coffee)' }
      ]
    }
  ]

  serverComponent: [
    {
      type:    'checkbox'
      name:    'componentParts'
      message: 'Select which parts of the Express.js Server Component you would like to create:'
      choices: [
        { checked: true, value: 'model.coffee',       name: 'Model      - Mongoose Model Schema' }
        { checked: true, value: 'route.coffee',       name: 'Routes     - Express.js Routes for the resource' }
        { checked: false, value: 'initialize.coffee', name: 'Initialize - Setup code for Express.js' }
        { checked: false, value: 'helper.coffee',     name: 'Helper     - Helper available to Routes and Models' }
      ]
    }
  ]
