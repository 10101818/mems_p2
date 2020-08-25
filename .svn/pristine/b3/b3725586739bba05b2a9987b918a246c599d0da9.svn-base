import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  //mode: 'history',
  routes: [
    {
      path: '/',
      name: 'login',
      meta: {
        title: '数据板'
      },
      component: () => import(/* webpackChunkName:'index'*/ '@/views/board/index'),
	  alias: 'index'
    },
	{
      path: '/indexSA',
      name: 'indexSA',
      meta: {
        title: '超级管理员'
      },
      component: () => import(/* webpackChunkName:'indexSA'*/ '@/views/board/indexSA'),
	  alias: 'index'
    },
	{
      path: '/indexA',
      name: 'indexA',
      meta: {
        title: '管理员'
      },
      component: () => import(/* webpackChunkName:'indexA'*/ '@/views/board/indexA'),
	  alias: 'index'
    },
	{
      path: '/indexU',
      name: 'indexU',
      meta: {
        title: '超级用户'
      },
      component: () => import(/* webpackChunkName:'indexU'*/ '@/views/board/indexU'),
	  alias: 'index'
    },
    {
      path: '/radar',
      name: 'radar',
      meta: {
        title: '数据板'
      },
      component: () => import(/* webpackChunkName:'radar'*/ '@/views/board/radar')
    },
  ]
})

