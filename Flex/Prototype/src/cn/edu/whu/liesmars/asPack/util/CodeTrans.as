package cn.edu.whu.liesmars.asPack.util
{
	public class CodeTrans
	{
		import flash.utils.ByteArray;
		public static function encodeUtf8(str: String):String{    //给他一个中文字符串，可以保证其返回值是中文
			
			if(str != null && str != "undefined"){
				var oriByteArr: ByteArray = new ByteArray();
				oriByteArr.writeUTFBytes(str);
				var tempByteArr:ByteArray = new ByteArray();
				//trace(str);    //这个str字符串当前是乱码
				for(var i:Number = 0; i < oriByteArr.length; i++){
					if(oriByteArr[i] == 194){
						tempByteArr.writeByte(oriByteArr[i+1]);
						i++;
					}else if(oriByteArr[i] == 195){
						tempByteArr.writeByte(oriByteArr[i+1] + 64);
						i++;
					}else{
						tempByteArr.writeByte(oriByteArr[i]);
					}
				}
				tempByteArr.position = 0;
				return tempByteArr.readMultiByte(tempByteArr.bytesAvailable, "chinese");
			}else{
				return "";
			}
		}
		
		public function CodeTrans()
		{
		}
	}
}