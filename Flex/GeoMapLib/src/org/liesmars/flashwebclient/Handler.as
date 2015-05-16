package org.liesmars.flashwebclient
{
	
	//处理事件
	/*
	 *抽象类，按照功能封装鼠标事件 
	 */
	public class Handler
	{
		public var events:Array=["mousemove","mousedown","mouseup","mouseover","mouseout","mousewheel","click","doubleclick"];		
		public var mstate:Object={"isdown":false,"x":0,"y":0};	//不会装箱拆箱
		public var map:GeoMap;
		
		private var isActive_:Boolean=false;
		
		private var id_:String;
		public function Handler(map:GeoMap,options:Object)//初始化时候把this.canvas传进去	
		{
			this.map=map;			
			Util.SetOptions(this,options);
			this.id_=Util.CreateId(Util.GetClassName(this));
		}	
		
		public function Active():void{
			this.isActive_=true;
		}
		
		public function Deactive():void{
			this.isActive_=false;
		}
		
		public function get isActive():Boolean
		{
			return this.isActive_;
		}
		public function Destroy():void
		{
		}
		public function get id():Object
		{
			return this.id_;
		}
	
	}
}