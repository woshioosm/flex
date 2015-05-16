package org.liesmars.flashwebclient
{
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.system.Capabilities;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.controls.Tree;
	
	import org.liesmars.flashwebclient.Index.GridIndex;
	
	/*
	 *封装了全局公共函数 
	 */
	public class Util
	{
		//尽量不要改造核心对象
		private static var index:int=0;
		
		
		
		/*//地球的半径有三个常用值：
		//极半径：是从地心到北极或南极的距离，大约3950英里(6356.9 公里)（两极的差极小，可以忽略）。
		//赤道半径：是从地心到赤道的距离，大约3963英里(6378.5 公里)。
		//平均半径：大约3959英里(6371.3 公里) 。这个数字是地心到地球表面所有各点距离的平均值。
　　		//可以这样求：平均半径=(赤道半径^2×极半径)^(1/3)。
　　		//地球半径有时被使用作为距离单位, 特别是在天文学和地质学中常用。它通常用RE表示。 
		*/
		
		public  static const ER:Number=6371300;//		
		public static var transLevel:Object={"point":1,"line":0.6,"polygon":1};
		public static var color:Object={"point":0xF1B8FC,"line":0xEFFCD4,"polygon":0xC0CDFC	,"polygonborder":0xcc0101};
		public static var thick:Object={"point":1,"line":6,"polygon":1};
		public static var radius:int=4;
		public static const INCH_TO_MM:Number=25.4;
		public static const INCHES_PER_UNIT:Object = { 
													    'inches': 1.0,
													    'ft': 12.0,//1 foot=12 inch by WCZ 4-13 
													    'mi': 63360.0,
													    'm': 39.3701,// ==1/0.0254  1 inch=0.0254 m
													    'km': 39370.1,
													    'degrees': 4374754,//  ==2*PI*R/360*39.3701 (2*PI*R赤道周长 39.3701是英尺和米的对应关系)
													    'yd': 36
													};
		public static const DOTS_PER_INCH:Number=Capabilities.screenDPI; //通常是72px/inch
		 
		// edit by Chzx
		public static var UseLocalMode:Boolean = false;
		public static var UseSymbolization:Boolean = false;
		// AllIndexs保存的是各个图层的索引
		public static var AllIndexs:Array;
		public static var GeoMapIndex:GridIndex;
		public static var vir_geomap:GeoMap;	// ws的做法
		public static var vir_tree:Tree;
		public static var vir_xml:XML;
		
		public static var CELL:uint = 1;	// CELL表示sliderbar每动一格，层改变几级，默认是1
		
		// 最大分辨率
		public static var MAX_RES:Number = 0.0703125;  // ==18/256
		//	arr_layers是来保存
		public static var arr_layers:Array = new Array();  //用来保存每一级 中对应的layer

		public static var sl:SocketLoader;
		public static var LayerChanged:Boolean = false;
		public static var SendingState:Boolean = false;
		public static var oldLayer:Layer;
		public static var httpOK:Boolean = false;
		public static var connectFinish:Boolean = false;
		public static var layerFinish:Boolean = false;
		// 请求队列
		public static var queryQueue:Array = new Array();
/**
 * Function: getResolutionFromScale
 * 
 * Parameters:
 * scale - {Float}
 * units - {String} Index into OpenLayers.INCHES_PER_UNIT hashtable.
 *                  Default is degrees
 * 
 * Returns:
 * {Float} The corresponding resolution given passed-in scale and unit 
 *         parameters.
 */
public static function getResolutionFromScale(scale:Number, units:String = "degrees"):Number {

    var normScale:Number = Util.normalizeScale(scale);//0<=normScale<=1 by WCZ４-14

    var resolution:Number = 1 / (normScale * INCHES_PER_UNIT[units]* DOTS_PER_INCH);
    return resolution;
}


/**
 * Function: getScaleFromResolution
 * 
 * Parameters:
 * resolution - {Float}
 * units - {String} Index into OpenLayers.INCHES_PER_UNIT hashtable.
 *                  Default is degrees
 * 
 * Returns:
 * {Float} The corresponding scale given passed-in resolution and unit 
 *         parameters.
 */
public static function getScaleFromResolution(resolution:Number, units="degress"):Number {
    var scale:Number = resolution * INCHES_PER_UNIT[units] * DOTS_PER_INCH;// scale为比例尺分母 by WCZ 4-13
    return scale;
}


/**
 * Function: normalzeScale
 * 
 * Parameters:
 * scale - {float}
 * 
 * Returns:
 * {Float} A normalized scale value, in 1 / X format. 
 *         This means that if a value less than one ( already 1/x) is passed
 *         in, it just returns scale directly. Otherwise, it returns 
 *         1 / scale
 */
public static function normalizeScale(scale:Number) {
    var normScale:Number = (scale > 1.0) ? (1.0 / scale) 
                                  : scale;
    return normScale;
}
		/*
		//用枚举类GEOTYPES.as代替了这个东西
		//public static const GEOTYPES:Object={"POINR":"point","LINE":"line"};
		*/
		public static  function CreateId(name:String):String
		{
			return name+index++;
		} 
		//功能慢慢添加进来
		public static function SetContextMenu(caps:Array,fns:Array,obj:Object):ContextMenu
		{
			if(caps.length!=fns.length)return null;
			var conMenu:ContextMenu=new ContextMenu();
			conMenu.hideBuiltInItems();
			for(var i:int=0;i<caps.length;i++)
			{
				var conItem:ContextMenuItem=new ContextMenuItem(caps[i],true,true,true);
				conItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fns[i]);
				conMenu.customItems.push(conItem);	
			}		
							
			obj.contextMenu	=conMenu;
			return conMenu;	
		}
		public static function Menu(e:ContextMenuEvent):void
		{
			var conItem:ContextMenuItem=e.target as ContextMenuItem;	
			var conMenu:ContextMenu;
			conItem.enabled=false;
			for(var i:int=0;i<conMenu.customItems.length;i++)
			{
				var cItem:ContextMenuItem=conMenu.customItems[i];
				if((!cItem==conItem) && cItem.enabled==false)cItem.enabled=true;
			}	
		}
		public static function EmptyArray(arr:Array):Array
		{
			while(arr.length>0)
			{
				arr.shift();
			}
			return arr;
		}
		//通过索引移除对象，将非索引处的对象存到数组a中  by wcz
		public static function RemoveAItem(arr:Array,index:int):Array
		{
			if(index<0 || index>=arr.length)return arr;
			var a:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				if(i!=index)a.push(arr[i]);
			}
			return a;
		}
		//移除具体的对象 by wcz
		public static function RemoveItem(arr:Array, item:Object):void {
			for(var i:int=0;i<arr.length;i++)
			{
				if(arr[i]==item) { arr.slice(i,1); break;}
			}
		}
		
		//移除多个连续的对象
		public static function RemoveMutiItems(arr:Array,start:int,end:int):Array
		{
			if(end<start)return arr;
		
			var a:Array=[];
			for(var i:int=0;i<arr.length;i++)
			{
				if(i<start || i>end)a.push(arr[i]);
			}
			return a;
		}
	
		//在数组的某个索引处插入另一个数组，构成一个新数组返回
		public static function InsertArr(index:int,source:Array,arr:Array):Array
		{
			var r:Array=[];	
			if(index==source.length)
			{
				r=source;
				for(var j:int=0;j<arr.length;j++)
				{
					r.push(arr[j]);
				}
			}
			else
			{
				for(var i:int=0;i<source.length;i++)
				{
					if(i==index)
					{
						for(j=0;j<arr.length;j++)
						{
							r.push(arr[j]);
						}
					}				
					r.push(source[i]);							
				}
			}
			return r;
		}		
		
		//检查某个数组中是否包含一个字符串
		public static function ArrContainsStr(arr:Array,str:String):Boolean
		{
			for(var i:int=0;i<arr.length;i++)
			{
				if(str==arr[i] as String) return true;
			}
			return false;
		}
		
		public static function SetOptions(source:Object,options:Object):Object
		{
			if(!options || !source) return null;
			for(var key:Object in options)
			{
				try{
					source[key]=options[key];
				}
				catch(e:Error){trace(e.message);}
			}

			return source;
		}		
		
