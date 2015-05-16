package org.liesmars.flashwebclient.Handler.GeoRequest
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.*;
	
	import mx.containers.TitleWindow;
	import mx.controls.TextArea;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import org.liesmars.flashwebclient.*;
	import org.liesmars.flashwebclient.BaseTypes.*;
	import org.liesmars.flashwebclient.Handler.Draw.DrawRect;

	
	public class lkRequest extends DrawRect
	{
		//pop up request information window
		public var dialog:TitleWindow;      
//		public var textData:TextArea = new TextArea();
	    //the object will be lighted when being selected
		public var pt:Point = new Point();
		public var result:String = "";
		public var n:int = 0;   // count the required objects num
		
		public var rightT:Pixel ;
		public var leftB:Pixel ;
		public var rightB:Pixel ;
		public var leftT:Pixel ;
		public var typename:String;
		private var zoomLevel:int;
		
		public function lkRequest(map:GeoMap,options:Object)
		{
			super(map,options);
		}
		
		public override function extenderFunc(coords:Array):void
		{
			rightT = new Pixel(this.ptCoord[1].x,this.ptCoord[0].y);
			leftB = new Pixel(this.ptCoord[0].x,this.ptCoord[1].y);
			rightB = new Pixel(this.ptCoord[1].x,this.ptCoord[1].y);
			leftT = new Pixel(this.ptCoord[0].x,this.ptCoord[0].y);
			
			this.pt = this.map.sprite.globalToLocal(coords[1]);
			// mark rectangle request area
			var rect:Sprite = new Sprite();
			var graphics:Graphics = rect.graphics;
			this.map.sprite.addChild(rect);
			doRequest(rect);
			graphics.clear();  //控制最后一个矩形擦除与否
		}
		
		private function doRequest(obj:Sprite):void
		{
			n = 0 ; 
			result = "";
			var lyrArr:Array = this.map.layers;
			var typeNames:Array = new Array();
			for(var i:int = 0; i < this.map.layers.length ; i++) //go throught all the layers 
			{
				var URL:String = lyrArr[i].url;
				//judge whether the layer is wfs layer and whether the layer is presented
				if((URL.charAt(URL.length-3)=="w")&&(URL.charAt(URL.length-2)=="f")&&(URL.charAt(URL.length-1)=="s")&&(lyrArr[i].visibility) ) 
				{
					var lyr:Layer = lyrArr[i];   // collect all the required layers
					var object:Object = lyr.params;  //change the Layer.params into  "public"
					typename = object.TYPENAME as String;
					typeNames.push(typename);
				}
			}
			var LT:LonLat = map.getLonLatFromPixel(leftT);
			var RT:LonLat = map.getLonLatFromPixel(rightT);
			var LB:LonLat = map.getLonLatFromPixel(leftB);
			var RB:LonLat = map.getLonLatFromPixel(rightB);
			
			for(i = 0; i < typeNames.length ; i++ )
			{
				var url:String = "http://192.168.2.217:8081/geoserver/wfs";
    		    var request:URLRequest=new URLRequest(url);
    		    request.method="post";
			    var data:String="<wfs:GetFeature service=\"WFS\" version=\"1.0.0\"";
			    data += " outputFormat=\"GML2\"";
			    data += " xmlns:topp=\"http://www.openplans.org/topp\"";
			    data += " xmlns:wfs=\"http://www.opengis.net/wfs\"";
			    data += " xmlns:ogc=\"http://www.opengis.net/ogc\"";
			    data += " xmlns:gml=\"http://www.opengis.net/gml\" ";
			    data += " xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"";
			    data += " xsi:schemaLocation=\"http://www.opengis.net/wfs"
			    data += " http://schemas.opengis.net/wfs/1.0.0/WFS-basic.xsd\">";
			    typename = typeNames[i] as String;
			    data += " <wfs:Query typeName=\""+typename+"\">";
//			    data += " <wfs:Query typeName=\"topp:china_xianshi\">";
//			    data += " <wfs:PropertyName>kml_name</wfs:PropertyName> "  //xianshi
			    if(typename == "topp:china_xianshi") 
			    data += " <wfs:PropertyName>kml_name</wfs:PropertyName> " 
			    else if(typename == "topp:china_xiangzhen"||typename == "topp:china_river") 
			    data += " <wfs:PropertyName>name</wfs:PropertyName> "   //river & xiangzhen
//			    data += " <ogc:PropertyName>styleurl</ogc:PropertyName> "
//			    data += " <wfs:PropertyName>the_geom</wfs:PropertyName> "
			    data += " <ogc:Filter>"
			    data += " <ogc:BBOX> ";
			    data += " <ogc:PropertyName>the_geom</ogc:PropertyName> ";
			    data += " <gml:Box srsName=\"http://www.opengis.net/gml/srs/epsq.xml#4326\">";
			    data += " <gml:coordinates>"+ LT.lon + "," + RB.lat + " " + RB.lon + "," + LT.lat + "</gml:coordinates>";
			    data += " </gml:Box> ";
			    data += " </ogc:BBOX> ";
			    data += " </ogc:Filter>";
			    data += " </wfs:Query>";
			    data += " </wfs:GetFeature>";
			    trace("requestData="+data);
		        request.data=data;//this.getSendData();
		        var loader:URLLoader=new URLLoader();
			    loader.dataFormat=URLLoaderDataFormat.BINARY;//默认就是TEXT
			    loader.addEventListener(Event.COMPLETE,getObjects);//getPoint,getL
			    loader.load(request);
			}
//			if(n<=0)return;
//		    if(!this.dialog)
//			{
//				this.dialog=new TitleWindow();//这里是控件持有引用，不是handler
//				PopUpManager.addPopUp(this.dialog,this.map.sprite,false);
//			}
//			this.dialog.x = this.pt.x;
//			this.dialog.y = this.pt.y;
//		    this.dialog.height = 240;
//			this.dialog.title = "查询信息";
//			this.dialog.showCloseButton = true;
//			this.dialog.addEventListener(CloseEvent.CLOSE,closeWin);	
			
//			if(result)
//			{
//				var textData:TextArea = new TextArea();
//				result = "对象总数:\t"+n+"\r\r"+result;
//				textData.text = result;
//				textData.height = 180;
//				textData.editable = false;
//				this.dialog.addChild(textData);	
//			}
			
    	}
		private function getObjects(e:Event):void
		{
    	    var xml:XML=new XML(e.target.data);
    	    trace(xml);
    	    
    	    var allNames:String = new String();  //deal with the manual broken 
    	    var charNum:int = 0;   // length of allNames 
		    for each (var i:XML in xml.children())
		    {
			    if(i.localName().toString().toUpperCase()=="FEATUREMEMBER")
			    {
				    n++;
				    var xl:XMLList = i.children();			
				    for each(var j:XML in xl.children())
				    {
					    trace(j.localName());
					    if(j.localName().toString()=="name"||j.localName().toString()=="kml_name")
					    {
					    	//when a line object are broken into cuts, there will be several pieces line objects
					    	// share the same names but indeed the composition of the origin line object
					    	//In this situation, we should avoid the presentation of same-naming 
					    	//We settle the problem by checking out if the name strings existed in the total string 
					    	//whose has the entirely selected objects, including the objects sharing same names 
					    	var names:String = j.child(0);
					    	allNames += names;
					    	charNum += names.length;
					    	if((n > 1) && (allNames.indexOf(names) >=0)&&(allNames.indexOf(names)!= (charNum-names.length)))
							{
								n -=1;
								result += "";
								break;
							}
					    	result += "第" + n + "个对象："+ names;
					    	result += "\r";   
					    }
					    if(j.localName().toString()=="the_geom")
					    {
						    result += "坐标："+j.child(0).child(0);
						    result += "\r"; 
						}
				    }
			    }
			}
			if(n<=0)return;
		    if(!this.dialog)
			{
				this.dialog=new TitleWindow();//这里是控件持有引用，不是handler
				PopUpManager.addPopUp(this.dialog,this.map.sprite,true);
			}
			this.dialog.x = this.pt.x;
			this.dialog.y = this.pt.y;
		    this.dialog.height = 240;
			this.dialog.title = "查询信息";
			this.dialog.showCloseButton = true;
			this.dialog.addEventListener(CloseEvent.CLOSE,closeWin);	
			if(result)
			{
				var textData:TextArea = new TextArea();
				result = result + "\r";
				textData.text = result;
				textData.height = 180;
				textData.editable = false;
				//one textArea including all the required objects
				this.dialog.removeAllChildren();
				this.dialog.addChild(textData);   
			}
		}
		
		private function closeWin(event:CloseEvent):void
		{
			PopUpManager.removePopUp(this.dialog);
			this.dialog = null;
			for(var i:int = 0; i < nEffect; i++)
			{
				if(filter[i]) filter[i].filters = null;  //no gradient filter effects when the window is closed
			}
			
		}
		
	}
}