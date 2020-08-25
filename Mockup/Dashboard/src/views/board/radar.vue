<template>
  <div class="container">
    <div class="b-left">
      <div class="b-left-top">
        <div class="chart1-box">
          <div class="name">{{name1}}</div>
          <div class="list-box1">
            <div class="list">
              <div class="total">
                <div class="value">{{numberComma(2260.09)}}</div>
                <div class="text">总收入（万元）</div>
              </div>
              <div class="status up">
                <div class="value">
                  <span>23.45%</span>
                  <span class="iconfont icon-shang"></span>
                </div>
                <div class="text">
                  同比
                </div>
              </div>
            </div>
            <div class="list">
              <div class="total">
                <div class="value">{{numberComma(1563.09)}}</div>
                <div class="text">总支出（万元）</div>
              </div>
              <div class="status down">
                <div class="value">
                  <span>23.45%</span>
                  <span class="iconfont icon-shang"></span>
                </div>
                <div class="text">
                  同比
                </div>
              </div>
            </div>
          </div>
          <div id="chart1"></div>
        </div>

      </div>
      <div class="b-left-bottom">
        <div class="name">
          {{currentData.name.split('?')[0]}}
          <br/>
          <p style="margin-top: .5rem">{{currentData.seriesNumber}}</p>
        </div>
        <div class="name-lower-box">
          <div class="name-lower">当前位置：{{currentData.department}}</div>
          <div class="name-lower">安装日期：{{currentData.start_time}}</div>
          <div class="name-lower">当前状态：{{currentData.status}}</div>
        </div>

        <div id="chart3"></div>
        <div class="list3">
          <div class="item" v-for="(list,key) of chart3.list" :key="key">
            <span class="title">{{list.item}}次数：</span>
            <span class="count">{{list.value}}次</span>
          </div>
        </div>
      </div>
    </div>
    <div class="b-right">
      <div class="b-right-content">
        <div class="timeline-title" style="font-size: 32px;">{{timelineTitle}}</div>
        <div class="b-timeline">
          <timeline>
            <timeline-item v-for="(item,key) in timeline" :key="key" :bg-color="item.color" @click.native="navigateTo(item)">{{item.date}} {{item.event}}
            </timeline-item>
          </timeline>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import {equipments, radar, timeline} from '@/api/api'
  import G2 from '@antv/g2';
  import {DataSet} from '@antv/data-set'
  import {queryOverview} from '@/api/api'
  import {getRem} from '@/common/common'
  import {RADAR_DATA, TIMELINE, RADAR} from '../../../static/data'
  import EventList from '../../components/componentEventList'
  import KpiList from '../../components/componentKpiGauge'
  import {Timeline, TimelineItem, TimelineTitle} from 'vue-cute-timeline'

  export default {
    components: {
      EventList,
      KpiList,
      Timeline,
      TimelineItem,
      TimelineTitle
    },

    data() {
      return {
        timelineTitle: '',
        timeline: [],
        name1: this.$route.query.name,
        currentData: {
          name: '',
        },
        chart1: {
          data: [],
        },

        chart3: {
          data: [],
          list: [],
          chart: null,
        }
        // list3: [],

      }
    },
    computed: {},
    created() {
      // this.name2 = this.chart1.data[0].name
      // this.getqueryOverview()
      this.getChart1().then(() => {
        //默认选中第一条数据
        this.currentData = this.chart1.data[0]
        // 获取chart1之后获取雷达
        this.renderChart1()
        this.getChart3().then(() => {
          this.renderChart3()
        })
        // 获取timeline
        this.getTimeline()
      })
    },
    methods: {
      navigateTo: function(item){
        console.log(item);
        if(item.event.indexOf('维修')>-1) {
          window.open('page/DMApproveRepairApplication.html');
        }
      },
      getChart1() {
        // this.name1
        return new Promise(resolve => {
          this.chart1.data = []
          RADAR_DATA.forEach((n, i) => {
            if (n.所属科室 === this.name1) {
              this.chart1.data.push({
                name: n.设备名称 + ' ' + n.品牌 + ' ' + n.型号 + '?' + i,
                brand: n.品牌,
                model: n.型号,
                收入: this.random(80, 100),
                支出: this.random(80, 100),
                value: n.单价 / 10000,
                seriesNumber: n.资产编号,
                department: n.所属科室,
                start_time: n.开始使用日期,
                status: '开机',
                // serialCode: '设备序列号:' + n.资产编号 + ' 当前位置：' + n.所属科室 + ' 安装日期：' + n.开始使用日期 + ' 当前状态：开机'
              })
            }
          })
          //   equipments({department: this.name1}).then(res => {
          //     this.chart1.data = res.data.map((n, i) => {
          //       return Object.assign({}, n, {
          //         name: n.name + ' ' + n.brand + '' + n.model + '?' + i,
          //         '收入': n.income,
          //         '支出': n.expense,
          //       })
          //     })
          resolve()
          //   })
        })
      },
      random(lower, upper) {
        return Math.floor(Math.random() * (upper - lower)) + lower;
      },
      getChart3() {
        let _this = this
        return new Promise(resolve => {
          _this.chart3.list = RADAR;
          var _DataSet = DataSet,
            DataView = _DataSet.DataView;
          var dv = new DataView().source(_this.chart3.list);
          dv.transform({
            type: 'fold',
            fields: ['value'], // 展开字段集
            key: 'user', // key字段
            value: 'score' // value字段
          });
          this.chart3.data = dv
          resolve(dv)
          radar().then(res => {
          })
        })
      },
      getTimeline() {
        // timeline().then(res => {
        //   this.timelineTitle = res.equipment
        //   this.timeline = res.timeline
        // })
        this.timelineTitle = TIMELINE.equipment;
        this.timeline = TIMELINE.timeline;
      },
      renderChart1() {
        // let rem =
        let _this = this
        var dv = new DataSet.DataView();
        dv.source(this.chart1.data).transform({
          type: 'map',
          callback: function callback(row) {
            row['支出'] *= -1;
            return row;
          }
        })
          .transform({
            type: 'fold',
            fields: ['收入', '支出'],
            key: 'opinion',
            value: 'value',
            retains: ['name']
          });

        console.log(dv)
        var colorMap = {
          '收入': '#86C7E6',
          '支出': '#1B85E7',
        };

        var chart = new G2.Chart({
          container: 'chart1',
          forceFit: true,
          height: document.querySelector('#chart1').clientHeight,
          padding: [getRem(1.6), 0, 0, 0],
          // animate: false,
        });
        chart.source(dv);
        chart.axis(false);


        this.chart1.data.forEach(function (data, dataIndex) {

          if (data['支出'] > data['收入']) {
            // 辅助框
            chart.guide().regionFilter({
              top: true, // 指定 giude 是否绘制在 canvas 最上层，默认为 false, 即绘制在最下层
              start: [dataIndex - .25, -data['收入']], // 辅助框起始位置，值为原始数据值，支持 callback
              end: [dataIndex + .25, -data['支出']],// 辅助框结束位置，值为原始数据值，支持 callback
              color: '#E2340D',
            });
          }
        });


        chart.tooltip({
          inPlot: true,
          useHtml: true,
          htmlContent: function (title, items) {
            let data = {};
            _this.chart1.data.forEach(n => {
              if (n.name === title) {
                data = n
              }
            })
            return `<div class="g2-tooltip">
                    <div class="g2-tooltip-title">${title.split('?')[0]}</div>
                    <ul class="g2-tooltip-list">
                      <li class="g2-tooltip-li">设备价值：${_this.numberComma(data.value)}万</li>
                      <li class="g2-tooltip-li">型号：${_this.numberComma(data.model)}</li>
                      <li class="g2-tooltip-li">品牌：${_this.numberComma(data.brand)}</li>
                      <li class="g2-tooltip-li">收入：${_this.numberComma(data.收入)}万</li>
                      <li class="g2-tooltip-li">支出：${_this.numberComma(data.支出)}万</li>
                    </ul>
                  </div>`
          }
        });
        // console.log(getRem())

        chart.legend({
          custom: true,
          itemWidth: getRem(1.4),
          items: [
            {
              value: '收入', // 图例项的文本内容
              marker: {
                symbol: 'square',  // 该图例项 marker 的形状，参见 marker 参数的说明
                fill: colorMap['收入'],  // 该图例项 marker 的填充颜色
                radius: getRem(.1)
              }
            },
            {
              value: '支出', // 图例项的文本内容
              marker: {
                symbol: 'square',  // 该图例项 marker 的形状，参见 marker 参数的说明
                fill: colorMap['支出'],  // 该图例项 marker 的填充颜色
                radius: getRem(.1)
              }
            },
          ],
          position: 'top-left',
          offsetX: getRem(.2),
          offsetY: -getRem(.2),
          // marker: {fill: 'red'},
          textStyle: {
            // textAlign: 'center', // 文本对齐方向，可取值为： start middle end
            fill: '#000', // 文本的颜色
            fontSize: getRem(.36), // 文本大小
            // textBaseline: 'top' // 文本基准线，可取 top middle bottom，默认为middle
          },


          hoverable: false,
          reactive: false,
          clickable: false,
          // title: {
          //   textAlign: 'center', // 文本对齐方向，可取值为： start middle end
          //   // fill: '#404040', // 文本的颜色
          //   fontSize: '50', // 文本大小
          //   // fontWeight: 'bold', // 文本粗细
          //   textBaseline: 'top' // 文本基准线，可取 top middle bottom，默认为middle
          // }
          // autoWrap: false,
        });

        // chart.axis(false);
        chart.coord();
        chart.intervalStack().position('name*value').color('opinion', function (opinion) {
          return colorMap[opinion];
        });

        chart.on('click', ev => {
          // 获取逼近的点 point 的原始数据集合
          var records = chart.getSnapRecords({x: ev.x, y: ev.y});
          console.log(records);
          // const data = ev.data;
          const name = records[0]._origin.name
          var targetItem = _this.chart1.data.find(function (val) {
            return val.name === name;
          })
          console.log(targetItem);
          _this.currentData = targetItem
          //获取雷达数据
          _this.getChart3().then(dv => {
            _this.chart3.chart.changeData(dv);
          })
          //获取timeline
          _this.getTimeline()
        });

        chart.render();
      },

      renderChart3() {
        let _this = this

        // console.log(_this.data3)
        _this.chart3.chart = new G2.Chart({
          container: 'chart3',
          forceFit: true,
          height: document.querySelector('#chart3').clientHeight,
          padding: [getRem(.5), getRem(.2), 0, getRem(.1)]
        });
        _this.chart3.chart.source(_this.chart3.data, {
          score: {
            min: 0,
            max: 10
          }
        });
        _this.chart3.chart.coord('polar', {
          radius: 0.6
        });
        _this.chart3.chart.axis('item', {
          line: null,
          label: {
            // offset: {number}, // 设置坐标轴文本 label 距离坐标轴线的距离
            textStyle: {
              // textAlign: 'center', // 文本对齐方向，可取值为： start middle end
              // fill: '#404040', // 文本的颜色
              fontSize: getRem(.4), // 文本大小
              fontWeight: 'bold', // 文本粗细
              // rotate: 30,
              // textBaseline: 'top' // 文本基准线，可取 top middle bottom，默认为middle
            },
            // autoRotate: {boolean} // 是否需要自动旋转，默认为 true
          },
          tickLine: null,
          grid: {
            lineStyle: {
              lineDash: null
            },
            hideFirstLine: false
          }
        });
        _this.chart3.chart.axis('score', {
          // title: null,
          label: null,
          line: null,
          tickLine: null,
          grid: {
            type: 'polygon',
            lineStyle: {
              lineWidth: getRem(.02),
              lineDash: null
            }
          }
        });
        _this.chart3.chart.legend(false)
        _this.chart3.chart.tooltip({
          // showTitile: false,
          'g2-tooltip': {
            'background-color': 'rgba(0, 0, 0, 0.7)',
            color: '#ddd',
          },
          itemTpl: '<li style="font-size: .4rem;">次数：{value}</li>'
        });
        _this.chart3.chart.line().position('item*score').color('user').size(getRem(.01));
        // chart.point().position('item*score').color('user').shape('circle').size(getRem(.04)).style({
        //   stroke: '#fff',
        //   lineWidth: 1,
        //   fillOpacity: 1
        // });
        _this.chart3.chart.area().position('item*score').color('user');
        // chart.active(false)
        // const geoms = chart.getAllGeoms();
        // for (let i = 0; i < geoms.length; i++) {
        //   const geom = geoms[i];
        //   geom.select(false)
        // }
        _this.chart3.chart.render();
      },
      numberComma(source, length = 3) {
        source = String(source).split(".");
        source[0] = source[0].replace(new RegExp('(\\d)(?=(\\d{' + length + '})+$)', 'ig'), "$1,");
        return source.join(".");
      },
    }
  }
