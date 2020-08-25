<template>
  <div class="component-gauge-container">
    <div id="kpi-chart"></div>
    <div class="list-box">
      <div class="list" v-for="(item,key) of list" :key="key" @click="link(item)">
        <div class="list-box-left">
          <div class="text">{{item.name}}</div>
          <div class="percent">{{item.value}}<span style="font-size: .4rem;">%</span></div>
        </div>
        <div class="list-box-right">
          <div class="schedule">
            <div class="bg" :style="{width:item.value + '%'}"></div>
            <div class="target" :style="{left:'90%'}"></div>
          </div>
          <div class="schedule-text">
            <span class="label">已完成<span class="count">{{item.processed}}<span class="jian">件</span></span></span>
            <span class="label">本月计划<span class="count">{{item.total}}<span class="jian">件</span></span></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import G2 from '@antv/g2';
  import {DataSet} from '@antv/data-set'
  import {kpiList} from '@/api/api'
  import {getRem} from '@/common/common'
  import {KPI} from '../../static/data'

  export default {

    components: {},
    model: {},
    props: {},
    data() {
      return {
        chart: {
          value: 0,
          target: 0,
        },
        list: [
          {
            key: 'Calibration',
            name: '校准率',
            value: 0,
            processed: 0,
            total: 0,
            target: 0,
          },
          {
            key: 'Maintainance',
            name: '保养率',
            value: 0,
            processed: 0,
            total: 0,
            target: 0,
          },
          {
            key: 'Inspection',
            name: '巡检率',
            value: 0,
            processed: 0,
            total: 0,
            target: 0,
          },
        ],
      }
    },
    watch: {},

    created() {
      this.getList().then(() => {
        this.renderChart()
      })
    },
    methods: {
      link(item) {
        if (item.name === '保养率') {
          window.open('page/index-FujiManagerMaintain.html', '_self')
        }
      },
      getList() {
        return new Promise(resolve => {
          let data = KPI;
          // data.BootRate.CurrentRate = 0.99
          this.chart.value = (data.BootRate.CurrentRate * 10).toFixed(1) * 1
          this.chart.target = (data.BootRate.TargetRate * 10).toFixed(1) * 1
          this.list.forEach(n => {
            n.value = (data[n.key].Processed / data[n.key].Total).toFixed(2) * 100
            n.processed = data[n.key].Processed
            n.total = data[n.key].Total
          })
          resolve()
          kpiList().then(res => {
            console.log(res)
            // res.Data
          })
        })
      },
      renderChart() {
        let n = Math.max(Math.ceil(this.chart.value), 2)
        console.log('n:', n)
        let _this = this

        function creatData(i) {
          // this.chart.value
          let data = [];
          let val = _this.chart.value * i / (n - 1);
          val = val.toFixed(1);
          data.push({
            value: val * 1
          });
          return data;
        }

        let Shape = G2.Shape;
        // 自定义Shape 部分
        Shape.registerShape('point', 'pointer', {
          drawShape: function drawShape(cfg, group) {
            let center = this.parsePoint({ // 获取极坐标系下画布中心点
              x: 0,
              y: 0
            });
            let point = cfg.points[0];
            let target = this.parsePoint({
              x: point.x,
              y: 1
            });
            let dir_vec = {
              x: center.x - target.x,
              y: center.y - target.y
            };
            //normalize
            let length = Math.sqrt(dir_vec.x * dir_vec.x + dir_vec.y * dir_vec.y);
            dir_vec.x *= 1 / length;
            dir_vec.y *= 1 / length;
            //rotate dir_vector by -90 and scale
            let angle1 = -Math.PI / 2;
            let x_1 = Math.cos(angle1) * dir_vec.x - Math.sin(angle1) * dir_vec.y;
            let y_1 = Math.sin(angle1) * dir_vec.x + Math.cos(angle1) * dir_vec.y;
            //rotate dir_vector by 90 and scale
            let angle2 = Math.PI / 2;
            let x_2 = Math.cos(angle2) * dir_vec.x - Math.sin(angle2) * dir_vec.y;
            let y_2 = Math.sin(angle2) * dir_vec.x + Math.cos(angle2) * dir_vec.y;
            //polygon vertex

            let n = getRem(.16)
            // 画指针
            let path = [['M', target.x + x_1 * 1, target.y + y_1 * 1], ['L', center.x + x_1 * n, center.y + y_1 * n], ['L', center.x + x_2 * n, center.y + y_2 * n], ['L', target.x + x_2 * 1, target.y + y_2 * 1], ['Z']];
            group.addShape('path', {
              attrs: {
                path: path,
                fill: '#E64340'
              }
            });
            // 画指针上的圆
            return group.addShape('circle', {
              attrs: {
                x: center.x,
                y: center.y,
                r: getRem(.3),
                stroke: '#E64340',
                lineWidth: 2,
                fill: '#E64340'
              }
            });
          }
        });


        let chart = new G2.Chart({
          container: 'kpi-chart',
          forceFit: true,
          height: document.querySelector('#kpi-chart').clientHeight,
          padding: 'auto',
          animate: false,
        });
        chart.source(creatData());
        // 坐标轴
        chart.coord('polar', {
          startAngle: -9 / 8 * Math.PI,
          endAngle: 1 / 9 * Math.PI,
          radius: 1,
        });
        // 刻度
        chart.scale('value', {
          min: 0,
          max: 10,
          tickInterval: 1,
          nice: false
        });

        chart.axis(false);
        chart.legend(false);
        chart.point().position('value*1').shape('pointer').color('#1890FF').active(false);

        // chart.render();

        for (let i = 0; i < n; i++) {
          setTimeout(() => {
            draw(creatData(i));
          }, 100 * i)
        }

        function draw(data) {
          let val = data[0].value;
          chart.guide().clear();

          // 绘制仪表盘背景
          chart.guide().arc({
            zIndex: 0,
            top: false,
            start: [0, 0.945],
            end: [10, 0.945],
            style: { // 底灰色
              stroke: '#eef2f8',
              lineWidth: getRem(.5)
            }
          });

          // 绘制指标
          chart.guide().arc({
            zIndex: 1,
            start: [0, 0.945],
            end: [val, 0.945],
            style: {
              stroke: 'l(0) 0:#7BCDC8 1:#5579C4',
              lineWidth: getRem(.5)
            }
          });

          //目标线
          chart.guide().line({
            start: [0, 0],
            end: [_this.chart.target, 0.815],
            lineStyle: {
              stroke: '#E64340', // 线的颜色
              lineDash: [1], // 虚线的设置
              lineWidth: 1
            }
          });

          // 绘制仪表盘刻度线
          for (let i = 0; i <= 10; i++) {
            chart.guide().line({
              start: [i, 0.815],
              end: [i, 0.7],
              lineStyle: {
                stroke: '#aaa', // 线的颜色
                lineDash: null, // 虚线的设置
                lineWidth: 1
              }
            });
          }


          // 绘制指标数字
          chart.guide().html({
            position: ['50%', '72%'],
            html: '<div style="width: 3rem;text-align: center;">' +
              '<p style="font-size: .8rem;color: #E64340;margin: 0;font-weight: bold">' +
              val * 10 + '<span style="font-size: .4rem;">%</span></p>' +
              '<p style="font-size: .4rem; color: #444;margin-top: .1rem;">开机率</p></div>'
          });
          chart.changeData(data);
        }


      },
    }
  }

