Web服务器与Web客户端通信协议(在线客服版)
===========================================

NextIM服务端接口协议为web浏览器和web服务器之间的通信协议，HTTP请求返回数据格式使用[json][json]格式或者字符串`ok`。

返回结果需要支持jsonp，使用jsonp时会加callback参数，使用jsonp时返回的http status类错误无效。


常用数据
-----------------------

###连接信息connection


	{
	        "domain": "www.uchome.com",
	        "ticket": "8633d182-b7fe-42a3-8466-0c4134cfebf2",
	        "server": "http://ucim.webim20.cn:8000/packets"
	}


参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
domain			|string	|true	|域名，API注册域名
ticket			|string	|true	|本次通信令牌，用于浏览器与消息服务器建立JSONP长连接
server			|string	|true	|im服务器地址

###用户信息userInfo              

####示例                         

	{
		"id": 'jack',
	        "nick": "Jack",
	        "pic_url": "jack.jpg",
	        "default_pic_url": "default.jpg",
	        "url": "space.php?uid=2",
	        "status": "I'm free.", 
	        "show": "available",
	        "status_time": "10:55"
	}

参数名			|类型	|必需	|描述
------------------------|-------|-------|----
id			|string	|true	|用户唯一ID
nick			|string	|true	|用户昵称或姓名
pic\_url		|string	|false	|用户头像地址
default\_pic\_url	|string	|false	|用户头像默认地址，当头像加载失败时显示
status			|string	|false	|用户状态显示信息
show			|string	|false	|用户状态['available', 'away', 'chat', 'dnd', 'invisible']
status\_time		|string	|false	|用户状态时间

###聊天记录logItem

####示例

	{
	        "type": "unicast",
	        "to": "susan",
	        "from": "jack",
		"nick": "Jack",
	        "style": "color:#bbb;",
	        "body": "Hello.",
	        "timestamp": 1246883572400
	}

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
type			|string	|true	|记录类型，unicast: 一对一
to			|string	|true	|接收消息用户ID
from			|string	|true	|发送消息用户ID
nick			|string	|true	|发送消息用户名称
style			|string	|false	|消息css样式
body			|string	|true	|消息内容
timestamp		|int	|true	|消息发送时间，时间为javascript时间，php中使用microtime(true)\*1000

###聊天记录列表history

####示例

	[&logItem]
	
###联系人信息buddyInfo

	{
		"id": 'susan',
	        "nick": "Susan",
	        "group": "friend", 
	        "pic_url": "susan.jpg",
	        "default_pic_url": "default.jpg",
	        "url": "space.php?uid=2",
	        "presence": "online",
	        "status": "I'm buzy.", 
	        "show": "buzy",
	        "status_time": "10:55",
		"history": &history
	}

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
id			|string	|true	|联系人唯一ID
nick			|string	|true	|联系人昵称或姓名
presence		|string	|false	|联系人是在线离线["online", "offline"],默认offline
group			|string	|false	|联系人所属分组
pic\_url		|string	|false	|联系人头像地址
default\_pic\_url	|string	|false	|联系人头像默认地址，当头像加载失败时显示
status			|string	|false	|联系人状态显示信息
show			|string	|false	|联系人状态['available', 'away', 'chat', 'dnd', 'invisible']
status\_time		|string	|false	|联系人状态时间
incomplete		|bool	|false	|标志返回信息不完整，比如登录时未返回分组头像等信息，前端界面会在需要时重新读取，默认false
history			|object	|false	|联系人和当前用户聊天记录，如果没有则会新建连接从webim/history读取


###联系人列表buddies

####示例

	[&buddyInfo]


接口说明
--------------------------

###上线登录 POST webim/online

####无请求参数

####返回参数

成功

        {
		success: true,
                server_time: 1281443447248, 
                user: &userInfo,
                connection: &connection,
                buddies: &buddies, 
                new_messages: []
        }

失败

        {
		success: false,
		error_msg: 'Not Authorized'
	}

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
success			|bool	|true	|上线成功或失败
server\_time		|int	|true	|服务器当前时间，解决本地时差，返回js时间戳。microtime(true)\*1000
user			|object	|true	|当前用户信息
connection		|object	|true	|当前用户连接信息
buddies			|object	|true	|根据请求参数中buddy\_ids和离线消息取得联系人信息
new\_messages		|object	|true	|未收到的离线消息
error\_msg		|string	|false	|错误消息 Not Found, Forbidden, Not Authorized, IM Server Not Found, IM Server Not Authorized


###获取联系人列表 GET webim/buddies

####请求参数

        {
                ids:"susan,josh"
        }

####返回参数

        &buddies


###获得历史记录 GET webim/history

####请求参数

        {
                id: "susan",
		type: "unicast"
        }

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
ids			|string	|true	|需要取得的历史记录联系人或群组列表
type			|string	|true	|取得历史记录类型，unicast: 联系人


####返回参数

        	&history


###发送消息 POST webim/message

发送消息，并将消息保存到数据库

####请求参数

	&connection
        {
                type: "unicast", 
                offline: false, 
                to: "susan",
                body: "sdf",
                style: "color:red"
        }

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
type			|string	|true	|记录类型，unicast: 一对一
offline			|bool	|false	|是否离线消息，默认false
to			|string	|true	|接收消息用户ID
style			|string	|false	|消息css样式
body			|string	|true	|消息内容


###保存消息 POST webim/logmsg

保存桌面客户端(jabber)发回的消息到数据库, 由于Web客户端可以开多个，注意先通过from,to,body和timestamp参数判断数据库中是否有此数据，然后再插入数据。

####请求参数

	&connection
        {
                type: "unicast", 
                from: 'jack', 
                nick: 'Jack', 
                to: "susan",
                body: "sdf",
                style: "color:red",
                body: "timestamp"
        }

参数名			|类型	|必需	|描述
------------------------|-------|-------|------------
type			|string	|true	|记录类型，unicast: 一对一
to			|string	|true	|接收消息用户ID
style			|string	|false	|消息css样式
body			|string	|true	|消息内容
from			|string	|true	|发送者
nick			|string	|true	|发送者昵称
timestamp		|string	|true	|消息发送时间


####返回参数

        ok

###清除历史记录 POST webim/clear_history

####请求参数

        {
                id: 'susan'
        }

####返回参数

        ok

###刷新页面 POST webim/refresh

退出当前连接

####请求参数

	&connection

####返回参数

        ok



参考
--------------------

*	[rfc3921](http://xmpp.org/rfcs/rfc3921.html)



[json]: http://json.org/
[nextim_js]: http://github.com/nextim/nextim-js
[nextim_ui]: http://github.com/nextim/nextim-ui
[nextim_server]: http://github.com/nextim/nextim-server
