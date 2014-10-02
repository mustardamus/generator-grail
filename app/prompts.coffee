dirArr     = process.cwd().split('/')
currentDir = dirArr[dirArr.length - 1]

module.exports = [
  {
    type:    'input'
    name:    'name'
    default: currentDir
    message: 'Name of the application'
  }
]