/**
 * Function: getParameterString
 * 
 * Parameters:
 * params - {Object}
 * 
 * Returns:
 * {String} A concatenation of the properties of an object in 
 *          http parameter notation. 
 *          (ex. <i>"key1=value1&key2=value2&key3=value3"</i>)
 *          If a parameter is actually a list, that parameter will then
 *          be set to a comma-seperated list of values (foo,bar) instead
 *          of being URL escaped (foo%3Abar). 
 */
public static function getParameterString(params:Object):String {
    var paramsArray:Array = [];
    
    for (var key:Object in params) {
      var value:String = params[key];
      if ((value != null) && (typeof value != 'function')) {
        var encodedValue:String;
//        if (typeof value == 'object' && value.constructor == Array) 
          if (typeof value == 'object' && value is Array)
        {
          /* value is an array; encode items and separate with "," */
          var encodedItemArray:Array = [];
          for (var itemIndex:int=0; itemIndex<value.length; itemIndex++) {
            encodedItemArray.push(encodeURIComponent(value[itemIndex]));
          }
          encodedValue = encodedItemArray.join(",");
        }
        else {
          /* value is a string; simply encode */
          encodedValue = encodeURIComponent(value);
        }
        paramsArray.push(encodeURIComponent(key.toString()) + "=" + encodedValue);
      }
    }
    
    return paramsArray.join("&");
}
		
