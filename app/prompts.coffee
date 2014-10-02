dirArr     = process.cwd().split('/')
currentDir = dirArr[dirArr.length - 1]

module.exports = [
  {
    type:    'input'
    name:    'name'
    default: currentDir
    message: 'Name of the application'
  }
  {
    type:    'input'
    name:    'description'
    message: 'Short description of the application'
  }
  {
    type:    'input'
    name:    'author'
    default: 'Sebastian Senf (me@akrasia.me)'
    message: 'Author of the application'
  }
  {
    type:    'input'
    name:    'license'
    default: 'MIT'
    message: 'License of the appliction'
  }
]
