<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
  export default {
    name: 'App'
  }
</script>

<style>
  @import 'css/common.css';

  #app {
    /*height: 100%;*/
    width: 100%;
    margin: 0 auto;
    position: relative;
  }
</style>
