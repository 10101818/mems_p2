<template>
  <div class="container">
    <div class="b-left">
      <div class="b-left-top">
        <div class="chart1-box">
          <div class="name">{{name1}}</div>
          <div class="list-box1">
            <div class="list">
              <div class="total">
                <div class="value">{{numberComma(22608.09)}}</div>
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
                <div class="value">{{numberComma(99999.09)}}</div>
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
        <div class="name">{{name2}}</div>
        <div id="chart3"></div>
        <div class="list3">
          <div class="item" v-for="(list,key) of chart3.data" :key="key">
            <span class="title">{{list.item}}次数：</span>
            <span class="count">{{list.value}}次</span>
          </div>
        </div>
      </div>
    </div>
    <div class="b-right">
      <div class="b-right-content"></div>
    </div>
  </div>
</template>
<script>
  import {} from '@/api/api'
  import G2 from '@antv/g2';
  import {DataSet} from '@antv/data-set'
  import {queryOverview} from '@/api/api'
  import {getRem} from '@/common/common'
  import EventList from '../../components/componentEventList'
  import KpiList from '../../components/componentKpiGauge'

  export default {
    components: {
      EventList,
      KpiList,
    },

    data() {
      return {
        name1: this.$route.query.name,
        name2: '',
        chart1: {
          data: [{
            name: "设备1",
            '收入': 8000,
            '支出': 6000,
            '设备数量': 40,
            '设备价值': 4800,
            '服务人次': 99,
          }, {
            name: "设备2",
            '收入': 4000,
            '支出': 1111,
            '设备数量': 30,
            '设备价值': 8800,
            '服务人次': 2334,
          }, {
            name: "设备3",
            '收入': 3300,
            '支出': 2345,
            '设备数量': 50,
            '设备价值': 9800,
            '服务人次': 99,
          }, {
            name: "设备4",
            '收入': 4444,
            '支出': 5800,
            '设备数量': 47,
            '设备价值': 8800,
            '服务人次': 5555,
          }, {
            name: "设备5",
            '收入': 9999,
            '支出': 4900,
            '设备数量': 53,
            '设备价值': 8800,
            '服务人次': 6666,
          }, {
            name: "设备6",
            '收入': 6666,
            '支出': 2900,
            '设备数量': 44,
            '设备价值': 8800,
            '服务人次': 222,
          }, {
            name: "设备7",
            '收入': 2222,
            '支出': 3333,
            '设备数量': 41,
            '设备价值': 8800,
            '服务人次': 28,
          }, {
            name: "设备8",
            '收入': 1111,
            '支出': 2222,
            '设备数量': 40,
            '设备价值': 8800,
            '服务人次': 333,
          }, {
            name: "设备9",
            '收入': 333,
            '支出': 1123,
            '设备数量': 30,
            '设备价值': 8800,
            '服务人次': 101,
          }, {
            name: "设备10",
            '收入': 1232,
            '支出': 2222,
            '设备数量': 35,
            '设备价值': 8800,
            '服务人次': 111,
          }],
        },

        chart3: {
          data: [],
          chart: null,
        }
        // list3: [],

      }
    },
    computed: {},
    created() {
      this.name2 = this.chart1.data[0].name
      // this.getqueryOverview()
      this.$nextTick(() => {
        this.renderChart1()
        this.renderChart3()
      })
    },
    methods: {
      random(lower, upper) {
        return Math.floor(Math.random() * (upper - lower)) + lower;
      },
      data3() {
        let _this = this

        _this.chart3.data = [{
          item: '维修',
          value: _this.random(0, 10),
        }, {
          item: '巡检',
          value: _this.random(0, 10),
        }, {
          item: '保养',
          value: _this.random(0, 10),

        }, {
          item: '校正',
          value: _this.random(0, 10),

        }, {
          item: '强检',
          value: _this.random(0, 10),

        }]
        var _DataSet = DataSet,
          DataView = _DataSet.DataView;

        var dv = new DataView().source(_this.chart3.data);
        dv.transform({
          type: 'fold',
          fields: ['value'], // 展开字段集
          key: 'user', // key字段
          value: 'score' // value字段
        });
        return dv
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
                    <div class="g2-tooltip-title">${title}</div>
                    <ul class="g2-tooltip-list">
                      <li class="g2-tooltip-li">设备数量：${_this.numberComma(data.设备数量)}</li>
                      <li class="g2-tooltip-li">设备价值：${_this.numberComma(data.设备价值)}万</li>
                      <li class="g2-tooltip-li">服务人次：${_this.numberComma(data.服务人次)}万</li>
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

          // onClick: ev => {
          //   const item = ev.item;
          //   const value = item.value;
          //   const checked = ev.checked;
          //   const geoms = chart.getAllGeoms();
          //   for (let i = 0; i < geoms.length; i++) {
          //     console.log('i:', i)
          //     const geom = geoms[i];
          //     console.log(geom.getYScale(), '///', value)
          //     if (geom.getYScale().field === value) {
          //       if (checked) {
          //         geom.show();
          //       } else {
          //         geom.hide();
          //       }
          //     }
          //   }
          // }
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
          _this.name2 = name
          _this.chart3.chart.changeData(_this.data3());
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
          padding: [getRem(.5), getRem(.2), 0, getRem(.2)]
        });
        _this.chart3.chart.source(_this.data3(), {
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
        // _this.chart3.chart.tooltip(false)
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
            right: .25rem;
            top: .5rem;
            display: flex;
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
          font-size: .5rem;
          font-weight: bold;
          position: absolute;
          left: .5rem;
          top: .5rem;
        }

        #chart3 {
          width: 60%;
          height: 100%;
        }

        .list3 {
          width: 40%;
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
      }
    }


    /deep/ .g2-tooltip {
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

