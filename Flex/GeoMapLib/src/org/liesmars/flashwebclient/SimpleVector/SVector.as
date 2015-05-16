package org.liesmars.flashwebclient.SimpleVector
{
	import flash.display.Graphics;
	
	import org.liesmars.flashwebclient.BaseTypes.LonLat;
	import org.liesmars.flashwebclient.BaseTypes.Pixel;
	import org.liesmars.flashwebclient.GeoMap;
	
	public class SVector
	{
		private var coords_:Array = new Array();//存储坐标
		protected var map:GeoMap;
		private var name_:String;
		private var geotype_:String;
		private var bbox_:Array;
		private var featuretype_:String;
		private var attributes_:Object;
		
		public function SVector(_map:GeoMap)
		{
			map = _map;
		}
		
		public function get coords():Array{
			return this.coords_;
		}
		
		public function set coords(value:Array):void{
			this.coords_ = value;
		}
		
		public function draw(g:Graphics):void{
		}
		
		public function PData(pts:Array):Array{
        	for(var i:uint=0;i<pts.length-1;i=i+2)
        	{   
        		var px:Pixel = this.map.getLayerPxFromLonLat(new LonLat(pts[i], pts[i+1]));
        		pts[i] = px.x;
        		pts[i+1] = px.y;
        	}			
        	return pts;
	    }
	    
	    public function get name():String{
	    	return name_;
	    }
	    public function set name(value:String):void{
	    	this.name_ = value;
	    }
	    
	    public function get geotype():String{
	    	return geotype_;
	    }
	    public function set geotype(value:String):void{
	    	geotype_ = value;
	    }
	    
	    public function get bbox():Array{
	    	return bbox_;
	    }
	    public function set bbox(value:Array):void{
	    	bbox_ = value;
	    }

		public function get featuretype():String{
			return featuretype_;
		}
		public function set featuretype(value:String):void{
			featuretype_ = value;
		}
		
		public function get attributes():Object{
			return attributes_;
		}
		public function set attributes(value:Object):void{
			attributes_ = value;
		}
	}
}