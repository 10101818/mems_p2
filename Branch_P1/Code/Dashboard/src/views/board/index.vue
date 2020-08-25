<template>
	<div class="container">
	</div>
</template>
<script>
	import {BASE_URL} from '@/common/common'
	export default {
		data() {
			return {}
		},
		created() {
			console.log("enter index")
			localStorage.removeItem("date")
			this.getCurrUserVue()
		},
		methods: {
			getCurrUserVue() {
				if(roleID < 0)
					window.location.href=BASE_URL+"/Home/Login";
				else if(roleID == 1)
					this.$router.push("indexSA");
				else if(roleID ==2)
					this.$router.push("indexA");
				else
					this.$router.push("indexU");
			},
		}
	}
</script>

