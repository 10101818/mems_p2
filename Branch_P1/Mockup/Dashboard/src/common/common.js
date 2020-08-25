// import that from '../main.js';
// import axios from 'axios'

export const BASE_URL = process.env.NODE_ENV == 'development'
  ? 'http://api.stramogroup.com/'
  // : 'http://test.yltyxy.com/'
  : 'http://api.stramogroup.com/'

export const getRem = function (n = 1) {
  if (isNaN(n)) return
  n = Number(n);
  let html = document.querySelector('html');
  let fontSize = window.getComputedStyle(html).getPropertyValue('font-size');
  return n * parseFloat(fontSize);
}
