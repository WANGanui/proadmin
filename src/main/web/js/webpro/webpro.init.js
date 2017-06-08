/**
 * 项目配置文件文件
 */
require.config({
    urlArgs: 'v='+(new Date()).getTime(),
    baseUrl: "/js",
    paths: {
        //三方插件
        async: 'webpro/lib/require/async',
        "mock":"mock-min",

        //配置
        "webpro.config":"webpro/webpro.config",
        "webpro.init":"webpro/webpro.init",
        "webpro":"webpro/webpro",

        //视图模块
        "webpro.index": 'webpro/view/webpro.index',
        "webpro.view": "webpro/view/webpro.view",
        "webpro.dialog": "webpro/view/webpro.dialog",
        "webpro.grid": "webpro/view/webpro.grid",
        "webpro.mapgrid": "webpro/view/webpro.mapgrid",

        //组件
        "wx.utils":"webpro/wechar/wx.utils",
        "observer":"webpro/event/observer",

        //控件
        "SingleUpload":"webpro/controls/SingleUpload",
        "DicControls":"webpro/controls/DicControls",
        "MapControls":"webpro/controls/MapControls",
        "TextAreaControls":"webpro/controls/TextAreaControls",
        "DateControls":"webpro/controls/DateControls",
        "CommonControls":"webpro/controls/CommonControls",
        "GridControls":"webpro/controls/GridControls",

        //框架组件
        "logger":"webpro/lib/utils/logger",
        "upload":"webpro/lib/utils/upload",

        //三方包文件
        "jquery":"jquery-2.1.4",
        "doT":"doT",
        "wangEditor":"wangEditor",
        "bootstrap":"bootstrap",
        "calendar":"lyz.calendar.min",
        "jqueryValidate":"jquery.validate",
        "jqueryEasyui":"jquery.easyui.min",
        "jqueryEasyuiCN":"easy.ui.1.5/easyui-lang-zh_CN",
        'BMap': ['http://api.map.baidu.com/api?v=2.0&ak=mXijumfojHnAaN2VxpBGoqHM'],
        "weixin":"http://res.wx.qq.com/open/js/jweixin-1.0.0",
        "lrz":"lrz/lrz.all.bundle"
    },
    shim: {
        "doT": {
            deps: [],
            exports: "doT"
        },
        "wangEditor": {
            deps: [],
            exports: "wangEditor"
        },
        "calendar":{
            deps: ['jquery'],
            exports: "calendar"
        },
        "jqueryEasyui":{
            deps: ['jquery'],
            exports: "jqueryEasyui"
        },
        "webpro.mapgrid":{
            deps:["css!../../../../css/webpro.mapgrid.css"],
            exports:"webpro.mapgrid"
        },
        "jqueryEasyuiCN":{
            deps: ["jquery"],
            exports: "jqueryEasyuiCN"
        },
        "BMap":{
            deps:[
                'jquery'
            ],
            exports:"BMap",
        },
        "lrz":{
            deps:[],
            exports:"lrz"
        },
        jqueryValidate:{
            deps:[],
            exports:"jqueryValidate"
        },
        bootstrap:{
            deps:['jquery'],
            exports:"bootstrap"
        },
        weixin:{
            deps:[],
            exports:"weixin"
        }
    },
    map: {
        '*': {
            'css': '/js/webpro/lib/require-css/css.js'
        }
    }
});
