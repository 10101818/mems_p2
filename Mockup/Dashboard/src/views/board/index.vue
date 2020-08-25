<template>
  <div class="container">
    <div class="content">
      <div class="top">
        <div class="left box box1">
          <div class="top-list-box">
            <div class="item">
              <div class="value">{{numberComma(1133)}}</div>
              <div class="text">设备数量（台）</div>
            </div>
            <div class="item">
              <div class="value">{{numberComma(22314.34)}}</div>
              <div class="text">设备金额（万元）</div>
            </div>
            <div class="item">
              <div class="value">33.44%</div>
              <div class="text">折旧率</div>
            </div>
            <div class="item">
              <div class="value">{{numberComma(123)}}</div>
              <div class="text">当年服务人次(万人)</div>
            </div>
          </div>
          <div class="chart1-box">
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
                    同比去年
                  </div>
                </div>
              </div>
              <div class="list">
                <div class="total">
                  <div class="value">{{numberComma(16530.01)}}</div>
                  <div class="text">总支出（万元）</div>
                </div>
                <div class="status down">
                  <div class="value">
                    <span>23.45%</span>
                    <span class="iconfont icon-shang"></span>
                  </div>
                  <div class="text">
                    同比去年
                  </div>
                </div>
              </div>
            </div>
            <div id="chart1"></div>
          </div>
        </div>
        <div class="right box box2">
          <EventList></EventList>
        </div>
      </div>
      <div class="bottom">
        <div class="left box box3">
          <div id="chart3"></div>
          <div class="list-box-container">
            <div class="list-box3">
              <div class="list" v-for="(item,key) of list3" :key="key">
                <span class="index">{{key+1}}</span>
                <span class="name elip" :title="item.name">{{item.name}}</span>
                <span class="status" :class="{'err':item.status}">{{item.status?'待维修':'已完成'}}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="right box box4">
          <KpiList></KpiList>
        </div>
      </div>
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
        chart1: {
          data: [{
            name: "骨科",
            '收入': 800,
            '支出': 600,
            '设备数量': 40,
            '设备价值': 4800,
            '服务人次': 99,
          }, {
            name: "重症医学科",
            '收入': 400,
            '支出': 111,
            '设备数量': 30,
            '设备价值': 8800,
            '服务人次': 2334,
          }, {
            name: "血库",
            '收入': 330,
            '支出': 234,
            '设备数量': 5,
            '设备价值': 9800,
            '服务人次': 99,
          }, {
            name: "肿瘤消化肾病科",
            '收入': 444,
            '支出': 580,
            '设备数量': 47,
            '设备价值': 8800,
            '服务人次': 555,
          }, {
            name: "肾病综合内科",
            '收入': 999,
            '支出': 490,
            '设备数量': 5,
            '设备价值': 8800,
            '服务人次': 666,
          }, {
            name: "肝胆外科",
            '收入': 666,
            '支出': 290,
            '设备数量': 4,
            '设备价值': 8800,
            '服务人次': 222,
          }, {
            name: "神经内外科",
            '收入': 222,
            '支出': 333,
            '设备数量': 4,
            '设备价值': 8800,
            '服务人次': 28,
          }, {
            name: "消化呼吸科",
            '收入': 111,
            '支出': 222,
            '设备数量': 4,
            '设备价值': 8800,
            '服务人次': 333,
          }, {
            name: "泌尿五官科",
            '收入': 333,
            '支出': 112,
            '设备数量': 3,
            '设备价值': 8800,
            '服务人次': 101,
          }, {
            name: "新生儿科",
            '收入': 123,
            '支出': 82,
            '设备数量': 3,
            '设备价值': 8800,
            '服务人次': 111,
          }, {
            name: "放射科",
            '收入': 175,
            '支出': 111,
            '设备数量': 4,
            '设备价值': 8800,
            '服务人次': 69,
          }, {
            name: "手术室",
            '收入': 388,
            '支出': 345,
            '设备数量': 3,
            '设备价值': 8800,
            '服务人次': 23,
          }, {
            name: "妇产科",
            '收入': 356,
            '支出': 234,
            '设备数量': 4,
            '设备价值': 8800,
            '服务人次': 34,
          }],
        },

        chart3: {
          data: [{
            name: '骨科',
            count: 5,
            // list: Array(...Array(55)).map((n, i) => {
            //   return {name: '骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备骨科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
            ]
          }, {
            name: '呼吸科',
            count: 3,
            // list: Array(...Array(33)).map((n, i) => {
            //   return {name: '呼吸科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
            ]
          }, {
            name: '放射科',
            count: 4,
            // list: Array(...Array(44)).map((n, i) => {
            //   return {name: '放射科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
            ]
          }, {
            name: '手术科',
            count: 2,
            // list: Array(...Array(22)).map((n, i) => {
            //   return {name: '手术科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
            ]
          }, {
            name: '急诊科',
            count: 1,
            // list: Array(...Array(22)).map((n, i) => {
            //   return {name: '急诊科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
            ]
          }, {
            name: '血液科',
            count: 5,
            // list: Array(...Array(5)).map((n, i) => {
            //   return {name: '血液科设备', status: Math.random() > .5}
            // }),
            list: [
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: true},
              {name: '十二指肠内窥镜EW34-96	EW34-49	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '十二指肠内窥镜EW34-96	Philips 781-296', status: true},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
              {name: '电子上消化道内窥镜 EG-530WR	Philips 781-296', status: false},
              {name: '上呼吸道内窥镜EW34-49	Philips 781-296', status: false},
            ]
          }],
          interval: null,
          activeIndex: 0,
          timing: null,
        },
        list3: [],

      }
    },
    computed: {},
    created() {
      // this.getqueryOverview()
      this.$nextTick(() => {
        this.renderChart1()
        this.renderChart3()
      })
      this.autoSelectchart3()


    },
    methods: {
      getqueryOverview() {
        queryOverview().then(res => {
          console.log(res)
        })
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
            // 辅助线
            // chart.guide().line({
            //   top: true,
            //   start: [dataIndex - .25, -data['收入']],
            //   end: [dataIndex + .25, -data['收入']],
            //
            //   lineStyle: {
            //     // fill: 'red',
            //     stroke: '#f2637b', // 线的颜色
            //     lineDash: null, // 虚线的设置
            //     lineWidth: 1 // 线的宽度
            //   }, // 图形样式配置
            //
            // });

            // 辅助框
            chart.guide().regionFilter({
              top: true, // 指定 giude 是否绘制在 canvas 最上层，默认为 false, 即绘制在最下层
              start: [dataIndex - .25, -data['收入']], // 辅助框起始位置，值为原始数据值，支持 callback
              end: [dataIndex + .25, -data['支出']],// 辅助框结束位置，值为原始数据值，支持 callback
              color: '#E2340D',
              // style: {
              //   lineWidth: 0, // 辅助框的边框宽度
              //   fill: '#e60308', // 辅助框填充的颜色
              //   fillOpacity: 1, // 辅助框的背景透明度
              //   stroke: '#e60303' // 辅助框的边框颜色设置
              // } // 辅助框的图形样式属性
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
          offsetX: getRem(.5),
          offsetY: -getRem(.8),
          // marker: {fill: 'red'},
          textStyle: {
            // textAlign: 'center', // 文本对齐方向，可取值为： start middle end
            fill: '#000', // 文本的颜色
            fontSize: getRem(.4), // 文本大小
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
          const name = records[0]._origin.name
          _this.$router.push({
            path: '/radar',
            query: {
              name
            }
          })
        });


        chart.render();
      },
      renderChart3() {
        let _this = this
        let total = 0;
        this.chart3.data.forEach(n => {
          total += n.count
        })
        let chart = new G2.Chart({
          container: 'chart3',
          forceFit: true,
          padding: 0,
          height: document.querySelector('#chart3').clientHeight,
          // animate: false,
        });
        chart.source(this.chart3.data, {
          // 'count': {
          //   formatter: function formatter(val) {
          //     console.log(111, val)
          //     return val + 'aa';
          //   }
          // }
        });
        // 坐标轴
        chart.coord('theta', {
          radius: 0.75,
          innerRadius: 0.7
        });
        // 鼠标hover交互
        chart.tooltip({
          showTitle: false,
          'g2-tooltip': {
            'background-color': 'rgba(0, 0, 0, 0.7)',
            color: '#ddd',
          },
          itemTpl: '<li style="font-size: .4rem;">{name}<br/><br/><span style="font-size:.36rem;">参报数量：{value}</span></li>'
        });
        // 辅助文本
        chart.guide().html({
          position: ['50%', '50%'],
          html: `<div class="total-repair" style="font-size: .4rem;text-align: center;width: 10em;cursor: pointer;">
                  <span style="font-size:.8rem;font-weight: bold;">${total}</span>件
                  <div style="margin-top: .25rem">今日总报修</div>
                </div>`,
          alignX: 'middle',
          alignY: 'middle'
        });
        // 不显示图例
        chart.legend(false)
        this.chart3.interval = chart.intervalStack()
          .position('count')
          .style({
            cursor: 'pointer'
          }).color('name')
        chart.render();

        this.addEvent(true)


        // 默认选中
        this.chart3.interval.setSelected(this.chart3.data[this.chart3.activeIndex]);
        this.getchart3List(this.chart3.activeIndex)

        chart.on('interval:click', ev => {
          const data = ev.data;
          if (data) {
            let name = data._origin['name'];
            // 重新开始定时，防止刚点击一项就自动跳到下一项
            this.chart3.data.forEach((n, i) => {
              if (n.name === name) {
                this.chart3.activeIndex = i
                this.getchart3List(this.chart3.activeIndex)
                clearInterval(this.chart3.timing)
                this.autoSelectchart3()
              }
            })
          }
        })
      },
      autoSelectchart3() {
        this.chart3.timing = setInterval(() => {
          this.chart3.activeIndex++
          (this.chart3.activeIndex > this.chart3.data.length - 1) && (this.chart3.activeIndex = 0)
          this.chart3.interval.setSelected(this.chart3.data[this.chart3.activeIndex])
          this.getchart3List(this.chart3.activeIndex)
        }, 30000)
      },
      getchart3List(index) {
        // 通过下标获取list
        console.log(index)
        this.list3 = this.chart3.data[index].list
        // 滚动条回到顶
        document.querySelector('.list-box3').scrollTo(0, 0)
      },

      numberComma(source, length = 3) {
        source = String(source).split(".");
        source[0] = source[0].replace(new RegExp('(\\d)(?=(\\d{' + length + '})+$)', 'ig'), "$1,");
        return source.join(".");
      },
      clickEvent() {
        window.open('page/index-FujiManagerRepair.html', '_self')
      },
      addEvent(flag) {
        let ele = document.querySelector('.total-repair')
        if (!ele) return
        if (flag) {
          ele.addEventListener('click', this.clickEvent)
        } else {
          ele.document.querySelector('.total-repair').removeEventListener('click', this.clickEvent)
        }
      }
    },
    beforeDestroy() {
      this.addEvent(false)
    }
  }
