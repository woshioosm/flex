package cn.edu.whu.liesmars.asPack.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import spark.components.Label;
	import spark.primitives.BitmapImage;

	public class GenerateAuthcode
	{
		public  function GenerateAuthcode()
		{
		}
		public static function  generate(sprite:Label):String{
			var ran:Number;
			var number:Number;
			var code:String;
			var checkCode:String ="";
			for(var i:int=0; i<4; i++)
			{
				//Math.random生成数为类似为0.1234
				ran=Math.random();
				number =Math.round(ran*10000);
				//如果是2的倍数生成一个数字
				if(number % 2 == 0)
					//"0"的ASCII码是48
					code = String.fromCharCode(48+(number % 10));
					//生成一个字母
				else
					//"A"的ASCII码为65
					code = String.fromCharCode(65+(number % 26)) ;
				checkCode += code;
			}

			sprite.text=checkCode; 
			sprite.graphics.clear();
			
			
			var c:int=sprite.text.length * 20;
			for(var j:int=0; j < c; j++)
			{
				var x:int=Math.random() * sprite.width;
				var y:int=Math.random() * sprite.height;
				sprite.graphics.lineStyle(1, 0x7C929D);
				sprite.graphics.drawRect(x, y, 3, 3);
			}
			return checkCode;
		}
	} 
}