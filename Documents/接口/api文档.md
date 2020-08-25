### Dashboard API接口方案
## 请求与返回
dashboard界面都是数据的展示，因此与后台通信可以用GET请求。
考虑实际业务，不强求使用restful风格。
请求形式为：
url: /path/to/data
method: GET
headers: {
	content-type: application/json,
	auth: token
	cookies: session-id
}
返回包体为：
{
	status: STATUS_CODE <int> (状态码，整形，预先约定好)，
	data: {
		(需要的data)
	}
}
## 具体接口
1.设备信息
1.1 设备信息总览
url: /Equipment/QueryOverview
response: {
	status: 0,
	data: {
		equipment_amount(设备数量): <int>,
		equipment_value(设备价值): <float>,
		depreciation_rate(折旧率): <float>,
		total_service(服务总人数): <int>
	}
}

1.2 部门收入支出信息
url: /Equipment/IncomeExpenseByDepartment
response: {
	status: 0,
	data: {
		depart_data:{
			departA(科室名): {
				income(收入): <float>,
				expense(支出): <float>
			},
			...
		}
		income_to_past(收入对比): <float>,
		expense_to_past(支出对比): <float>
	}
}

2.紧急事件
2.1 紧急事件总信息
url: /Request/QueryOverview
response: {
	status: 0,
	data: {
		repair_events(维修事件): {
		count(事件总数): <int>,
		detail(具体事件): [] <string> 	
		},
		callback_events(召回事件): {
		count(事件总数): <int>,
		detail(具体事件): [] <string> 
		},
		forcecheck_events(强检事件): {
		count(事件总数): <int>,
		detail(具体事件): [] <string> 
		},
		delayed_events(超期事件): {
		count(事件总数): <int>,
		detail(具体事件): [] <string> 
		}
	}
}

3.今日报修
3.1 今日报修总信息
url: /Request/Todays
response: {
	status: 0,
	data: {
		total_repair(今日总报修): <int>,
		detail(具体报修内容): {
			eventA: {
				department(报修科室): <string>,
				content(报修内容): <string>,
				present_status(当前状态): <string>
			}
		}
	}
}

4.KPI指标
4.1 kpi总览
url: /KPI/QueryOverview
response: {
	status: 0,
	data: {
		boot_rate(开机率): {
			default(及格开机率): <float>,
			present(当前开机率): <float>, 
		},
		calibration_rate(校准率): {
			plan(计划完成): <int>,
			done(已完成): <int> 
		},
		maintainance_rate(保养率): {
			plan: <int>,
			done: <int>
		},
		inspection_rate(巡检率): {
			plan: <int>,
			done: <int>
		}
	}
}