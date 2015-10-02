module.exports = [
  {
    type:    'input'
    name:    'name'
    message: 'Name of the Component to create (multiple words: split-with-dash)'
  }
  {
    type:    'checkbox'
    name:    'componentParts'
    message: 'Select which parts of the Component you would like to create'
    choices: [
      { checked: true, value: 'index.coffee',     name: 'Script        - The code part of your Component (.coffee)' }
      { checked: true, value: 'template.html',    name: 'Template      - The template for your Component (.html)' }
      { checked: true, value: 'style.styl',       name: 'Style         - The stylesheet for your Component (.styl)' }
      { checked: true, value: 'test.coffee',      name: 'Test          - The test case for your Component (.coffee)' }
    ]
  }
]
