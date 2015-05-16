package org.liesmars.flashwebclient
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.filters.DropShadowFilter;
	

	
	//Control类的子类都还有很大的抽象空间，这里暂时不抽象出来，对于每种空间样式都是可以抽象的，但是过多的抽象会影响性能，暂时不抽象
	/*
	 *控件的抽象类 
	 */
	public class Control extends Sprite
	{
		private var id_:String="";
		public var map:GeoMap;
		public var controls:Array=[];//controls中存储的不是handler而是我们能够看到的一个小控件条上的一个小格子
		public var dragObj:Sprite=null;
		public var isdown:Boolean=false;
		public var position:Number=0;
		public var color:Object={"disabled":0x808080,"enabled":0x339999,"head":0x555,"bgcolor":0xcccccc,"fillcolor":0xff9966,"filldisabled":0xc0c0c0};
		//public var color_enabled:Object={"pointfill":0xcc0101,"pointborder":0x000000,"line":0xcc0101,"polygonfill":0xcc0101,"polygonborder":0xcc0101};
		//public var color_disabled:Object={"pointfill":0x808080,"pointborder":0x000000,"line":0x808080,"polygonfill":0x808080,"polygonborder":0x000000};
		public var type:String;
		private var isEnabled_:Boolean=false;
		private var isActive_:Boolean=false;
		protected var activeHandler_:Handler=null;
		
		public function Control(map:GeoMap,options:Object)
		{
			//this.visible=false;//默认不可见
			this.type=Util.GetClassName(this);
			this.map=map;
			Util.SetOptions(this,options);			
			this.Draw();
			this.InitDrag();
			
			this.bindEveryCtr();	
			this.id_=Util.CreateId(Util.GetClassName(this));		
		}
		
		//其实对于handler的激活完全可以 通过control.name得到需要激活的handler
		public function Enable():void
		{
			this.isEnabled_=true;
		}
		//让控件失效
		public function Disable():void
		{
			this.isEnabled_=false;
			
		}
		public function get isActive():Boolean
		{
			return this.isActive_;
		}
		public function Active():void
		{
			this.isActive_=true;
		}
		//取消所有点击控件上按钮之后绑定的事件  迈陂塘
		//取消单个控件面板中当前活动的控件
		public function Deactive():void
		{
			for(var i:int=0;i<this.controls.length;i++)
			{
				var s:Sprite=this.controls[i] as Sprite;
				s.filters=[];
			}
			if(this.activeHandler_)this.activeHandler_.Deactive();
			this.isActive_=false;
		}
		public function Show():void
		{this.visible=true;}
		//将控件绘制出来,必须实现，否则dragObj为空,代码不够精炼，至少head部分还可以提取出来
		//所有单个的小控件大小都是24*24
		public function Draw():void
		{
			if(!this.dragObj)this.dragObj=this;
		}
		public function Clear():void
		{
			while(this.numChildren>0)
			{
				this.removeChild(this.getChildAt(0));
			}
			this.graphics.clear();
		}
		public function Hide():void
		{
			this.visible=false;
		}
		
		public function InitDrag():void
		{
			if(this.dragObj)
			{
				this.dragObj.addEventListener(MouseEvent.MOUSE_DOWN,mousedown,false,0,true);
				this.dragObj.addEventListener(MouseEvent.MOUSE_UP,mouseup,false,0,true);
			}
		}		
		
		public function mousedown(e:MouseEvent):void
		{
			if(!this.isdown)
			{
				this.isdown=true;
				this.startDrag();
			}
		}
		public function mouseup(e:MouseEvent):void
		{
			if(this.isdown)
			{
				this.isdown=false;
				this.stopDrag();
			}
		}
		
		//给每个handler绑定的，但是不是每个可以在空间条上看到的东西都会有一个handler类与之绑定
		public function bindEveryCtr():void
		{
			for(var i:int=0;i<this.controls.length;i++)
			{
				var s:Sprite=this.controls[i] as Sprite;
				s.addEventListener(MouseEvent.CLICK,click,false,0,true);
			}			
		}
		public function click(e:MouseEvent):void
		{
			var t:Sprite=e.target as Sprite;
			for(var i:int=0;i<this.controls.length;i++)
			{
				var s:Sprite=this.controls[i] as Sprite;
				if(s==t)
				{
					//s.alpha=1;
					var f:DropShadowFilter=new DropShadowFilter();
					f.alpha=1;
					f.blurX=-1;
					f.blurY=0;
					f.color=0xf7f7f7;
					f.strength=2;
					f.distance=0;
					
					s.filters=[f];
				}
				else
				{
					//s.alpha=0.5;
					s.filters=[];
				}
			}
			this.Active();
		}
		public function Destroy():void
		{
			//controls,map,绑定的事件均需要销毁
		}
		public function get id():String
		{
			return this.id_;
		}
		public function get isEnabled():Boolean
		{return this.isEnabled_;}
		public function get activeHandler():Handler
		{
			return this.activeHandler_;
		}
	}
	
}