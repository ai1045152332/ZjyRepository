<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="com.honghe.recordweb.action.SessionManager" %>
<%@ page import="com.honghe.recordweb.service.frontend.user.Authority" %>
<%@ page import="com.honghe.recordhibernate.dao.PagerSimple" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: lch
  Date: 2014/10/11
  Time: 15:43
  To change this template use File | Settings | File Templates.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="${pageContext.request.contextPath}/css/frontend/record/index.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/frontend/record/main.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/frontend/record/hpager.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common/jquery-1.7.2.min.js"></script>
<script src="${pageContext.request.contextPath}/js/common/jquery.cookie.js" type="text/javascript"></script>
<body class="bg707681">
<style>
	   #linkpage {
        bottom:15px;
        float: none;
        position: absolute;
        left: 55%;
    }

    .pages {
        float: none;
        height: 25px;
        margin-left: 0px;
        min-width: 0px;
    }
    .bgr,.bgred{
    	margin-top: 4px;
		margin-left: 15px;
		margin-right: 5px;
		
    }
    .bgr {
	    background: url(${pageContext.request.contextPath}/image/record/radio_xk.png) 0px -1px no-repeat;
	    height:17px;
	    width:17px;
    }
     .bgred{
	    background: url(${pageContext.request.contextPath}/image/record/radio_xk.png) 0px -36px no-repeat;
	    height:17px;
	    width:17px;
    }
    .xk_video_group{
    	text-indent: 0;
    }
    .xk_video_twofourobj {
        background: none repeat scroll 0 0 #535e71;
        height: 100%;
        width: 50%;
    }
       #xk_video_camera_4{
           right:10%;
       }
</style>
    <%
        String viewClassCameraName = request.getAttribute("viewClassCameraName").toString().trim();
        Map<String,Object> hostingroup = (Map<String,Object>)request.getAttribute("hostingroup");

        List<Map> hostList = null;

        if (hostingroup!=null && hostingroup.size()!=0) {
            hostList = (List<Map>) hostingroup.get("hostInfo");
        }
        int i = 0;
        String host_count = null;
        if (hostingroup.containsKey("pageCount")) {
            host_count = hostingroup.get("pageCount").toString();
        }
        int hostcount = 0;
        if (host_count != null) {
            hostcount = Integer.parseInt(host_count);
        }
        int hostListSize = 0;
        if (hostList!=null && !hostList.isEmpty()) {
            hostListSize = hostList.size();
            for (Map host : hostList) {
                String host_id = host.get("id").toString();
                String host_name = host.get("name").toString();
                String host_type = host.get("type").toString();
                String hostip = host.get("host_ip").toString();
                //String[] vedio_url = (String[])host.get("video_url");
                String status = host.get("status").toString();
                //String isRecord = host.get("isRecord").toString();
                String recordType = host.get("host_desc").toString();//0为简易，1为精品
                String dspecid = host.get("dspecid").toString();
                String onclick = "";
                String oncamera = "";
                //host_type为1时为NVR 其它不能导播，现屏掉为了调试导播
                //if (host_type.equals("1") && status.equals("Online") && userroleMap.containsKey(Authority.Anthority_Use_Director.name())) //如果是NVR且有导播权限则可以导播
                if (status.equals("Online")) //如果是NVR且有导播权限则可以导播
                {
                    onclick = "directorView('" + host_id + "','" + hostip + "','" + host_name + "','" + recordType +"')";
                    oncamera = "directorCamera('"+host_id+"')";
                }

                if (i % 2 == 0) {
        %>

        <%
            }
        %>

        <!--<td width="50%"> -->
        <div class="allarea" style="width:50%;float: left;position: relative;">
            <!--进入导播按钮-->
            <%if(host_type.equals("1")){
            %>
                 <%
                  if(!"17".equals(dspecid)){//虚拟主机没有导播界面
                 %>
                <a href="javascript:void(0)" title="进入导播" ><span class="xk_video_camera" onclick="<%=onclick%>"></span></a>
                      <%
                  }
                %>
                <a href="javascript:void(0)" title="进入监看画面" ><span class="xk_split_camera" id="xk_video_camera_4" onclick="<%=oncamera%>"></span></a>
            <%
            }%>
            <div class="xk_video"
                 style="margin-top: 12px;position: absolute;left: 0;right: 0;top: 0;bottom: 0;margin: auto;"
                 bingo="none" id="<%=host_id%>" ip="<%=hostip%>">
                <input id="host_status_<%=host_id%>" type="hidden" value="<%=status%>-false-false" hostType="<%=host_type%>" recordType="<%=recordType%>" dspecid="<%=dspecid%>"/>
                <input id="status_<%=host_id%>" type="hidden" value="<%=status%>_<%=host_id%>_<%=hostip%>" class="hoststatus"/>
                <a href="javascript:void(0)" style="cursor: default;">

                    <%--<img class="xk_video_normalpic" src="/image/frontend/video.png"/>--%>
                    <!--<div class="xk_video_selected_bz" style="display:none"></div>-->
                    <div id="object_<%=host_id%>" class="xk_video_twofour">
                    	
                   
                        <%
                            //String camera_str = URIEncoderDecoder.decode(viewClassCameraName);
                            String camera_str = URLDecoder.decode(URLDecoder.decode(viewClassCameraName, "UTF-8"), "UTF-8");
                            if(camera_str.equals("教师学生")){
                        %>
                        <div class="xk_video_twofourobj" style="float: left;">
                    		<div class="fourfour" ><div class="fourfourimg"><div class="fourfourimgicon"></div></div></div>
                    	</div>
                    	<div class="xk_video_twofourobj" style="float: right;">
                    		<div class="fourfour" ><div class="fourfourimg"><div class="fourfourimgicon"></div></div></div>
                    	</div>
                        <%
                        }else{
                        %>
                        <div class="twofour" ><div class="fourfourimg"><div class="fourfourimgicon"></div></div></div>
                        <%
                            }
                        %>
                    </div>

                    <div class="xk_video_text" style="height: 25px;">
                    	<div class="xk_video_group_error" id="nas_no_<%=host_id%>"></div>
                        <span class="xk_video_group">
                            <div class="bgr"  id="bz_<%=host_id%>"></div><div title="<%=host_name%>" class="bgr_styl"><%= host_name%></div>
                            <%
                                //if(isRecord.equals("true")){
                            %>
                                    <div id="record_<%=host_id%>" class="xk_circlerecord" style="display:none">录制中</div>
                            <%
                                //}else{
                            %>
                                    <div id="recordstop_<%=host_id%>" class="xk_circlestop">未录制</div>
                            <%
                                //}
                            %>
                            <!--xk_circlerecordxk_circlestopxk_circledone-->
                            <span style="float:right;color:red">
                                <%
                                    /*if (vedio_url.equals("@_@")) {
                                        out.println("镜头未配置");
                                    }*/
                                %>
                            </span>

                            <span id="message_<%=host_id%>" class="xk_video_group_warn"></span>
                            
                        </span>
                        
                    </div>
                </a>
            </div>
        </div>
        <!--</td>-->
        <%
                i++;
            }
        %>
    <div class="pages">
        <link href="${pageContext.request.contextPath}/css/frontend/hpager.css" rel="stylesheet"
              type="text/css"/>
        <%
            Integer currentpage = Integer.parseInt(request.getParameter("currentPage"));
            PagerSimple pager = new PagerSimple(hostcount, currentpage, "<span class='pages_prevpage'></span>", "<span class='pages_nextpage'></span>", "", "", true);
            // Pager pager = new Pager(hostcount,currentpage);
            String pagers = pager.run();

        %>
        <div id="linkpage">
            <%=pagers%>
        </div>
    </div>
    <%
        }
    %>
