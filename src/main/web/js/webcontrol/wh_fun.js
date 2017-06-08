/**
 * Created by Administrator on 2017/5/27.
 */
define(['jquery'],function(){
   var tab=function(clickFather,addClass,controlDiv){//选项卡
       var $div=$("."+clickFather);//列：div>p
       var $controlDiv=$("."+controlDiv);//列：div>p

       $div.click(function(){//给divClass下的子集绑定事件
           var $index=$(this).index();
           $(this).addClass(addClass).siblings().removeClass(addClass);
           $controlDiv.eq($index).show().siblings().hide();
       })

   };

    return{
        tab: tab
    }
});