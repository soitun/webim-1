Web服务器与IM服务器通信协议(在线客服版)
===========================================


接口说明
--------------------------

###上线登录 POST presences/online

####请求参数

        {
		version: 3,
                domain: "www.webim20.cn",
                apikey: "public",
                buddies: "jack,susan", 
		visitor: "true",
                name: "marry", 
                nick: "Marry" 
        }

参数名			|必需	|描述
------------------------|-------|------------
version			|true	|版本号，暂为3
domain			|true	|注册域名
apikey			|true	|认证Key
buddies			|true	|联系人列表
name			|true	|登录名
nick			|true	|昵称
visitor			|false	|游客登录


####返回

返回数据为json格式


        {
		ticket: "NIween23AN2NDX",
                buddies: [{"name": "jack", "nick": "Jack"}] 
        }


参数名			|描述
------------------------|------------
ticket			|本次通信令牌，用于浏览器与消息服务器建立JSONP长连接
buddies			|在线联系人列表


###上线登录 POST presences/offline

####请求参数

        {
		version: 3,
                domain: "www.webim20.cn",
                apikey: "public",
		ticket: "NIween23AN2NDX"
        }

参数名			|必需	|描述
------------------------|-------|------------
version			|true	|版本号，暂为3
domain			|true	|注册域名
apikey			|true	|认证Key


####返回

	ok


###发送消息 POST messages

####请求参数

        {
		version: 3,
                domain: "www.webim20.cn",
                apikey: "public",
                ticket: "NIween23AN2NDX",
                nick: "Marry", 
                type: "unicast", 
                to: "jack", 
                body: "Hello.", 
                style: "", 
                timestamp: "1281443447248" 
        }

参数名			|必需	|描述
------------------------|-------|------------
version			|true	|版本号，暂为3
domain			|true	|注册域名
apikey			|true	|认证Key
ticket			|true	|通信令牌
nick			|true	|发送消息用户名称
type			|true	|固定"unicast"
to			|true	|接收消息用户ID
body			|true	|消息内容
style			|false	|消息css样式，暂无用处
timestamp		|true	|消息发送时间，时间为javascript时间，php中使用microtime(true)\*1000


####返回

	ok