</table>

</body>
<script>




function addicon(){
     	//判断左侧树的状态是否离线，离线，隐藏iframe中离线状态object节点添加图片
		var treetitlelen=parent.$(".tree_title").length;
		var html="<div class=\"fourfourimg\"><div class=\"fourfourimgicon\"></div></div>";
		var htmltwo="<div class=\"twoimg\"><div class=\"fourfourimgicon\"></div></div>";
		var sethtml="<div class=\"xk_video_twofour\"><div class=\"xk_video_twofourobj\" style=\"float: left;\"></div><div class=\"xk_video_twofourobj\" style=\"float: left;\"></div></div>";
		var sethtmltwofour="<div class=\"twofour\"></div>";
		for(i=0;i<treetitlelen;i++){
			var treecontenta=parent.$(".tree_title").eq(i).children(".tree_content").children(".tree_contenta")
			if(parent.$(".tree_title").eq(i).children(".tree_content").css("display")=="block"){
					for(j=0;j<treecontenta.length;j++){
						var offline=treecontenta.eq(j).children("span").eq(0).attr("class")
						if(offline=="tree_content_nousebg"){
							$(".allarea").eq(j).find(".twofour").hide();
							$(".allarea").eq(j).find(".xk_video_twofourobj").find(".fourfour").hide();
							if(parent.$(".xk_stage").children("div").eq(0).css("display")=="block"){
								$(".allarea").eq(j).find(".xk_video_text").prev().html("")
								$(".allarea").eq(j).find(".xk_video_text").prev().html(sethtml)
								$(".allarea").eq(j).find(".xk_video_twofourobj").html(html)
								//alert($(".allarea").eq(j).find(".xk_video_twofourobj").html())
							}else{
								$(".allarea").eq(j).find(".xk_video_text").prev().html("")
								$(".allarea").eq(j).find(".xk_video_text").prev().html(sethtmltwofour)
								$(".allarea").eq(j).find(".twofour").before(htmltwo)
							}

						}
					}

			}
			
		} 
     }
       function seticonval(){
			//JS判断访问设备(userAgent)加载不同页面。代码如下：
     	var sUserAgent = navigator.userAgent;
        var isWin = (navigator.platform === "Win32") || (navigator.platform === "Windows");
    	//非全屏状态下效果
    	var iframewidth=parent.$(".iframe").width();
    	var halfwidth=iframewidth/2;
//  	if (isWin) {
//          var isWin8 = sUserAgent.indexOf("Windows NT 6.3") > -1 || sUserAgent.indexOf("Windows 8") > -1;
//          if (isWin8){
//          	var halfwidth=iframewidth/2;
//          }
//      }
    	var iframeheight=parent.$(".iframe").height();
    	//iframe去除分页和文本框后的高度
    	var halfheight=iframeheight*0.93/2-25-10;
    	//计算16/9的比例
    	var heicompare=halfwidth*9/16;
    	if(heicompare>halfheight){
    		//如果宽度的比例值高度大于iframe可用区域高度，则把高度默认为halfheight
    		var widcompare=halfheight*16/9;
    		//alert(widcompare+"--"+halfwidth)
    		if(widcompare<halfwidth){
    			var marginleft=(halfwidth-widcompare)/3;
    			//alert((iframeheight*0.90/2-25-30)+"---"+(halfheight+25))

    			$(".allarea,.xk_video").height(halfheight+25);
    			$(".allarea,.xk_video,.xk_video_text,.xk_video_twofour").width(widcompare);
    			$(".allarea").css({"margin-left":marginleft*2+"px","margin-top":"5px"})
    			$(".twofour").attr("height",halfheight);
        	$(".twoimg").css("height",halfheight+"px");
        	$(".xk_video_twofour,.xk_video_twofourobj").height(halfheight);
        	//教师学生全景模式
        	$(".xk_video_twofourobj").width(widcompare/2-0.01);
      		var twofourobjheight=$(".xk_video_twofourobj").height();
        	var twofourobjwidth=$(".xk_video_twofourobj").width();
        	var twofoursixtweenwidth=twofourobjheight*16/9;
        	if(twofoursixtweenwidth>twofourobjwidth){
        		var twofourxkvideoheight= twofourobjwidth*9/16;
        		//alert(twofourxkvideoheight+"---"+twofoursixtweenwidth)
        		var twofourmargintop=(twofourobjheight-twofourxkvideoheight)/2;
        		$(".fourfourimg").css("height",twofourxkvideoheight+"px");
        		$(".fourfourimg").css("margin-top",twofourmargintop+"px");
			    	$(".fourfour").css("height",twofourxkvideoheight+"px");
        		$(".fourfour").css("width","100%")
        		$(".fourfour").css("background","#535e7")
        		$(".fourfour").css("margin-top",twofourmargintop+"px")

        	}
    		}else{
    			//alert("从新计算")
    		}
    	}else{
    		//如果宽度的比例值高度小于iframe可用区域高度，则把宽度默认为计算值heicompare
    		$(".allarea,.xk_video").height(heicompare+25);
    		$(".allarea,.xk_video,.xk_video_text,.xk_video_twofour").width(halfwidth-10);
    		$(".allarea").css({"margin-top":"5px","margin-left":"5px"})
    		$(".twofour").attr("height",heicompare);
    	  $(".twoimg").css("height",heicompare+"px");
    	  $(".xk_video_twofour,.xk_video_twofourobj").height(heicompare);
    		//教师学生全景模式
    	  $(".xk_video_twofourobj").width((halfwidth-10)/2);
  		  var twofourobjheight=$(".xk_video_twofourobj").height();
    	  var twofourobjwidth=$(".xk_video_twofourobj").width();
    	  var twofoursixtweenwidth=twofourobjheight*16/9;
    	  if(twofoursixtweenwidth>twofourobjwidth){
	    		var twofourxkvideoheight= twofourobjwidth*9/16;
	    		//alert(twofourxkvideoheight+"---"+twofoursixtweenwidth)
	    		var twofourmargintop=(twofourobjheight-twofourxkvideoheight)/2;
	    		$(".fourfourimg").css("height",twofourxkvideoheight+"px");
	    		$(".fourfourimg").css("margin-top",twofourmargintop+"px");
			    	$(".fourfour").css("height",twofourxkvideoheight+"px");
	    		$(".fourfour").css("width","100%")
	    		$(".fourfour").css("background","#535e7")
	    		$(".fourfour").css("margin-top",twofourmargintop+"px")
	    	}
    	}
		}
 /**
* 获取url地址中的参数
*/
function urloption(url){
		var totalpagesize = "<%=hostcount%>";
		if(url.indexOf("?")!=-1){
		var p=url.indexOf("?"); //返回所在位置
		var host="http://"+window.location.host+url.substr(0,p+1);
		var str = url.substr(p+1) //从这个位置开始截取
		strs = str.split("&"); //拆分
		var jumpval=$("#jump").val();
            var patrn = /^[0-9]*$/;
		if(!patrn.exec(jumpval)|| jumpval<=0){
			jumpval=1;
		}else if(parseInt(jumpval)>=parseInt(totalpagesize)){
			jumpval=totalpagesize
		}
		var newurl=host;
		for(var i=0;i<strs.length;i++){
			if(i==0){
				newurl+=strs[i].split("=")[0]+"="+jumpval+"&";
			}else{
				newurl+=strs[i].split("=")[0]+"="+unescape(strs[i].split("=")[1])+"&";

			}
		}
		var urllen=newurl.length-1;
		var newurl = newurl.substr(0,urllen) //从这个位置开始截取
		location.href=newurl;
	}
}
  	$(function(){

        //  		parent.changepage()
        var totalpagesize = "<%=hostcount%>";
//        $("#linkpage").append("<ul class=\"yiiPager1\" id=\"yiiPager1\" style=\"display:none\"></ul>")
//       if($.cookie("selectauto")==1)
//       {
//           $("#yiiPager1").show();
//           if($("#nowpage").text()!="")
//           {
//               $("#yiiPager1").html("当前是第<span id=nowpage>"+$("#nowpage").text()+"</span>页")
//           }
//           else
//           {
//               $("#yiiPager1").html("当前是第<span id=nowpage>1</span>页")
//           }
//
//       }
        //分页调整
        var page=totalpagesize;
        if(page<=1){
            parent.$(".check_head_label").hide()
        }else{
            parent.$(".check_head_label").show()
        }
        var html="<span  id=\'pagerSpan\'  style='float: left;margin-left: 2px;color: #fff;'>&nbsp;&nbsp;共"+page+"页 &nbsp;&nbsp;跳转到 "+"<input id=\"jump\" type=text style=\"width:24px;background:#d7dade;border:1px solid #5e6470\" title=\"点击回车即可跳转分页\" onkeyup=\"this.value=this.value.replace(/[^0-9]/g,'')\" onafterpaste=\"this.value=this.value.replace(/[^0-9]/g,'')\"/> 页<span>";
        $("#linkpage").append(html)
        left=-(18)*28/2+"px";
        $("#linkpage").css({"margin-left":left,"width":(17)*28+"px"});
        $('#jump').bind('keypress',function(event){
            if(event.keyCode == 13)
            {
                var jumpval=$("#jump").val();
                var patrn = /^[0-9]*$/;
                if(!patrn.exec(jumpval)|| jumpval<=0 )
                {
                    return false;
                }
                else{
                    if(parseInt(jumpval)>parseInt(page)){
                        jumpval=page;
                    }
                    parent.jumpPage(jumpval);
                }
            }
        });
//    $(document).keydown(function(event){
//	//判断当event.keyCode 为37时（即左方面键），执行函数to_left();
//	//判断当event.keyCode 为39时（即右方面键），执行函数to_right();
//	   if(event.ctrlKey || event.which == 13){
//	   	//alert("aaa")
//		var jumpval=$("#jump").val();
//        if(jumpval==""||jumpval==null){
//	        return false;
//	        }else{
//	        	var lilen=$("#linkpage ul li").length-1;
//	        	var prevhref=$("#linkpage ul li").eq(0).find("a").attr("href");
//	        	var nexthref=$("#linkpage ul li").eq(lilen).find("a").attr("href");
//	        	var thisurl="";
//	        	if(prevhref==""&&nexthref==""){
//	        		return false;
//	        	}else if(prevhref==""||prevhref==undefined){
//	        		thisurl=nexthref;
//	        		urloption(thisurl)
//	        	}else if(nexthref==""||nexthref==undefined){
//	        		thisurl=prevhref;
//	        		urloption(thisurl)
//	        	}else{
//	        		thisurl=nexthref;
//					urloption(thisurl)
//	        	}
//	        }
//		}
//	})
})
    function directorView(hostid, token,hostname,recordType) {
        hostname = encodeURI(hostname);
        if(recordType == "1"){
            $.post("${pageContext.request.contextPath}/viewclass/Viewclass_gotoDirectView.do", {token: token}, function (data) {
            }, 'json');
        }
        parent.location.href = "${pageContext.request.contextPath}/viewclass/Viewclass_directorView.do?hostid=" + hostid
                + "&token=" + token + "&hostname=" + hostname + "&recordType=" + recordType
                + "&currentPage=" + parent.nowselectpage;
    }
   function directorCamera(hostid){
       window.parent.location = "${pageContext.request.contextPath}/viewclass/Viewclass_splitscreen.do?hostid=" + hostid+ "&currentPage=" + parent.nowselectpage;
   }

    $(function () {
    	//addicon();
    	seticonval()
    var hostSize = "<%=hostListSize%>";
     hostSize = parseInt(hostSize);
     var viewClassCameraName = "<%=viewClassCameraName%>";
     //alert(decodeURI(viewClassCameraName));
     var hostid = "";
     var hostip = "";
     if(hostSize != 0){
         for(var i =0;i<hostSize;i++){
             var hostStatus = $(".allarea").eq(i).find(".hoststatus").val();
             //alert(hostStatus);
             var hostarr = hostStatus.split("_");
             //alert(hostarr[0])
             if(hostarr[0]=="Online"){
              	hostid += hostarr[1]+",";
             	hostip += hostarr[2]+",";
              }
         }
         if(hostid != "" && hostip !=""){
             $.post("${pageContext.request.contextPath}/viewclass/Viewclass_getRecordingStatus.do",
                     {viewClassCameraName:viewClassCameraName,hostid:hostid,hostIp:hostip},
                     function(data){
                         for(var j=0;j<data.length;j++){
                             var hostidstr = data[j].id;
                             var hoststatus = data[j].status;
                             if(hoststatus == "true"){
                                 //alert(hostidstr);
                                 if(data[j].workingMode =='workingModeLiveCasting'){
                                     $("#record_"+hostidstr).html("直播中");
                                     $("#host_status_"+hostidstr).val("Online-false-true");
                                 }
                                 else if(data[j].workingMode =='workingModeRecording'){
                                     $("#record_"+hostidstr).html("录制中");
                                     $("#host_status_"+hostidstr).val("Online-true-false");
                                 }
                                 else if(data[j].workingMode =='workingModeRecordingAndLivecast'){
                                     $("#record_"+hostidstr).html("录+直");
                                     $("#host_status_"+hostidstr).val("Online-true-false");
                                 }
                                 $("#record_"+hostidstr).show();
                                 $("#recordstop_"+hostidstr).hide();
                             }
                         }
                     },'json');

             $.post("${pageContext.request.contextPath}/viewclass/Viewclass_getCameraUrl.do",
                     {viewClassCameraName:viewClassCameraName,hostid:hostid,hostIp:hostip},
                     function(data){
                         for(var k=0;k<data.length;k++) {
                             var objectid = data[k].id;

                             var urlarr = data[k].video_url_arr;
                             if (urlarr.length > 1) {
                                 try {
                                     if(urlarr[0] != "")
                                     {
                                         var obj_str = "";
                                         obj_str = '<object id="object_0_'+objectid + '"   CLASSID="CLSID:3a22176d-118f-4185-9653-cdea558a6df8" name="ScriptableObject"   WIDTH=100% HEIGHT=100%></object>';
                                         $("#object_"+objectid).children(".xk_video_twofourobj").eq(0).children("div").html(obj_str);
                                         var objid = document.getElementById("object_0_" + objectid);
//                                         alert(objectid+"-------"+objid)
                                         objid.play(urlarr[0]);
                                     }
                                     if(urlarr[1] != "")
                                     {
                                         var obj_str1 = "";
                                         obj_str1 = '<object id="object_1_'+objectid + '"  CLASSID="CLSID:3a22176d-118f-4185-9653-cdea558a6df8" name="ScriptableObject"  WIDTH=100% HEIGHT=100%></object>';
                                         $("#object_"+objectid).children(".xk_video_twofourobj").eq(1).children("div").html(obj_str1);
                                         var objid_sub = document.getElementById("object_1_" + objectid);
                                         objid_sub.play(urlarr[1]);
                                     }
                                 } catch (e) {

                                 }
                             } else {
                                 try {
                                     if(urlarr[0] != "")
                                     {
                                         var obj_str = "";
                                         obj_str += '<object id="object_0_' + objectid + '"  CLASSID="CLSID:3a22176d-118f-4185-9653-cdea558a6df8" name="ScriptableObject" url="' + urlarr[0] + '" WIDTH=100% HEIGHT=100%></object>';
                                         $("#object_" + objectid).html(obj_str);
                                         var objid = document.getElementById("object_0_" + objectid);
                                         objid.play(urlarr[0]);
                                     }
                                 } catch (e) {
                                 }
                             }
                         }
                        },'json');
         }
     }
        $(".selectiframe").contents().find("body").css("background", "transparent")
        $(document.body).find("input[type=checkbox]").prop("checked", false).css("display", "none");
        $(".check_head label").click(function () {
            var flag = $("#select_auto").prop("checked");
            if (flag == true) {
                $(".bged").addClass("bg").removeClass("bged");
                clear();
            } else {
                $(".bg").addClass("bged").removeClass("bg");
                start_timer();
            }
        });
        //选择教室(主机)
        $(".xk_video").live('click', function () {
            if ($(this).attr("bingo") == "none") {
                //单选，先初始化所有的元素为未选中状态
                $(".xk_video_selected").attr("class", "xk_video");
                $(".xk_video").attr("bingo", "none");
                $(".xk_video,.xk_video_selected").css("box-shadow","none")
                $(".xk_video_selected").removeClass("xk_video_selected");
                $(".bgr,.bgred").addClass("bgr").removeClass("bgred");

                $(this).attr("class", "xk_video_selected");
                $(this).css("box-shadow","0 0 0 3px #28b779")
                $(this).find(".bgr").addClass("bgred").removeClass("bgr");
                $(this).attr("bingo", "done");
                parent.$("#classmessage").html("");
                var hostid = $(this).attr("id");
                var hostip = $(this).attr("ip");
                //选中后根据样式判断上方按钮是否可用
                var host_status = $("#host_status_" + hostid).val();
                var arr = host_status.split("-");
                var status = arr[0];
                var isRecord = arr[1];
                var isLive = arr[2];
                var recordType = $("#host_status_" + hostid).attr("recordType");
                var hostType = $("#host_status_" + hostid).attr("hostType");
                var dspecid = $("#host_status_" + hostid).attr("dspecid");
//               alert(dspecid)
                //alert("12")
                if(hostType == "1"){//NVR
                    if (status == "Online" && isRecord == "true") {
                        //parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                        //parent.$("#turnon").attr("onclick","");//开机时，点击开机按钮不可用
                        if(recordType==0)//简易
                        {
                            if(dspecid == 11 || dspecid == 17){//TBOX设备不支持开关机，开关机按钮都不可用.虚拟主机不支持开关机
                                parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机按钮不可用。
                                parent.$("#turnon").attr("onclick","");
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//关机按钮不可用
                                 parent.$("#turnoff").attr("onclick","");
                            }else{
                                parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                                parent.$("#turnon").attr("onclick","");//开机时，点击开机按钮不可用
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon_disable").addClass("xk_options_closeicon");//开机时，关机按钮可用
                                parent.$("#turnoff").attr("onclick","shutdown()");
                            }
                        }
                        else//精品
                        {
                            parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnon").attr("onclick","");//开机时，点击开机按钮不可用
                            parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnoff").attr("onclick","");//开机时，点击开机按钮不可用
                            //parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，关机按钮可用
                            //parent.$("#turnoff").attr("onclick","");
                        }
                        if(dspecid == 17){//虚拟主机不支持录制
                            parent.$("#record_vedio").attr("onclick", "");//开始录制按钮不可用
                            parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                            parent.$("#stop_record_vedio").attr("onclick", "");////停止录制按钮不可用
                            parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                        }else{
                            parent.$("#stop_record_vedio").attr("onclick", "stoprecord()");//正在录制时，停止录制按钮可用
                            parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon_disable").addClass("xk_options_stoprecordingicon");
                            parent.$("#record_vedio").attr("onclick", "");//正在录制时，开始录制按钮不可用
                            parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable")
                        }

                    } else if (status == "Online" && isRecord != "true") {

                        if(recordType==0)
                        {
                            if(dspecid == 11 || dspecid == 17){//TBOX设备不支持开关机，开关机按钮都不可用.虚拟主机不可用
                                parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机按钮不可用。
                                parent.$("#turnon").attr("onclick","");
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//关机按钮不可用
                                parent.$("#turnoff").attr("onclick","");
                            }else {
                                parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                                parent.$("#turnon").attr("onclick", "");//开机时，点击开机按钮不可用
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon_disable").addClass("xk_options_closeicon");//开机时，关机按钮可用
                                parent.$("#turnoff").attr("onclick", "shutdown()");
                            }
                        }
                        else
                        {
                            parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnon").attr("onclick","");//开机时，点击开机按钮不可用
                            parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnoff").attr("onclick","");
                           // parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，关机按钮可用
                           // parent.$("#turnoff").attr("onclick","");
                        }
                        if(dspecid != 17){
                            if(isLive != "true")
                            {//未直播，开始录制按钮可用
                                parent.$("#record_vedio").attr("onclick", "recording()");
                                parent.$("#record_vedio_img").removeClass("xk_options_recordingicon_disable").addClass("xk_options_recordingicon");
                                parent.$("#stop_record_vedio").attr("onclick", "");
                                parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                            }
                            else
                            {//直播中，开始录制、停止录制按钮不可用
                                parent.$("#record_vedio").attr("onclick", "");//关机时开始录制按钮不可用
                                parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                                parent.$("#stop_record_vedio").attr("onclick", "");////关机时停止录制按钮不可用
                                parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                            }
                        }else{
                            parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机按钮不可用。
                            parent.$("#turnon").attr("onclick","");
                            parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//关机按钮不可用
                            parent.$("#turnoff").attr("onclick","");
                            parent.$("#record_vedio").attr("onclick", "");//开始录制按钮不可用
                            parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                            parent.$("#stop_record_vedio").attr("onclick", "");////停止录制按钮不可用
                            parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                        }

//                        parent.$("#record_vedio").attr("onclick", "recording()");
//                        parent.$("#record_vedio_img").removeClass("xk_options_recordingicon_disable").addClass("xk_options_recordingicon");
//                        parent.$("#stop_record_vedio").attr("onclick", "");
//                        parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                    } else{//if(status == "Offline") 关机状态
                        if(recordType==0)
                        {
                            if(dspecid == 11 || dspecid ==17){//TBOX设备不支持开关机，开关机按钮都不可用
                                parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机按钮不可用。
                                parent.$("#turnon").attr("onclick","");
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//关机按钮不可用
                                parent.$("#turnoff").attr("onclick","");
                            }else {
                                parent.$("#turnon_img").removeClass("xk_options_openicon_disable").addClass("xk_options_openicon");//关机时，开机按钮可用。
                                parent.$("#turnon").attr("onclick", "wakeup()");//关机时，点击开机按钮可用
                                parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，开机按钮不可用。
                                parent.$("#turnoff").attr("onclick", "");
                            }
                        }
                        else
                        {
                            parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnon").attr("onclick","");//开机时，点击开机按钮不可用
                            parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，开机按钮不可用。
                            parent.$("#turnoff").attr("onclick","");
                            //parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");//关机时，开机按钮可用。
                            //parent.$("#turnon").attr("onclick","");//关机时，点击开机按钮可用
                        }
                        //parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");//开机时，关机按钮不可用
                       // parent.$("#turnoff").attr("onclick","");
                        if(dspecid ==17){
                            parent.$("#record_vedio").attr("onclick", "");//开始录制按钮不可用
                            parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                            parent.$("#stop_record_vedio").attr("onclick", "");////停止录制按钮不可用
                            parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                        }else{
                            parent.$("#record_vedio").attr("onclick", "");//关机时开始录制按钮不可用
                            parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                            parent.$("#stop_record_vedio").attr("onclick", "");////关机时停止录制按钮不可用
                            parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                        }

                    }
                    parent.$("#selected_host").val(hostid);
                    parent.$("#selected_host").attr("ip",hostip);
                }else{//IPC
                    parent.$("#selected_host").val("");
                    parent.$("#selected_host").attr("ip","");
                    parent.$("#turnon").attr("onclick","");
                    parent.$("#turnoff").attr("onclick","");
                    parent.$("#turnon_img").removeClass("xk_options_openicon").addClass("xk_options_openicon_disable");
                    parent.$("#turnoff_img").removeClass("xk_options_closeicon").addClass("xk_options_closeicon_disable");
                    parent.$("#record_vedio").attr("onclick", "");
                    parent.$("#record_vedio_img").removeClass("xk_options_recordingicon").addClass("xk_options_recordingicon_disable");
                    parent.$("#stop_record_vedio").attr("onclick", "");
                    parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon").addClass("xk_options_stoprecordingicon_disable");
                }

            } else if ($(this).attr("bingo") == "done") {
                $(this).attr("bingo", "none");
                $(this).attr("class", "xk_video");
                $(".xk_video,.xk_video_selected").css("box-shadow","none")
                $(this).find(".bgred").addClass("bgr").removeClass("bgred");
                parent.$("#selected_host").val("");
                parent.$("#selected_host").attr("ip","");
                parent.$("#turnon").attr("onclick","wakeup()");
                parent.$("#turnoff").attr("onclick","shutdown()");
                parent.$("#turnon_img").removeClass("xk_options_openicon_disable").addClass("xk_options_openicon");
                parent.$("#turnoff_img").removeClass("xk_options_closeicon_disable").addClass("xk_options_closeicon");
                parent.$("#record_vedio").attr("onclick", "recording()");
                parent.$("#record_vedio_img").removeClass("xk_options_recordingicon_disable").addClass("xk_options_recordingicon");
                parent.$("#stop_record_vedio").attr("onclick", "stoprecord()");
                parent.$("#stop_record_vedio_img").removeClass("xk_options_stoprecordingicon_disable").addClass("xk_options_stoprecordingicon");
            }
        })
        //选择教室主机后，点击开机，给提示信息
//        parent.$("#turnon").click(function(){
//            alert("a")
//            var xkselectlen=$(".xk_video_selected").length;
//            if(xkselectlen==1){
//                var groupname=$(".xk_video_selected").find(".xk_video_group").children("div").eq(1).text();
//                parent.$(".xk_video_group_warn").show()
//                parent.$(".xk_video_group_warn").text(groupname+"开机中，请耐心等待...")
//            }
//        })
        //选择教室主机后，点击关机，给提示信息
//        parent.$("#turnoff").click(function(){
//            alert("b")
//            var xkselectlen=$(".xk_video_selected").length;
//            if(xkselectlen==1){
//                var groupname=$(".xk_video_selected").find(".xk_video_group").children("div").eq(1).text();
//                parent.$(".xk_video_group_warn").show()
//                parent.$(".xk_video_group_warn").text(groupname+"关机中，请耐心等待...")
//            }
//        })
        var names = document.getElementsByName("ScriptableObject");
        //alert(names.length);
        for (var i = 0; i < names.length; i++) {
            var url = names[i].getAttribute("url");
            var id = names[i].getAttribute("id");
            var obj = document.getElementById(id);

            // alert(url);
            //obj.play(url);
            try {
                names[i].play(url);
            } catch (e) {

            }

        }


    })
    //点击空白区域，隐藏巡课select模拟
    $(document).bind("click", function (e) {
        var target = $(e.target);//获取点击事件
        if (target.closest(".tree").length == 0) {
            parent.$(".selectdivul").hide();//隐藏divli
            parent.$(".public_setting_modifypassword").hide();//隐藏divli
        }
        if(target.closest(".public_setting").length == 0)
				{
					parent.$(".public_setting_menu").hide();
					parent.$(".public_setting_modifypassword").hide();
				}
				if(target.closest(".xk_stage_change").length == 0){
					if(parent.$(".xk_stage_change").attr("changing")=="yes"){
						//console.log("bbb")
						parent.$(".xk_stage").hide()
						parent.$(".xk_stage_change").attr("changing","no")
					}
				}
        var founinelen=parent.$(".xk_fournine div").length;
        for(i=0,j=0;i<founinelen;i++){
        	if(parent.$(".xk_fournine div").css("display")=="block"){
        		j++;
        		if(j==founinelen){
        			if(target.closest(".xk_fournine").length == 0){
						if(parent.$(".xk_fournine div").eq(0).attr("class")=="xk_four_selected"){
							parent.$(".xk_fournine div").eq(0).css({"border":"1px solid #bbb","border-radius":" 3px 0 0 3px"});
							parent.$(".xk_fournine div").eq(1).hide()
						}else if(parent.$(".xk_fournine div").eq(1).attr("class")=="xk_nine_selected"){
							parent.$(".xk_fournine div").eq(1).css({"border":"1px solid #bbb","border-radius":" 3px 0 0 3px"});
							parent.$(".xk_fournine div").eq(0).hide()
						}
					}
        		}
        	}
        }
    });

    function jumpSetting(){
        parent.window.location.href="${pageContext.request.contextPath}/settings/Settings_findNas.do";
    }
    
    $(function(){
        $(".xk_split_camera").mouseover(function(){
            $(this).css("background-position","0px -24px")
        }).mouseleave(function(){
            $(this).css("background-position","0px 0px")
        })
        $(".xk_video_camera").mouseover(function(){
            $(this).css("background-position","-117px -71px")
        }).mouseleave(function(){
            $(this).css("background-position","-117px -92px")
        })
    })
