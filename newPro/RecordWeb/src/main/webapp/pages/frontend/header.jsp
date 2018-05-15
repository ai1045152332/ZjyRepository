<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="com.honghe.recordweb.action.SessionManager" %>
<%@ page import="com.honghe.recordhibernate.entity.User" %>
<%@ page import="com.honghe.recordweb.service.frontend.user.UserService" %>
<%--
  Created by IntelliJ IDEA.
  User: zhanghongbin
  Date: 14-10-8
  Time: 下午4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="${pageContext.request.contextPath}/css/frontend/index.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/frontend/main.css" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/js/common/header.js"></script>
<%

    response.setHeader("Cache-Control","no-store");

    response.setHeader("Pragma","no-cache");

    response.setDateHeader("Expires",0);


%>
<style>
.tab_content_listinput{
	border:1px solid #bbb
}
.tab_content_listtext{
	color: #80858F;
}
	
</style>
    <input type="hidden" value="${pageContext.request.contextPath}" id="root_path">
        <div class="public_head">
            <div class="public_head_logo"></div>
            <div class=" public_setting" >
                <%
                    User curruser = SessionManager.get(request.getSession(), SessionManager.Key.USER);
                    Integer uid = curruser.getUserId();
                %>
                <div class="public_setting_menu">
                    <li><span style="position: relative; top: -3px;">修改密码</span></li>
                    <%--<a href="${pageContext.request.contextPath}/user/User_logout.do"><li>退出登录</li></a>--%>、
                    <a href="javascript:logout()"><li>退出登录</li></a>
                </div>
               <div class="public_setting_modifypassword">
               	<span class="tab_content_listtext" style="width:40px;">旧密码:</span>
                    <span style="padding-bottom: 2px; padding-top: 1px; padding-left: 0; padding-right: 0">
                        <input type="password" maxlength="20" name="old_pwd" class="tab_content_listinput" style="width:110px">
                    </span>
                    <span class="tab_content_listtext" style="width:50px;">新密码:</span>
                    <span style="padding-bottom: 2px; padding-top: 1px; padding-left: 0; padding-right: 0">
                        <input type="password" maxlength="20" name="pwd" class="tab_content_listinput" style="width:110px">
                    </span>
                    <span class="tab_content_listtext" style="width:60px;">确认密码:</span>
                    <input type="password" maxlength="20" name="confirm_pwd" class="tab_content_listinput" style="width:110px">
                    <input class="public_setting_sure" type="submit" value="确定" >
                </div>
            </div>
            <div class="public_nav">
                <ul>
                    <%
                        Map<String, Integer> authority = SessionManager.get(request.getSession(), SessionManager.Key.Authority);
                        String dmanager = "0"; //设备控制
                        String system = "dmanager";
                        if (UserService.authCheck(uid.toString(),"dmanager:retrieve",system)) {
                            dmanager = "1";
                        }
                        String hhtcplan = "0";//定时计划
                        if (UserService.authCheck(uid.toString(),"hhtcplan:retrieve",system)) {
                            hhtcplan = "1";
                        }
                        String message = "0";//信息发布
                        String softInstall="0";//软件安装
                        if (UserService.authCheck(uid.toString(),"message:retrieve",system)) {
                            message = "1";
                            softInstall = "1";
                        }
                        String tresource = "0";//信息发布中的资源管理
                        if (UserService.authCheck(uid.toString(),"message:retrieve",system)){
                            tresource = "1";
                        }
                        String device = "0";//设备管理

                        if (UserService.authCheck(uid.toString(),"device:retrieve",system)) {
                            device = "1";
                        }
                        String user = "0";//用户管理
                        if (UserService.authCheck(uid.toString(),"user:retrieve",system)) {
                            user = "1";
                        }
                        String log = "0";//日志管理
                        String monitor = "0";
                        String javamelody = "0";
                        if (UserService.authCheck(uid.toString(),"syslog:retrieve",system)) {
                            log = "1";
                            monitor="1";
                            javamelody="1";
                        }
                        //系统设置权限
                        String setting = "0";
                        if (UserService.authCheck(uid.toString(), "syssetting:retrieve", system)) {
                            setting = "1";
                        }
                        Map<String, String[]> dic = new LinkedHashMap<String, String[]>();
                        dic.put("/pages/frontend/dmanager", new String[]{ServletActionContext.getRequest().getContextPath() + "/dmanager/DManager_getHostGroup.do", "设备控制", dmanager});
                        dic.put("/pages/frontend/policy", new String[]{ServletActionContext.getRequest().getContextPath() + "/policy/Policy_policyList.do", "定时计划", hhtcplan});
                        dic.put("/pages/frontend/news", new String[]{ServletActionContext.getRequest().getContextPath() + "/news/News_richNewsList.do", "信息发布", message});
                        dic.put("/pages/frontend/device", new String[]{ServletActionContext.getRequest().getContextPath() + "/hostgroup/Hostgroup_management.do", "设备管理", device});
                       // dic.put("/pages/frontend/resource", new String[]{ServletActionContext.getRequest().getContextPath() + "/resource/Resource_resourceList.do", "资源管理", resource});
                        dic.put("/pages/frontend/tresource", new String[]{ServletActionContext.getRequest().getContextPath() + "/tresource/Tresource_home.do", "资源管理", tresource});
                       // dic.put("/pages/frontend/role", new String[]{ServletActionContext.getRequest().getContextPath() + "/role/Role_roleList.do", "角色管理", role});
                       // dic.put("/pages/frontend/devicelog", new String[]{ServletActionContext.getRequest().getContextPath() + "/syslog/SysLog_deviceLogList.do?flag=1", "日志管理", log});
                        //dic.put("/pages/frontend/setting", new String[]{ServletActionContext.getRequest().getContextPath() + "/settings/Settings_hhtcSetting.do?flag=1", "系统设置", setting});
                        dic.put("/pages/frontend/install", new String[]{ServletActionContext.getRequest().getContextPath() + "/install/Install_installList.do", "软件安装", softInstall});
                        String currentSelect = "class=\"public_headbg\"";
                        String path = request.getServletPath().substring(0, request.getServletPath().lastIndexOf("/"));
                        Iterator<String> iterator = dic.keySet().iterator();
                        while (iterator.hasNext()) {
                            String key = iterator.next();
                            if (dic.get(key)[2].equals("0")) {
                                continue;
                            }
                            if (key.equals(path)) {
                                out.println("<li><a name='header_href' href=\"" + dic.get(key)[0] + "\"" + currentSelect + "><span></span>" + dic.get(key)[1] + "</a><div class=\"public_navcircle\"></div></li>");
                            } else {
                                out.println("<li><a name='header_href' href=\"" + dic.get(key)[0] + "\"><span></span>" + dic.get(key)[1] + "</a><div class=\"public_navcircle\"></div></li>");
                            }
                        }

                    %>
                    <style>
                        .navmore{
                            background: #363a41;
                            border-radius: 15px;
                            display: none;
                            float: left;
                            height: auto;
                            left: 5px;
                            position: absolute;
                            top: 0px;
                            width: 101px;
                            z-index: 1000;
                            padding-bottom: 5px;
                        }
                        .navmorelist{
                            float: left;
                            height: 30px;
                            line-height: 30px;
                            text-align: center;
                            width: 100%;
                        }
                        .navmorelist a{
                            height: 30px;
                            line-height: 30px;
                            width: 101px;
                        }
                    </style>
                    <%if(log.equals("1") || softInstall.equals("1") || user.equals("1")){%>
                    <li class="more">
                        <a style="text-indent: 0px;color: #bbb; text-align: center;position: relative;">
                            <span style="display: none;"></span>更多

                        </a>
                        <div class="navmore">
                            <%if(log.equals("1")){%>
                                <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/syslog/SysLog_deviceLogList.do"%>" style="width:101px;height:30px;line-height: 30px">日志管理</a></div>
                                <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/pages/frontend/javamelody/javamelody.jsp"%>" style="width:101px;height:30px;line-height: 30px">系统监控</a></div>
                                <!--<div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/monitor/Monitor_getLivenessByHost.do"%>" style="width:101px;height:30px;line-height: 30px">软件统计</a></div>-->
                            <%}%>
                            <%if(softInstall.equals("1")){%>
                                <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/settings/Settings_hhtcSetting.do"%>" style="width:101px;height:30px;line-height: 30px">系统设置</a></div>
                            <%}%>
                            <%if(user.equals("1")){%>
                                <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/user/User_userList.do"%>" style="width:101px;height:30px;line-height: 30px">用户管理</a></div>
                            <%}%>
                            <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/onlinetime/Onlinetime_report.do"%>" style="width:101px;height:30px;line-height: 30px">报表统计</a></div>
                            <div class="navmorelist"><a href="<%=ServletActionContext.getRequest().getContextPath() + "/deviceview/Deviceview_deviceList.do"%>" style="width:101px;height:30px;line-height: 30px">实时监控</a></div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                    
                </ul>
            </div>
        </div>
<script>
    $(function(){
        //更多位置
        var moreposi=$(".public_nav li").height()/2+15;
        $(".navmore").css("top",moreposi+"px")
        $(".more").mouseover(function(){
            $(".navmore").show()
        }).mouseout(function(){
            $(".navmore").hide()
        })

$(".public_nav span").css("display","none")
$(".public_nav li a").css({"text-indent":"0","text-align":"center"})
        $.ajaxSetup({

            contentType:"application/x-www-form-urlencoded;charset=utf-8",

            complete:function(XMLHttpRequest,textStatus){

                //通过XMLHttpRequest取得响应头，sessionstatus

                var sessionstatus=XMLHttpRequest.getResponseHeader("frontend-sessionstatus");

                if(sessionstatus=="frontend-timeout"){

                    //这里怎么处理在你，这里跳转的登录页面
                    var rootpath = document.getElementById("root_path").value;
                    window.location.replace(rootpath+"/login.jsp");
                }
            }
        });
         $(".public_setting_menu li").eq(0).mouseover(function(){
        	$(".public_setting_menu li").eq(0).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #eee 5px -388px no-repeat"});
        	//$(".public_setting_menu li").eq(1).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #fff -100px -370px no-repeat"});
        }).mouseout(function(){
        	//$(".public_setting_menu li").eq(1).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #eee -100px -370px no-repeat"});
        	$(".public_setting_menu li").eq(0).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #fff 5px -388px no-repeat"});
        }).trigger("mouseout");
        $(".public_setting_menu li").eq(1).mouseover(function(){
        	//$(".public_setting_menu li").eq(0).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #eee 5px -370px no-repeat"});
        	$(".public_setting_menu li").eq(1).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #eee -101px -385px no-repeat"});
        }).mouseout(function(){
       		$(".public_setting_menu li").eq(1).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #fff -101px -385px no-repeat"});
        	//$(".public_setting_menu li").eq(0).css({"background":"url(${pageContext.request.contextPath}/image/frontend/n_icon_141009.png) #fff 5px -370px no-repeat"});
        })
        $(".public_setting").click(function(){
        	var flag=$(".public_setting_menu").css("display");
        	var flagone=$(".public_setting_modifypassword").css("display");
        	if(flag=="none"&&flagone=="none"){
        		$(".public_setting_menu").show()
        	}else{
        		$(".public_setting_menu").hide()
        	}
        })
        $(".public_setting_menu li").eq(0).click(function(){
            $("input[name='pwd']").val("");
            $("input[name='confirm_pwd']").val("");
            $(".public_setting_modifypassword").show();
    	})
        //点击空白区域，隐藏select模拟
	$(document).bind("click",function(e){
		var target = $(e.target);//获取点击时间
		if(target.closest(".public_setting").length == 0)
		{
			$(".public_setting_menu").hide();
			$(".public_setting_modifypassword").hide();
		}
		
		if(target.closest(".xk_stage_change").length == 0){
			if($(".xk_stage_change").attr("changing")=="yes"){
				//console.log("aaaaaa")
				$(".xk_stage").hide()
				$(".xk_stage_change").attr("changing","no")
			}
		}
		if(target.closest(".xk_fournine").length == 0){
			if($(".xk_fournine div").eq(0).attr("class")=="xk_four_selected"){
				$(".xk_fournine div").eq(0).css({"border":"1px solid #bbb","border-radius":" 3px 0 0 3px"});
				$(".xk_fournine div").eq(1).hide()
			}else if($(".xk_fournine div").eq(1).attr("class")=="xk_nine_selected"){
				$(".xk_fournine div").eq(1).css({"border":"1px solid #bbb","border-radius":" 3px 0 0 3px"});
				$(".xk_fournine div").eq(0).hide()
			}
		}
	})
        $(".public_setting_sure").click(function () {
            $("input[name='old_pwd']").css({border:"solid 1px silver"});
            $("input[name='pwd']").css({border:"solid 1px silver"});
            $("input[name='confirm_pwd']").css({border:"solid 1px silver"});
            var rootpath = $("#root_path").val();
            var old_pwd = $("input[name='old_pwd']").val();
            if(old_pwd == "")
            {
                $("input[name='old_pwd']").css({border:"solid 1px red"});
                return false;
            }
            var pwd = $("input[name='pwd']").val();
            if(pwd=="")
            {
                $("input[name='pwd']").css({border:"solid 1px red"});
                return false;
            }
            var confirm_pwd = $("input[name='confirm_pwd']").val();
            if(confirm_pwd == "")
            {
                $("input[name='confirm_pwd']").css({border:"solid 1px red"});
                return false;
            }
            if(pwd != confirm_pwd)
            {
                $("input[name='pwd']").css({border:"solid 1px red"});
                $("input[name='confirm_pwd']").css({border:"solid 1px red"});
                return false;
            }
            if(pwd == old_pwd)
            {
                $("input[name='pwd']").css({border:"solid 1px red"});
                $("input[name='old_pwd']").css({border:"solid 1px red"});
                return false;
            }
            var uid = <%=uid%>;
            if(uid)
            {
                $.post(rootpath+"/user/User_resetPwd.do", {userId: uid,userpwd:pwd,oldpwd:old_pwd},function(data){
                    if(data.success==true)
                    {
                        $(".public_setting_menu").hide();
                        $(".public_setting_modifypassword").hide()
                    }
                    else
                    {
                        $("input[name='old_pwd']").css({border:"solid 1px red"});
                        $("input[name='pwd']").css({border:"solid 1px red"});
                        $("input[name='confirm_pwd']").css({border:"solid 1px red"});
                    }
                },'json');
            }
            else
            {
                $("input[name='old_pwd']").css({border:"solid 1px red"});
                $("input[name='pwd']").css({border:"solid 1px red"});
                $("input[name='confirm_pwd']").css({border:"solid 1px red"});
            }
        });
    });
</script>