/**
 * Function: getParameters
 * Parse the parameters from a URL or from the current page itself into a 
 *     JavaScript Object. Note that parameter values with commas are separated
 *     out into an Array.
 * 
 * Parameters:
 * url - {String} Optional url used to extract the query string.
 *                If null, query string is taken from page location.
 * 
 * Returns:
 * {Object} An object of key/value pairs from the query string.
 */
public static function getParameters(url:String):Object {
    // if no url specified, take it from the location bar
//    url = url || window.location.href;
	

    //parse out parameters portion of url string
    var paramsString:String = "";
    if (url.indexOf('?') != -1) {
        var start:int = url.indexOf('?') + 1;
        var end:int = (url.indexOf("#") != -1) ?
                    url.indexOf('#') : url.length;
        paramsString = url.substring(start, end);
    }
        
    var parameters:Object = {};
    var pairs:Array = paramsString.split(/[&;]/);
    for(var i:int = 0; i < pairs.length; ++i) {
        var keyValue:Array = pairs[i].split('=');
        if (keyValue[0]) {
            var key:String = decodeURIComponent(keyValue[0]);
            var value:Object = keyValue[1] || ''; //empty string if no value

            //decode individual values
            value = value.split(",");
            for(var j:int=0; j < value.length; j++) {
                value[j] = decodeURIComponent(value[j]);
            }

            //if there's only one value, do not return as array                    
            if (value.length == 1) {
                value = value[0];
            }                
            
            parameters[key] = value;
         }
     }
    return parameters;
}
		
/** 
 * Function: upperCaseObject
 * Creates a new hashtable and copies over all the keys from the 
 *     passed-in object, but storing them under an uppercased
 *     version of the key at which they were stored.
 * 
 * Parameters: 
 * object - {Object}
 * 
 * Returns: 
 * {Object} A new Object with all the same keys but uppercased
 */
public static function upperCaseObject(object:Object):Object {
    var uObject:Object = {};
    for (var key:Object in object) {
        uObject[key.toUpperCase()] = object[key];
    }
    return uObject;
}

/** 
 * Function: applyDefaults
 * Takes an object and copies any properties that don't exist from
 *     another properties, by analogy with OpenLayers.Util.extend() from
 *     Prototype.js.
 * 
 * Parameters:
 * to - {Object} The destination object.
 * from - {Object} The source object.  Any properties of this object that
 *     are undefined in the to object will be set on the to object.
 *
 * Returns:
 * {Object} A reference to the to object.  Note that the to argument is modified
 *     in place and returned by this function.
 */
