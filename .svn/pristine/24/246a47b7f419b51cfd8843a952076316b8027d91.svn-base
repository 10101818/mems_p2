import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'login',
      meta: {
        title: '数据板'
      },
      component: () => import('@/views/board/index')
    },
    {
      path: '/eventList',
      name: 'eventList',
      meta: {
        title: '数据板'
      },
      component: () => import('@/views/board/eventList')
    },
    {
      path: '/kpi',
      name: 'kpi',
      meta: {
        title: '数据板'
      },
      component: () => import('@/views/board/kpi')
    },
    {
      path: '/radar',
      name: 'radar',
      meta: {
        title: '数据板'
      },
      component: () => import('@/views/board/radar')
    },
  ]
})

