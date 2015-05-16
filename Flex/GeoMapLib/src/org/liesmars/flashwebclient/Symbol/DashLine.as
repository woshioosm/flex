package org.liesmars.flashwebclient.Symbol
{
	public class DashLine
	{
		public var target:Object;		
		public var _curveaccuracy:Number = 6;  //?
			
		private var isLine:Boolean = true;
		private var overflow:Number = 0;
		private var offLength:Number = 0;
		private var onLength:Number = 0;
		private var dashLength:Number = 0;
		private var pen:Object;
		
		function DashLine(target:Object, onLength:Number, offLength:Number){
			this.target = target;
			this.setDash(onLength, offLength);
			this.isLine = true;
			this.overflow = 0;
			this.pen = {x:0, y:0};
		}
		
		public function setDash(onLength:Number, offLength:Number):void {
			this.onLength = onLength;
			this.offLength = offLength;
			this.dashLength = this.onLength + this.offLength;  //黑白段之和为dash的单位长度
	   }
	   
	   public function getDash():Array {
			return [this.onLength, this.offLength];
	 	}
	 	public function moveTo(x:Number, y:Number):void {
			this.targetMoveTo(x, y);
		}
		
		public function lineTo(x:Number,y:Number):void {
			
			var dx:Number= x-this.pen.x;
			var	dy:Number = y-this.pen.y;
//			var a:Number = Math.atan2(dy, dx);  //拐角
//			var ca:Number= Math.cos(a);
//			var sa:Number = Math.sin(a);
			var segLength:Number = this.lineLength(dx, dy);  //区段长度
			var ca:Number = dx/segLength;
			var sa:Number = dy/segLength;
			
			if (this.overflow){
				if (this.overflow > segLength){  //区段小于上一次的余段
					if (this.isLine) 
						this.targetLineTo(x, y);
					else 
						this.targetMoveTo(x, y);
						
					this.overflow -= segLength;
					
					return;
				}
				//区段大于余段，则先将不足的补齐
				if (this.isLine) 
					this.targetLineTo(this.pen.x + ca*this.overflow, this.pen.y + sa*this.overflow);
				else 
					this.targetMoveTo(this.pen.x + ca*this.overflow, this.pen.y + sa*this.overflow);
					
				segLength -= this.overflow;
				this.overflow = 0;
				this.isLine = !this.isLine;
				
				if (!segLength)
					return;
			}
			
			var fullDashCount:Number = Math.floor(segLength/this.dashLength);  //整段数
			if (fullDashCount){   //整段数绘制
				
				var onx:Number = ca*this.onLength;
				var ony:Number = sa*this.onLength;
				var offx:Number = ca*this.offLength;
				var offy:Number = sa*this.offLength;
				
				for (var i:Number=0; i<fullDashCount; i++){
					
					if (this.isLine){     //绘制黑段
						this.targetLineTo(this.pen.x+onx, this.pen.y+ony);
						this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
					}else{     //绘制白段（不进行绘制）
						this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
						this.targetLineTo(this.pen.x+onx, this.pen.y+ony);
					}
				}
				segLength -= this.dashLength*fullDashCount;
			}
			if (this.isLine){    //讨论不足一个单位的余段绘制(黑段开始)
				if (segLength > this.onLength){  //余段大于黑段单位：先绘黑段再绘不足一个白段单位的白段
					this.targetLineTo(this.pen.x+ca*this.onLength, this.pen.y+sa*this.onLength);
					this.targetMoveTo(x, y);
					this.overflow = this.offLength-(segLength-this.onLength);  //区段绘制完毕后不足的白段
					this.isLine = false;       //下一区段开始为绘制白段
				}else{                        //余段小于一个黑段单位：直接绘黑段
					this.targetLineTo(x, y);
					if (segLength == this.onLength){    //余段为一个黑段单位
						this.overflow = 0;
						this.isLine = !this.isLine;    //下一区段开始绘白段
					}else{                    //余段不足一个黑段单位
						this.overflow = this.onLength-segLength;   //不足一个单位的余黑段（下一区段绘制时补足）
						this.targetMoveTo(x, y);
					}
				}
			}else{               //讨论不足一个单位的余段绘制(白段开始)
				if (segLength > this.offLength){
					this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
					this.targetLineTo(x, y);
					this.overflow = this.onLength-(segLength-this.offLength);
					this.isLine = true;
				}else{
					this.targetMoveTo(x, y);
					if (segLength == this.offLength){
						this.overflow = 0;
						this.isLine = !this.isLine;
					}else this.overflow = this.offLength-segLength;
				}
			}
		}
		public function clear():void {
			this.target.clear(); 
		}
		public function lineStyle(thickness:Number,rgb:Number,alpha:Number):void {
			this.target.lineStyle(thickness,rgb,alpha);
		}
		private function lineLength(sx:Number, sy:Number, ex:Number = NaN, ey:Number = NaN):Number {
			if (arguments.length == 2) return Math.sqrt(sx*sx + sy*sy);
			var dx:Number = ex - sx;
			var dy:Number = ey - sy;
			return Math.sqrt(dx*dx + dy*dy);
		}
		private function targetMoveTo(x:Number, y:Number):void {
			this.pen = {x:x, y:y};
			this.target.moveTo(x, y);
		}
		private function targetLineTo(x:Number, y:Number):void {
			if (x == this.pen.x && y == this.pen.y) return;
			this.pen = {x:x, y:y};
			this.target.lineTo(x, y);
		}
	}
}