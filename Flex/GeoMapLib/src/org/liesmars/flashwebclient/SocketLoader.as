package org.liesmars.flashwebclient
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import org.liesmars.flashwebclient.Event.LoaderEvent;
	
	public class SocketLoader
	{
		private var _layer:Layer;
		
		private var char1:Boolean = false;
		private var char2:Boolean = false;
		private var char3:Boolean = false;
		private var char4:Boolean = false;
		public var barr:ByteArray = new ByteArray();
		public var socket:Socket = new Socket();
		private var first:Boolean = true;
		private var line:String = "";
		private var CONTENTLEN:int = 0;
		
		public function SocketLoader(host:String,port:int)
		{
			socket.addEventListener(Event.CONNECT, connectionCompleteHandler);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, dataHandler);
			socket.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			socket.addEventListener(Event.CLOSE, closeHandler);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
			socket.connect(host,port);
		}
		
		public function set layer(val:Layer):void{
			_layer = val;
		}
		
		public function get layer():Layer{
			return _layer;
		}
		
		private function connectionCompleteHandler(e:Event):void{
			trace("连接数据服务器成功！");
			//Alert.show("连接成功！");
			Util.connectFinish = true;
		}
		
		private function IOErrorHandler(err:IOErrorEvent):void{
			trace(err.toString());
		}
		
		private function securityErrorHandler(err:SecurityErrorEvent):void{
			trace("安全错误！");
		}
		
		private function closeHandler():void{
			trace("连接断开！");
		}
		
		public function restore():void{
			first = true;
			line = "";
			char1 = char2 = char3 = char4 = false;
			barr = new ByteArray();
			CONTENTLEN = 0;
		}
		
		private function dataHandler(e:ProgressEvent):void{
			// \r 13 \n 10 space 32
			if(first){
				for(var i:int = 0;i<socket.bytesAvailable;i++)
				{
					var val:int = socket.readByte();
				
					if(val == 13){
						if(!char1){
							char1 = true;
						}else{
							char3 = true;
						}
					}
					else if(val == 10){
						if(!char2){
							char2 = true;
						/////////////////////////////////////////
							if(char1){
								if(line.indexOf("Content-Length: ")>=0){
									var start:int = line.indexOf("Content-Length: ")+ new String("Content-Length: ").length;
									var end:int = line.length-1;
									//trace(line.substring(start,end),line.substring(start,end).length);
									CONTENTLEN = Number(line.substring(start,end));
								}
								if(line.indexOf("HTTP/1.1 200")>=0 ||line.indexOf("HTTP/1.0 200")>=0){
									Util.httpOK = true;
								}
								if(line.indexOf("HTTP/1.1 404")>=0 ||line.indexOf("HTTP/1.0 404")>=0){
									Util.httpOK = false;
									//CONTENTLEN = -1;
									//break;
								}
							}
						}
						else{
							char4 = true;
						}
					}
					else{
						if(char1 && char2)
							line = "";
						char1 = char2 = char3 = char4 = false;
					}
				
					line += String.fromCharCode(val);
					
				
					if(char1 && char2 && char3 && char4){
						socket.readBytes(barr,barr.length,socket.bytesAvailable);
						//trace(barr.length);
					}
				}
				first = false;
			}
			else{
				socket.readBytes(barr,barr.length,socket.bytesAvailable);
			}
			
//			if(CONTENTLEN < 0){
//				this._layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,2));
//			}
//			else 
			if(barr.length == CONTENTLEN){
				if(Util.httpOK){
					this._layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,1));
					Util.httpOK = false;
				}
				else{
					this._layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,2));
				}
			}else{
				if(Util.httpOK){
//					this._layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,3));
				}
				else{
					this._layer.dispatchEvent(new LoaderEvent(LoaderEvent.LoaderComplete,2));
				}
			}////判断404的情况,GeoGlobe在404的时候没有返回全部数据。。。悲剧。。。
			//   现在想到一个解决办法，不过没时间写了，看论文搞完后还记不记得这个事情了
		}

	}
}