//改变分页
function pageChange(){
    $('#view').find('.allarea').eq(1).after('<div style="clear: both;"><div>');
    var contentHeight = $('#view').height();
    var maxWidth = parseInt((contentHeight / 2 - 35) / 9 * 16);
    $('.allarea').css('max-width', maxWidth + 'px');
    $('.allarea').css('height', $('.allarea').width() * 9 / 16 + 'px');

    var allareawidth= $('.allarea').width();
    console.log(allareawidth)
    var percentage=9/16;
    var allareaheight=allareawidth*percentage;
    $('.allarea').height(allareaheight+25);

    $(".xk_video,.xk_video_selected").height(allareaheight+25);
    $(".xk_video,.xk_video_text,.xk_video_twofour,.xk_video_selected").width(allareawidth);
//        $(".allarea").css({"margin-left": marginleft * 2 + "px", "margin-top": "5px"})
    $(".twofour").css("height", allareaheight);
    $(".twoimg").css("height", allareaheight + "px");
    $(".xk_video_twofour,.xk_video_twofourobj").height(allareaheight);

    if($('.xk_video_twofour >div').hasClass('xk_video_twofourobj')){
        var xk_twofourobjwidth =$(".xk_video_twofourobj").width();
        var xk_twofourobjheight =$(".xk_video_twofourobj").height();
        var xk_video_twofourobjheight = xk_twofourobjwidth*percentage;
        var fourfourheight = xk_twofourobjheight-xk_video_twofourobjheight;
        var twofourmargintop=(xk_twofourobjheight-xk_video_twofourobjheight)/2;
        $(".fourfourimg").css("height", xk_video_twofourobjheight + "px");
        $(".fourfourimg").css("margin-top", twofourmargintop + "px");
        $(".fourfour").css("width", "100%");
        $(".fourfour").css("height","50%");

        $(".fourfour").css("background", "#535e7");
        $(".fourfour").css("margin-top", twofourmargintop + "px")
    }
};
</script>