public static function applyDefaults(toobject:Object, from:Object):Object {

    /*
     * FF/Windows < 2.0.0.13 reports "Illegal operation on WrappedNative
     * prototype object" when calling hawOwnProperty if the source object is an
     * instance of window.Event.
     */
//    var fromIsEvt = typeof window.Event == "function"
//                    && from instanceof window.Event;

    for (var key:Object in from) {
        if (toobject[key] === undefined ||
            (
            //!fromIsEvt && 
            from.hasOwnProperty
             && from.hasOwnProperty(key) && !toobject.hasOwnProperty(key))) {
            toobject[key] = from[key];
        }
    }
//    /**
//     * IE doesn't include the toString property when iterating over an object's
//     * properties with the for(property in object) syntax.  Explicitly check if
//     * the source has its own toString property.
//     */
//    if(!fromIsEvt && from.hasOwnProperty
//       && from.hasOwnProperty('toString') && !to.hasOwnProperty('toString')) {
//        to.toString = from.toString;
//    }
    
    return toobject;
}

/** 
 * Function: indexOf
 * Seems to exist already in FF, but not in MOZ.
 * 
 * Parameters:
 * array - {Array}
 * obj - {Object}
 * 
 * Returns:
 * {Integer} The index at, which the object was found in the array.
 *           If not found, returns -1.
 */
public static function indexOf(array:Array, obj:Object):int {

    for(var i:int=0; i < array.length; i++) {
        if (array[i] == obj) {
            return i;
        }
    }
    return -1;   
}

/**
 * Function: alphaHack
 * Checks whether it's necessary (and possible) to use the png alpha
 * hack which allows alpha transparency for png images under Internet
 * Explorer.
 * 
 * Returns:
 * {Boolean} true if alpha has is necessary and possible, false otherwise.
 */
public static function alphaHack():Boolean {
//    var arVersion = navigator.appVersion.split("MSIE");
//    var version = parseFloat(arVersion[1]);
//    var filter = false;
//    
//    // IEs4Lin dies when trying to access document.body.filters, because 
//    // the property is there, but requires a DLL that can't be provided. This
//    // means that we need to wrap this in a try/catch so that this can
//    // continue.
//    
//    try { 
//        filter = !!(document.body.filters);
//    } catch (e) {
//    }    
//    
//    return ( filter &&
//                      (version >= 5.5) && (version < 7) );
	  return false;
}

