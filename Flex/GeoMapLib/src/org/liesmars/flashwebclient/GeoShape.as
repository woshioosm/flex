package org.liesmars.flashwebclient
{
	import flash.display.Sprite;
    //需要让这个显示组件尽可能的轻量级一点
    /*
	 *矢量对象的绘制容器 
	 */
	public class GeoShape extends Sprite
	{
		private var id_:String;
		private var coords_:Object;//存储坐标
		private var geotype_:String;//存储数据类型
		private var featuretype_:String;
		//public  var graphics:Graphics=new Shape().graphics;;
		private var attributes_:Object;
//		private var _note:Note=null;
		// updated by chzx
		private var center_:Array = new Array();
		private var rotated_:Boolean = false;
		private var isLLcoords_:Boolean = true;	
		private var fromServer_:Boolean = false;	
		
		public var colorCode:Number=0;
//		// updated by chzx 用于编辑中去掉多余的点
//		private var delPts_:Array = new Array();
//		private var delAddedPts_:Array = new Array();
		
		public function GeoShape()
		{
			this.id_=Util.CreateId(Util.GetClassName(this));
		}
		
//		[Bindable("coordsChanged")]
//		[Inspectable(category="General", defaultValue="", format="File")]
		public function set coords(value:Object):void
		{
			this.coords_=value;
//			dispatchEvent(new Event("coordsChanged"));
		}
		public function get id():Object
		{
			return this.id_;
		}
		
//		public function set delPts(value:Array):void{
//			this.delPts_ = value;
//		}
//		
//		public function get delPts():Array{
//			return this.delPts_;
//		}
//		
//		public function set delAddedPts(value:Array):void{
//			this.delAddedPts_ = value;
//		}
//		
//		public function get delAddedPts():Array{
//			return this.delAddedPts_;
//		}

        public function set fromServer(value:Boolean):void{
        	this.fromServer_ = value;
        }
        
        public function get fromServer():Boolean{
        	return this.fromServer_;
        }
		
        public function set isLLcorrds(value:Boolean):void{
        	this.isLLcoords_ = value;
        }

		public function get isLLcoords():Boolean{
			return this.isLLcoords_;
		}	
		
		public function set rotated(value:Boolean):void{
				this.rotated_ = value;
		}
		
		public function get rotated():Boolean{
			return this.rotated_;
		}
		
		public function set center(value:Array):void{
			this.center_ = value;
		}
		
		public function get center():Array{
			return this.center_;
		}
		
		public function get coords():Object
		{
			return this.coords_;
		}
		
		public function set geotype(value:String):void
		{
			this.geotype_=value;
		}
		public function get geotype():String
		{
			return this.geotype_;
		}
		public function set featuretype(value:String):void
		{
			this.featuretype_=value;
		}
		public function get featuretype():String
		{
			return this.featuretype_;
		}
		public function set attributes(v:Object):void
		{
			this.attributes_=v;
		}
		public function get attributes():Object
		{
			return this.attributes_;
		}
//		public function get note():Note
//		{
//			return this._note;
//		}
//		public function set note(n:Note):void
//		{
//			if(this._note){this.note.parent.removeChild(this._note);}
//			this._note=n;
//			
//			if(this.geotype_.toUpperCase().indexOf("POINT")>=0)
//			{PointNote(n);}
//			else if(this.geotype_.toUpperCase().indexOf("LINE")>=0)
//			{LineNote(n);}
//			else if(this.geotype_.toUpperCase().indexOf("POLYGON")>=0)
//			{PolygonNote(n);}	
//					
//			this.addChild(this._note);
//		}
//		
//		public function PointNote(n:Note):void
//		{
//			var noteWidth:Number=(n.txtFields[0] as  TextField).textWidth;
//			var noteHeight:Number=(n.txtFields[0] as  TextField).textHeight;
//			var x:Number=(n.txtFields[0] as  TextField).x;
//			var y:Number=(n.txtFields[0] as  TextField).y;
//			var rec:Rectangle=new Rectangle(x+32,y,noteWidth,noteHeight);
//			if(this.PosAvoid(rec,this))//是否需要避让
//			{
//				rec.y=n.y+32;
//				if(this.PosAvoid(rec,this))
//				{
//					rec.x=x-noteWidth;
//					if(this.PosAvoid(rec,this))
//					{
//						rec.y=n.y;
//						if(this.PosAvoid(rec,this))
//						{n.visible=false;}
//					}
//				}
//			}
//			if(n.visible)
//			{
//				this._note.x=rec.x;
//				this._note.y=rec.y;
//			}
//		}
//		//涉及到多线的情况，目前只当作简单的线，我们从x,y两个方向进行双向冒泡
//		public function LineNote(n:Note):void
//		{
//			var arr:Array=this.coords_ as Array;
//			
//		}
//		public function PolygonNote(n:Note):void
//		{
//			var arr:Array=this.coords_ as Array;
//		}
//		//是否需要避让，这个函数完全可以放到Util中以减少内存占用
//		public function PosAvoid(rec:Rectangle,pt:GeoShape):Boolean
//		{
//			var p:Vector=pt.parent as Vector;
//			var map:GeoMap=p.map;
//			var lyrs_n:Number=map.layerContainer.numChildren;
//			for(var i:int=0;i<lyrs_n;i++)//每个图层
//			{
//				var aLyr:Vector=map.layerContainer.getChildAt(i) as Vector;
//				if(aLyr) {
//					var c_n:Number=aLyr.sprite.numChildren;
//					for(var j:int=0;j<c_n;j++)
//					{
//						var gShape:GeoShape=aLyr.sprite.getChildAt(j) as GeoShape;
//						var n:Note=gShape.note;
//						if(!n)continue;
//						
//						
//						//其实这里要搞个循环之类的，因为线和面一般不止包含一个字符
//						
//						//var nRec:Rectangle=new Rectangle(n.x,n.y,n.noteWidth,n.noteHeight);
//						var noteWidth:Number=(n.txtFields[0] as  TextField).textWidth;
//						var noteHeight:Number=(n.txtFields[0] as  TextField).textHeight;
//						var x:Number=(n.txtFields[0] as  TextField).x;
//						var y:Number=(n.txtFields[0] as  TextField).y;
//						var nRec:Rectangle=new Rectangle(x,y,noteWidth,noteHeight);
//						if(rec.intersects(nRec))
//						return true;
//					}	
//				}
//
//			}
//			return false;
//		}
	}
}