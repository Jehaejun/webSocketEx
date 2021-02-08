<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<link rel="stylesheet" href="<%= request.getContextPath()%>/css/common.css">
	<link rel="stylesheet" href="<%= request.getContextPath()%>/css/bootstrap.min.css">
	<script src="<%= request.getContextPath()%>/js/wc_ChatRoom.js" /></script>
	<script src="<%= request.getContextPath()%>/js/common.js" /></script>
    <title>테스트중</title>
</head>
<body>
<div class="center-block">
    <div class="row">
        <div class="col-md-5">
            <div class="panel panel-primary" style="margin-bottom: 0px;">
                <div class="panel-heading" id="accordion">
                    <span class="glyphicon glyphicon-comment"></span> Chat
                    <span class="pull-right" id="cnt" style="/* margin-left: 60% */"></span>
                </div>
            <div class="panel-collapse">
                <div class="panel-body">
                    <ul class="chat">
                        <li class="left clearfix"  style="display:none;"><span class="chat-img pull-left">
                            <img src="/WebSocketEx/img/bg_infobox3.gif" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <strong class="primary-font"><!-- Jack Sparrow --></strong> <small class="pull-right text-muted">
                                        <span class="glyphicon glyphicon-time"></span><span><!-- 2019-04-22 15:42:22 --></span></small>
                                </div>
                                <p>
									<!-- text -->
                                </p>
                            </div>
                        </li>
                        <li class="right clearfix" style="display:none;"><span class="chat-img pull-right">
                            <img src="/WebSocketEx/img/ex_photo.png" alt="User Avatar" class="img-circle" />
                        </span>
                            <div class="chat-body clearfix">
                                <div class="header">
                                    <small class=" text-muted"><span class="glyphicon glyphicon-time"></span><span><!-- 2019-04-22 15:42:22 --></span></small>
                                    <strong class="pull-right primary-font"><!-- Bhaumik Patel --></strong>
                                </div>
                                <p>
                                    <!-- text -->
                                </p>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="panel-footer">
                    <div class="input-group">
                    <input id="txt_name" type="text" class="form-control input-sm" style="width: 20%;">
                        <input id="txt_message" type="text" class="form-control input-sm" style="width: 80%;" placeholder="Type your message here..." />
                        <span class="input-group-btn">
                            <button class="btn btn-warning btn-sm" id="btn_send">
                                Send</button>
                        </span>
                    </div>
                </div>
            </div>
            </div>
        </div>
    </div>
</div>
    
</body>
</html>