//		//当地图的缩放级别达到一定程度的时候可以使用全面坐标来计算，只需要isGlobe=true即可
//		public static function GetLengthFromPts(pts_:Array,isGlobe:Boolean):Number
//		{
//			if(!pts_.length>1)return -1;
//			var pts:Array=[];
//			for(var n:int=0;n<pts_.length-1;n+=2)
//			{
//				pts.push(new Point(pts_[n],pts_[n+1]));
//			}
//			var l:Number=0;
//			if(!isGlobe)//平面距离
//			{
//				for(var i:int=0;i<pts.length-1;i++)
//				{
//					l+=Math.sqrt(Math.pow((pts[i].x-pts[i+1].x),2)+Math.pow((pts[i].y-pts[i+1].y),2));
//				}	
//			}	
//			else//球面距离，经纬度
//			{
//				for(i=0;i<pts.length-1;i++)
//				{
//					//余弦定理
//					var aw:Number=Util.ER*Math.cos(pts[i].y);//Math.pow(Util.ER*Math.cos(pts[i].y),2)+Math.pow(Util.ER*Math.cos(pts[i+1].y),2)-2*Util.ER*Util.ER*Math.cos(pts[i].y)*Util.ER*Util.ER*Math.cos(pts[i+1].y)*Math.cos(pts[i+1].y-pts[i].y);
//					var ah:Number=Util.ER*Math.sin(pts[i].y);
//					var bw:Number=Util.ER*Math.cos(pts[i+1].y);
//					var bh:Number=Util.ER*Math.sin(pts[i+1].y);
//					var angleLon:Number=Math.abs(pts[i].x-pts[i+1].x);
//					var l_w:Number=Math.pow(aw,2)+Math.pow(bw,2)-2*aw*bw*Math.cos(angleLon);
//					//trace(Math.sqrt(l_w));
//					var d_h:Number=Math.sqrt(Math.pow(ah-bh,2)+l_w);
//					//trace(d_h/(2*Util.ER));
//					//trace(Math.asin(d_h/(2*Util.ER)));
//					l+=Util.ER*2*Math.asin(d_h/(2*Util.ER));				
//				}
//			}	
//			return l;
//		}
//		//以第一个点为顶点将多边形分解成多个三角形,多边形可是凸多边形或者凹多边形，但是不可自交
//		//这个算法不错
//		public static function GetPolygonAreaFromPts(pts:Array,isGlobe:Boolean):Number
//		{
//			var area:Number=0;	
//			var p0:Point=new Point(pts[0],pts[1]);	
//			if(!isGlobe)
//			{
//				for(var i:int=2;i<pts.length-3;i+=2)
//				{
//					var p1:Point=new Point(pts[i],pts[i+1]);
//					var p2:Point=new Point(pts[i+2],pts[i+3]);
//				
//					if(p0.x==p2.x && p0.y==p2.y)
//					{
//						break;
//					}			
//					area+=Util.GetTriangleAreaFromPts(p0,p1,p2);
//				}
//			}
//			else//球面上多边形的面积计算还没写完
//			{
//			
//			}
//			return area;
//		}
//		public static function GetTriangleAreaFromPts(p0:Point,p1:Point,p2:Point):Number
//		{
//			return ((p1.x-p0.x)*(p2.y-p0.y)-(p2.x-p0.x)*(p1.y-p0.y))/2;
//		}
//		
//		public static function HaiLun(a:Number,b:Number,c:Number):Number
//		{
//			var p:Number=(a+b+c)/2;
//			return p*(p-a)*(p-b)*(p-c);
//		}
		
		//获取类名,ok
		public static function GetClassName(cls:Object):String 
		{
			return getQualifiedClassName(cls); 
			/*var classNameOfSprite:String = getQualifiedClassName(cls); 
			trace("Sprite 的类名 : " + classNameOfSprite); 
			var superclassNameOfSprite:String = getQualifiedSuperclassName(Sprite); 
			trace("Sprite 的超类 (基类) 类名 : " + superclassNameOfSprite); 
			var SpriteClass:Class = getDefinitionByName(classNameOfSprite) as Class; 
			var sprite2:Sprite = new SpriteClass() as Sprite; 
			trace("sprite2 通过 getDefinitionByName 创建 Sprite 实例"); 
			*/
		}
		public static function GetClassByName(name:String):Class
		{
			return getDefinitionByName(name) as Class; 
		}
		public static function CreateFn(f:Function,... arg):Function
		{
		   var F:Boolean=false;
		   return function(e:*,..._arg):void{
			   _arg=arg;
			   if(!F){F=true;_arg.unshift(e);}
			   f.apply(null,_arg)
		   };		   
		}
		//对Math的补充
		public static function Log(b:Number,t:Number):int
		{
			var r:int=0;
			var big:Boolean=(b>1);
			for(var i:int=0;true;i++)
			{
				if(big)
				{
					if(t/b>1){t=t/b;}
					else {r=i;break;}
				}
				else
				{
					if(t/b<1){t=t/b;}
					else {r=i;break;}
				}
			}
			return r;
		}
		
		public static function GetShpByIdFromCon(con:DisplayObjectContainer,id:String):Array
		{
			var arr:Array=[];		
			for(var i:int=0;i<con.numChildren;i++)
			{
				var o:DisplayObjectContainer=con.getChildAt(i) as DisplayObjectContainer;
				arr.concat(Util.GetShpByIdFromCon(con,id));
			}		
			return arr;
		}
//		public function createSearchPanel(ower:DisplayObjectContainer,list:Array):JFrame
//		{
//			var frame:JFrame=new JFrame(ower,"Search Panel");
//			var com:JComboBox=new JComboBox(list);
//			var btn:JButton=new JButton("send");
//			frame.x=200;frame.y=150;
//			frame.setSizeWH(200, 210);
//	        //frame.getContentPane().append(label, BorderLayout.CENTER);
//	        frame.getContentPane().append(com, BorderLayout.NORTH);
//	        frame.getContentPane().append(btn, BorderLayout.NORTH);
//	        frame.parent.swapChildren(frame, frame.parent.getChildAt( frame.parent.numChildren-1));
//	        frame.show();
//	        
//	        return frame;
//		}
	}

}