</script>
<style scoped lang="less">
  .main-header{
    display: block;
  }
  .container {
    min-width: 1200px;
    width: 100%;
    height: 100%;
    background: #D7E0EE;
    overflow: hidden;
    font-size: .4rem;

    .content {
      padding: .3rem;
      width: 100%;
      height: 100%;
      /*height: calc(100% - 1.6rem);*/

      .top, .bottom {
        width: 100%;
        height: 55%;
        display: flex;

        .left {
          width: 55%;
        }

        .right {
          width: 45%;
        }

        .box {
          background: #fff;
          margin: .15rem;
          border-radius: .16rem;
        }

        .box1 {
          display: flex;
          flex-direction: column;
          background: transparent;

          .top-list-box {
            /*background: #D7E0EE;*/
            display: flex;
            padding-bottom: .3rem;

            .item {
              background: #fff;
              border-radius: .16rem;
              height: 2.6rem;
              flex: 1;
              margin-right: .3rem;
              padding: .5rem 0 .5rem .6rem;
              display: flex;
              flex-direction: column;
              justify-content: space-between;

              .value {
                color: #3D6EC0;
                font-size: .72rem;
                font-weight: bolder;
              }

              .text {
                font-size: .4rem;
              }

              &:last-of-type {
                margin-right: 0;
              }
            }
          }

          .chart1-box {
            background: #fff;
            /*flex: 1;*/
            padding: .5rem;
            position: relative;
            border-radius: .16rem;
            height: calc(100% - 2.9rem);

            .list-box1 {
              position: absolute;
              right: 0;
              padding-right: .8rem;
              left: 0;
              top: .5rem;
              display: flex;
              justify-content: flex-end;
              z-index: 2;

              .list {
                display: flex;
                align-items: baseline;
                margin-left: .85rem;

                .total {
                  margin-right: .6rem;

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

        .box2 {
          position: relative;


        }

        .box3 {
          display: flex;

          #chart3 {
            width: 40%;
            height: 100%;
          }

          .list-box-container {
            width: 60%;
            padding: .6rem 0 .6rem .4rem;
            /*flex: 1;*/

            .list-box3 {
              padding-right: .9rem;
              height: 100%;
              overflow-y: auto;

              .list {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: .4rem;

                &:last-of-type {
                  margin-bottom: 0;
                }

                .index {
                  font-size: .54rem;
                  color: #5a81c4;
                  margin-right: .35rem;
                }

                .name {
                  flex: 1;
                  margin-right: .4rem;
                  width: 0;
                }

                .status {
                  font-size: .36rem;
                  padding: .08rem .14rem;
                  border-radius: .08rem;
                  background: #5975AE;
                  color: #fff;

                  &.err {
                    background: #E2340D;
                  }
                }
              }
            }
          }

        }

        .box4 {
          padding: 0 .8rem;
        }
      }

      .bottom {
        height: 45%;
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

  }


</style>

