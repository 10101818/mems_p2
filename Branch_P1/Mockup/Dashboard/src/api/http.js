import axios from 'axios'
import qs from 'qs'
import {BASE_URL} from '../common/common'
// import that from '../main.js';

let cancel, promiseArr = {};
const Axios = axios.create({
  baseURL: BASE_URL,
  // baseURL: '/api',
  // withCredentials: true,
  timeout: 5000,
  headers: {
    // 'X-Requested-With': 'XMLHttpRequest',
    'Content-Type': 'application/x-www-form-urlencoded',
    // 'X-Requested-With': 'XMLHttpRequest'
  }
});
// Axios.defaults.headers['Content-Type'] = 'application/x-www-form-urlencoded';
// Axios.interceptors.request.use((config) => {
//   console.log('config',config)
//   // config.headers['Content-Type'] = 'application/x-www-form-urlencoded'
//   // config.headers['Content-Type'] = 'application/x-www-form-urlencoded'
//   return config
// })
Axios.interceptors.response.use(response => {
    //成功请求到数据
    // if (response.data.code === 401) {
    //     //没有登录
    //     that.$router.replace({
    //         path: '/',
    //         query: {
    //             path: window.location.href
    //         }
    //     })
    //     // return response;
    // } else if (response.data.code === 403) {
    //     //没有关注公众号
    //     that.$vux.toast.text(response.data.msg)
    //     WeixinJSBridge.call('closeWindow');
    // } else {
    // }
    return response;

  },
  // error => {
  //   //响应错误处理
  //   console.log(error);
  //   console.log(JSON.stringify(error));
  //
  //   let text = JSON.parse(JSON.stringify(error)).response.status === 404
  //     ? '404'
  //     : '网络异常，请重试';
  //   return Promise.reject(error)
  //
  // }
)

/**
 * get请求
 * @param url
 * @param params
 * @returns {Promise}
 */

export function $httpGet(url, params) {
  // NProgress.start();
  return new Promise((resolve, reject) => {
    Axios.get(url, {params}).then(({data}) => {
      // NProgress.done();
      resolve(data);

    }).catch(data => {
      // that.$vux.toast.text(data)

      // NProgress.done();
      reject(data);
    })
  })
}

/**
 * post请求
 * @param url
 * @param params
 * @returns {Promise}
 */

export function $httpPost(url, params) {
  params = qs.stringify(params);
  // NProgress.start();
  return new Promise((resolve, reject) => {
    Axios.post(url, params).then(({data}) => {
      // NProgress.done();
      resolve(data);
    }).catch(data => {
      // that.$vux.toast.text(data)
      // NProgress.done();
      reject(data);
    })
  })
}
