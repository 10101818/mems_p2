import {$httpGet, $httpPost} from '@/api/http'


export const queryOverview = params => {
  return $httpGet('/Equipment/QueryOverview', params);
};

//事件列表
export const eventList = params => {
  return $httpGet('/Request/QueryOverview', params);
};

// kpi指标
export const kpiList = params => {
  return $httpGet('/KPI/QueryOverview', params);
};

// 科室的设备
export const equipments = params => {
  return $httpGet('/equipments_info_by_department', params);
};

// 获取雷达
export const radar = params => {
  return $httpGet('/radar_by_equipment', params);
};

// 获取timeline
export const timeline = params => {
  return $httpGet('/timeline_by_equipment', params);
};
