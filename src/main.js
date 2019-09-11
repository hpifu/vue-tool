import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import VueRouter from 'vue-router';

Vue.config.productionTip = false

Vue.use(VueRouter);
const router = new VueRouter({
  mode: 'history',
  base: __dirname,
  routes: [
    {
      path: '/', component: () => import('./components/TBase64')
    }, {
      path: '/hash', component: () => import('./components/THash')
    }, {
      path: '/base64', component: () => import('./components/TBase64')
    }, {
      path: '/decimal', component: () => import('./components/TDecimal')
    }, {
      path: '/timestamp', component: () => import('./components/TTimestamp')
    }
  ]
})

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
