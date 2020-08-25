<template>
  <div class="event-list-container">
    <EventList></EventList>
  </div>
</template>
<script>
  import EventList from '../../components/componentEventList'

  export default {
    components: {
      EventList,
    },
    data() {
      return {}
    },
  }
</script>
<style scoped lang="less">
  .event-list-container {
    width: 100%;
    height: 100%;
    position: relative;
  }

</style>
<style>
  /* .main-header {
    display: none;
  } */
</style>