</script>


<style scoped lang="less">
  .component-gauge-container {
    width: 100%;
    height: 100%;
    display: flex;

    #kpi-chart {
      width: 30%;
      height: 100%;
    }

    .list-box {
      width: 70%;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 1.2rem .2rem 1.2rem .8rem;

      .list {
        display: flex;
        cursor: pointer;

        .list-box-left {
          .text {
            margin-bottom: .4rem;
          }

          .percent {
            font-weight: bold;
            color: #E64340;
            font-size: .6rem;
          }
        }

        .list-box-right {
          margin-left: .8rem;
          flex: 1;


          .schedule {
            width: 100%;
            height: .4rem;
            background: #ddd;
            margin-bottom: .4rem;
            position: relative;

            .bg {
              position: absolute;
              left: 0;
              top: 0;
              bottom: 0;
              background: linear-gradient(to right, #7accc6, #5579c4);
            }

            .target {
              height: 100%;
              width: 0;
              border-right: .02rem dotted #E64340;
              /*background: #E64340;*/
              position: absolute;
            }
          }

          .schedule-text {
            display: flex;
            justify-content: space-between;
            padding-right: 1.2rem;

            .label {
              font-size: .36rem;
            }

            .count {
              font-size: .6rem;
              font-weight: bold;

              .jian {
                font-size: .4rem;
              }
            }
          }
        }
      }


    }
  }

  canvas {
    background: #fff;
    width: 100%;
    height: 100%;
  }
</style>

