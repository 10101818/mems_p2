## 环境搭建

1.安装nodejs
nodejs下载地址：http://nodejs.cn/
2.（可选）安装vue-cli工具
命令行输入：npm install vue-cli -g
3.安装git工具
git下载地址：https://git-scm.com/
4.git clone项目
项目地址：https://github.com/zhangxiao22/board
5.安装依赖
cd到项目目录中，命令行输入：npm install
6.启动项目
命令行输入：npm run dev
7.打包项目
命令行输入：npm run build，打包文件在项目/dist文件夹中

## 项目结构

项目主要内容在3个目录当中：
/src 主要的页面目录
/config 开发及部署环境变量设置
/build 项目打包相关设置

# /src

/src目录下共有6个子目录：
* api：请求后端接口的文件所在目录，其中api.js是封装的方法，http.js是采用axios构建http请求
* common：常量设置，包括api接口与字体大小分辨率
* components：vue组件所在位置，目前只有eventlist跟kpi两个组件
* css：基础样式目录
* router：路由目录，定义项目主要路由
* views：主要的页面文件所在目录

# /config

/config目录下共有3个文件
* index.js：vue基础设置，包括前端代理等
* dev.env.js 开发环境变量设置，继承自index.js
* prod.env.js 正式环境变量设置,继承自index.js
  
# /build
/build目录由vue-cli生成项目时自动生成，主要用来控制webpack打包项目相关内容，具体可参考：
https://www.webpackjs.com/concepts/

## vue简介

Vue是一套用于构建用户界面的渐进式框架。与其它大型框架不同的是，Vue 被设计为可以自底向上逐层应用。Vue 的核心库只关注视图层，不仅易于上手，还便于与第三方库或既有项目整合。另一方面，当与现代化的工具链以及各种支持类库结合使用时，Vue 也完全能够为复杂的单页应用提供驱动。
vue既可以直接引入到html当中使用，也可以采用vue-cli工具构建一个包含完整vue功能的前端项目。使用vue-cli构建项目时，需要对nodejs有一定的了解。nodejs是基于Google v8引擎的服务端js运行时，详情可参考：
https://nodejs.cn

# vue-cli

Vue CLI 是一个基于 Vue.js 进行快速开发的完整系统，提供：

通过 @vue/cli 搭建交互式的项目脚手架。
通过 @vue/cli + @vue/cli-service-global 快速开始零配置原型开发。
一个运行时依赖 (@vue/cli-service)，该依赖：
* 可升级；
* 基于 webpack 构建，并带有合理的默认配置；
* 可以通过项目内的配置文件进行配置；
* 可以通过插件进行扩展。
* 一个丰富的官方插件集合，集成了前端生态中最好的工具。
* 一套完全图形化的创建和管理 Vue.js 项目的用户界面。
Vue CLI 致力于将 Vue 生态中的工具基础标准化。它确保了各种构建工具能够基于智能的默认配置即可平稳衔接，这样你可以专注在撰写应用上，而不必花好几天去纠结配置的问题。与此同时，它也为每个工具提供了调整配置的灵活性，无需 eject。

## 图表工具阿里g2

项目中图表均是采用阿里G2库绘制。G2 是一套基于可视化编码的图形语法，以数据驱动，具有高度的易用性和扩展性，用户无需关注各种繁琐的实现细节，一条语句即可构建出各种各样的可交互的统计图表。

G2既可以直接作为静态资源引入进html，也可以使用npm包管理器进行安装，通过import在项目当中使用。有关g2的具体文档可参考：
https://www.yuque.com/antv/g2-docs/get-started
