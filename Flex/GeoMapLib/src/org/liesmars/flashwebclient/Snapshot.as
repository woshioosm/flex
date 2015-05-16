package org.liesmars.flashwebclient
{
	import com.adobe.images.JPGEncoder;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import mx.graphics.ImageSnapshot;
	
	public class Snapshot
	{
		public var printObj:Sprite;
		public var jpg:JPGEncoder;
		public var data:BitmapData;
		
		public function Snapshot():void
		{			
		}
		
		public function setLayer(s:Sprite):void
		{
			this.printObj=s;
		}
		//ImageSnapshot  flex3
		public function print(quality:Number):Bitmap
		{
			if(!jpg)jpg=new JPGEncoder(quality);			
			return new Bitmap(ImageSnapshot.captureBitmapData(this.printObj));			
		}
	}
}