</script>
<style scoped lang="less">
  .container {
    min-width: 1200px;
    width: 100%;
    height: 100%;
    background: #D7E0EE;
    overflow: hidden;
    font-size: .4rem;
    padding: .3rem;
    display: flex;

    .b-left {
      width: 50%;
      height: 100%;
      display: flex;
      flex-direction: column;

      .b-left-top {
        border-radius: .16rem;
        height: 50%;
        margin: .15rem;
        background: #fff;

        .chart1-box {
          background: #fff;
          /*flex: 1;*/
          padding: .5rem;
          position: relative;
          border-radius: .16rem;
          height: 100%;

          .name {
            position: absolute;
            font-size: .5rem;
            font-weight: bold;
          }

          .list-box1 {
            position: absolute;
            right: 0;
            left: 0;
            padding-right: .2rem;
            top: .5rem;
            display: flex;
            justify-content: flex-end;
            z-index: 2;

            .list {
              display: flex;
              align-items: baseline;
              margin-left: .6rem;

              .total {
                margin-right: .4rem;

                .value {
                  font-weight: bold;
                  font-size: .6rem;
                  margin-bottom: .1rem;
                }

                .text {
                  font-size: .4rem;
                }
              }

              .status {


                .value {
                  font-weight: bold;
                  font-size: .6rem;
                  display: flex;
                  align-items: baseline;
                  margin-bottom: .1rem;

                  .iconfont {
                    font-size: .7rem;
                  }
                }

                .text {
                  color: #000;
                  font-size: .4rem;
                }

                &.up {
                  color: #E64340;
                }

                &.down {
                  color: #3eaf7c;

                  .iconfont {
                    transform: rotate(180deg);
                  }
                }
              }
            }
          }

          #chart1 {
            width: 100%;
            height: 100%;
          }
        }

      }

      .b-left-bottom {
        border-radius: .16rem;
        height: 50%;
        margin: .15rem;
        background: #fff;
        display: flex;
        position: relative;

        .name {
          position: absolute;
          left: .5rem;
          top: .5rem;
          font-size: .5rem;
          font-weight: bold;
        }

        .name-lower-box {
          display: flex;
          width: 25%;
          justify-content: center;
          flex-direction: column;
          font-weight: bold;
          padding-left: .5rem;

          .name-lower {
            margin: .3rem 0;
          }
        }

        #chart3 {
          width: 50%;
          height: 100%;
        }

        .list3 {
          width: 25%;
          font-weight: bold;
          display: flex;
          flex-direction: column;
          justify-content: center;
          padding-left: .3rem;

          .item {
            margin: .3rem 0;

            .title {
            }

            .count {

            }
          }


        }
      }
    }

    .b-right {
      width: 50%;
      height: 100%;
      padding: .15rem;

      .b-right-content {
        width: 100%;
        height: 100%;
        border-radius: .16rem;
        background: #fff;
        padding: .8rem;
        overflow-y: auto;

        .b-timeline {
          width: 100%;
          height: 100%;
          overflow-y: auto;
          cursor: pointer;

          /deep/ .timeline {
            margin: 0.5rem 1rem;

            &:after {
              top: 1.6rem;
              height: auto;
              bottom: .8rem;
            }

            .timeline-title {
              font-size: .6rem;
              font-weight: bold;
              margin: -.15em 0 .5rem 0;
              cursor: default;
            }

            .timeline-item {
              margin: 1.5em 0 0 .5rem;
            }

            .timeline-circle {
              top: 0;
              width: .3rem;
              height: .3rem;
              left: -.65rem;
            }

            .timeline-title-circle {
              width: 0;
              height: 0;
              display: none;
            }
          }
        }

      }
    }


    /deep/ .g2-tooltip {
      z-index: 99;
      position: absolute;
      background-color: rgba(0, 0, 0, 0.7);
      border-radius: .16rem;
      color: #ddd;
      font-size: .36rem;
      line-height: 1.2;
      padding: .24rem .24rem .1rem .24rem;
      box-shadow: 0 0 .1rem #aeaeae;
    }

    /deep/ .g2-tooltip-title {
      font-size: .4rem;
    }

    /deep/ .g2-tooltip-list {
      padding: 0;
      list-style-type: none;
      margin-top: .2rem;

      .g2-tooltip-li {
        margin: .2rem 0;
      }
    }

    canvas {
      background: #fff;
      width: 100%;
      height: 100%;
    }

  }


</style>

