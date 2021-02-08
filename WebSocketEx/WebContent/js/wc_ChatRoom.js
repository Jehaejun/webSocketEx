$(document).ready(function() {
	_thisPage.onload();
	
	$("#btn_send").click(function(){
		_thisPage.send();
	});

	$("#txt_message").keydown(function(e) {
		if (e.keyCode == 13) {
			_thisPage.send();
		}
	});
	
	$(window).bind("beforeunload", function (e){
		webSocket.send(JSON.stringify({"IS_JOIN" :"N", "USER_NM" : $("#txt_name").val()}));
		webSocket.close();
	});
});

_thisPage = {
		onload : function(){
			if(location.protocol == "https:"){
				webSocket = new WebSocket('wss://10.254.241.154:8443/WebSocketEx/broadcasting');
			}else{
				webSocket = new WebSocket('ws://10.254.241.154:8088/WebSocketEx/broadcasting');
			}

			
			webSocket.onerror = function(event) {
				_thisPage.onError(event)
			};
			webSocket.onopen = function(event) {
				_thisPage.onOpen(event)
			};
			webSocket.onmessage = function(event) {
				_thisPage.onMessage(event)
			};
			
			component = {
					msgBoxLeft		: $(".chat").children(".left:eq(0)")
				  , msgBoxRight		: $(".chat").children(".right:eq(0)")
				  , inputMessage	: $("#txt_message")
				  , msgScreen		: $(".chat")
				  , userNm			: $("#txt_name")
			}
			
			Notification.requestPermission().then(function(result) {
				  if (result === 'denied') {
				    console.log('Permission wasn\'t granted. Allow a retry.');
				    return;
				  }
				  if (result === 'default') {
				    console.log('The permission request was dismissed.');
				    return;
				  }
				  // Do something with the granted permission.
				});
			
		}

	, onOpen : function(e){
		var sHtml = "<li class=\"right clearfix\"><div class=\"chat-body clearfix\"><div class=\"header\">"
				+ "<small class=\"text-muted\"><span>연결되었습니다.</span></small></div></div></li>";
		component.msgScreen.append(sHtml);

		
		_thisPage.getUserCount();
		webSocket.send(JSON.stringify({"IS_JOIN" :"Y"}));
		
	}
	
	, onMessage : function(e){
		var jsonData = JSON.parse(e.data);
		_thisPage.getUserCount();
		if(jsonData.IS_JOIN == "Y"){
			var sHtml = "<li class=\"right clearfix\"><div class=\"chat-body clearfix\"><div class=\"header\">"
						+ "<small class=\"text-muted\"><span>누군가 입장하였습니다.</span></small></div></div></li>";
			component.msgScreen.append(sHtml);
			var notification = new Notification("누군가 입장하였습니다.");
			setTimeout(function () {
	            notification.close();
	        }, 1000);
			return;
			
		}else if(jsonData.IS_JOIN == "N"){
			var sHtml = "<li class=\"right clearfix\"><div class=\"chat-body clearfix\"><div class=\"header\">"
				+ "<small class=\"text-muted\"><span>" + jsonData.USER_NM + "님이 나갔습니다.</span></small></div></div></li>";
			component.msgScreen.append(sHtml);
			var notification = new Notification(jsonData.USER_NM + "님이 나갔습니다.");
			setTimeout(function () {
	            notification.close();
	        }, 1000);
			
			return;	
		}
		
		var $msgBox = component.msgBoxLeft.clone();
		_thisPage.drawMessage($msgBox, jsonData);
		var notification = new Notification(jsonData.MSG);
		setTimeout(function () {
            notification.close();
        }, 1000);
		//var notification = new Notification("push test");
	}
	
	, onError : function(e){
		//alert(e.data);
		alert("연결이 원활하지 않습니다.");
	}
	
	, send : function(){
		if(webSocket.readyState == 1){
			if(component.inputMessage.val() == ""){
				return;
			}
			var $msgBox = component.msgBoxRight.clone();
			var message = component.inputMessage.val();
			
			_thisPage.drawMessage($msgBox, message, "me");
			webSocket.send(JSON.stringify({"USER_NM" : component.userNm.val(), "MSG" : message}));
			component.inputMessage.val("");
		}else{
			alert("연결이 원활하지 않습니다.");
		}
	}
	
	, drawMessage : function($msgBox, data, type){		
		var nowDate = new Date();		
		$msgBox.find("span:eq(2)").text(nowDate.format("yyyy-MM-dd a/p hh:mm:ss"));
		
		if(type == "me"){
			$msgBox.find("strong").text($("#txt_name").val());
			$msgBox.find("p").text(data);	
		}else{
			$msgBox.find("strong").text(data.USER_NM);
			$msgBox.find("p").text(data.MSG);	
		}
		$msgBox.show();
		
		component.msgScreen.append($msgBox);
		$(".panel-body").scrollTop($(".chat").height());
	}
	
	, getUserCount : function(){
		$.ajax({
			type:"POST",
			url:"./SessionCounter",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			dataType : "JSON",
			success: function(data){
				$("#cnt").text("User : " + data.CNT);
			},
			error: function(xhr, status, error) {
				alert(error);
			}	
		});
	}
}