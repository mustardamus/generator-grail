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

  '/forgot-password':
    name     : 'forgot-password'
    component: require('../components/page-forgot-password')

  '/reset-password/:token':
    name     : 'reset-password'
    component: require('../components/page-reset-password')
