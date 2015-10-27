module.exports =
  '/':
    name     : 'home'
    component: require('../components/page-home')

  '/register':
    name     : 'register'
    component: require('../components/page-register')

  '/login':
    name     : 'login'
    component: require('../components/page-login')

  '/user':
    name     : 'user'
    component: require('../components/page-user')
