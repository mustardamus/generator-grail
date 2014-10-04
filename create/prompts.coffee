module.exports = [
  {
    type:    'input'
    name:    'name'
    message: 'Name of the Module to create (camelCase, one word)'
  }
  {
    type:    'checkbox'
    name:    'moduleParts'
    message: 'Select which parts of the Module you would like to create'
    choices: [
      { checked: true, value: 'module.coffee', name: 'Script   - The code part of your Module (.coffee)' }
      { checked: true, value: 'template.html', name: 'Template - The template for your Module (.html)' }
      { checked: true, value: 'style.styl',    name: 'Style    - The stylesheet for your Module (.styl)' }
      { checked: true, value: 'test.coffee',   name: 'Test     - The test case for your Module (.coffee)' }
    ]
  }
]
