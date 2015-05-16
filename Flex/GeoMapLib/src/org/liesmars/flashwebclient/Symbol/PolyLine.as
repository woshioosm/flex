package org.liesmars.flashwebclient.Symbol
{
	public class PolyLine
	{
		public var target:Object;		
		public var _curveaccuracy:Number = 6;  //?
			
        //private var typeArr:Array = [0,1,2,3];
        private var type:Number= new Number();
		private var overflow:Number = 0;    //余段
		public var offLength:Number = 0;    //间隙
		public var onLengthL:Number = 0;    //长段
		public var onLengthS:Number = 0;    //短段
		public var nS:uint= 0;    //短段段数
		private var cantonLength:Number = 0;    //一个单元长
		private var pen:Object;	
		
		public function PolyLine(target:Object, onLengthL:Number, onLengthS:Number,nS:uint,offLength:Number):void
		{
			this.target = target;
			this.setCanton(onLengthL,onLengthS, nS,offLength);			
			this.type = 0;
			this.overflow = 0;
			this.pen = {x:0, y:0};
			//if(nS!=1 && nS!=2) return;
		}
		
		public function setCanton(onLengthL:Number, onLengthS:Number,nS:uint,offLength:Number):void {
			this.onLengthL = onLengthL;
			this.onLengthS = onLengthS;
			this.nS=nS;
			this.offLength = offLength;
			this.cantonLength = this.onLengthL + this.onLengthS * this.nS + this.offLength * ( this.nS + 1);  //单位长度
		}
		
		public function getCanton():Array {
			return [this.onLengthL, this.onLengthS, this.nS, this.offLength];
	    }
	   
	    public function moveTo(x:Number, y:Number):void {
			this.targetMoveTo(x, y);
//			trace(x,y)
	    }
	   
	     public function lineTo(x:Number,y:Number):void {
			
			var dx:Number= x-this.pen.x;
			var	dy:Number = y-this.pen.y;
			var a:Number = Math.atan2(dy, dx);  
			var ca:Number= Math.cos(a);
			var sa:Number = Math.sin(a);
			var segLength:Number = this.lineLength(dx, dy);  //区段长度
			
			if (this.overflow){
				//区段小于上一次的余段
				if (this.overflow > segLength){  
					if (this.type ==0 || this.type ==2) 
						this.targetLineTo(x, y);
					else if(this.type==1 || this.type ==3)
						this.targetMoveTo(x, y);
					this.overflow -= segLength;
					return;
				}
				//区段大于余段，则先将不足的补齐
				if (this.type==0 || this.type ==2){ 
					this.targetLineTo(this.pen.x + ca*this.overflow, this.pen.y + sa*this.overflow);
					this.type +=1;
				}
				else{
					this.targetMoveTo(this.pen.x + ca*this.overflow, this.pen.y + sa*this.overflow);
					if(this.type==3) this.type=0;
					else this.type +=1;
				}
				segLength -= this.overflow;
				this.overflow = 0;

				if (!segLength)
					return;
			}
			
				var fullCantonCount:Number = Math.floor(segLength/this.cantonLength);  //整段数
				if (fullCantonCount){   //整段数绘制
				
					var onLx:Number = ca*this.onLengthL;
					var onLy:Number = sa*this.onLengthL;
					var onSx:Number = ca*this.onLengthS;
					var onSy:Number = sa*this.onLengthS;
					var offx:Number = ca*this.offLength;
					var offy:Number = sa*this.offLength;
				
					for (var i:Number=0; i<fullCantonCount; i++){
				   		if(this.nS==0){  //无短段时
							if (this.type == 0){     //绘制长段
								this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
								this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
							}
							else if(this.type == 1){     //先绘制空格后绘制长段
								this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
								this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
							}
				   		}
				   		else{  //有短段时
				      		if(this.type == 0){  //长段起始
				      			this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
				      			this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
				      			this.targetLineTo(this.pen.x+onSx, this.pen.y+onSy);
				      			this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
				      		}
				      		if(this.type ==1){  //空格起始
				      	   		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
				      	   		this.targetLineTo(this.pen.x+onSx, this.pen.y+onSy);
                           		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
                           		this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
				      		}	
				      		if(this.type ==2){   //短段起始
				      	   		this.targetLineTo(this.pen.x+onSx, this.pen.y+onSy);
                           		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
                           		this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
                           		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
				      		}
				      		if(this.type ==3){    //空格起始
				      	   		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
                           		this.targetLineTo(this.pen.x+onLx, this.pen.y+onLy);
                           		this.targetMoveTo(this.pen.x+offx, this.pen.y+offy);
                           		this.targetLineTo(this.pen.x+onSx, this.pen.y+onSy);
				      		}
				   		}
					}
					segLength -= this.cantonLength*fullCantonCount;
				}
				if (this.type == 0){    //讨论不足一个单位的余段绘制长段开始)
					if (segLength > this.onLengthL){  //余段大于长段单位：先绘长段
						this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
						segLength-=this.onLengthL;
						if(segLength < this.offLength) { //余段小于空格单位
							this.targetMoveTo(x, y);
							this.overflow = this.offLength-segLength;  //区段绘制完毕后不足的白段
							this.type=1
						}
					 	else if(segLength == this.offLength){  //余段大于空格单位
							this.targetMoveTo(x, y); //绘完空格，之后的以一个短段加空格为单位
							this.overflow=0;
							this.type=2;
						}
						else if(segLength<(this.offLength+this.onLengthS)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow=this.offLength+this.onLengthS-segLength;
							this.type=2;
						}
						else if(segLength==(this.offLength+this.onLengthS)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow=0;
							this.type=3;
						}
						else if(segLength<(2*this.offLength+this.onLengthS)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(x,y);
							this.overflow=(2*this.offLength+this.onLengthS)-segLength;
							this.type=3;
						}
						else if(segLength==(2*this.offLength+this.onLengthS)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(x,y);
							this.overflow=0;
							this.type=0;
						}
						
					}
					else{                        //余段小于一个长段单位：直接绘长段
						this.targetLineTo(x, y);
						if (segLength == this.onLengthL){    //余段为一个黑段单位
							this.overflow = 0;
							this.type = 1;    //下一区段开始绘挨着的空格
						}else{                    //余段不足一个长段单位
							this.overflow = this.onLengthL-segLength;   //不足一个单位的余黑段（下一区段绘制时补足）
							this.targetMoveTo(x, y);
						}
					}
				}else if(this.type == 1){               //讨论不足一个单位的余段绘制(空格开始)
					if (segLength > this.offLength){  //第一个空格开始
						this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
						segLength -= this.offLength;
						if(segLength < this.onLengthS){
					   		this.targetLineTo(x, y);
					   		this.overflow = this.onLengthS-segLength;
					   		this.type = 2;
						}
						else if(segLength == this.onLengthS){
							this.targetLineTo(x, y);
					    	this.overflow = 0;
					    	this.type = 3;
						}
						else if(segLength < (this.onLengthS+this.offLength)){
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(x,y);
							this.overflow= this.offLength - (segLength-this.onLengthS);
							this.type=3;
						}
						else if((segLength - this.onLengthS)==this.offLength){
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(x,y);
							this.overflow=0;
							this.type=0;
						}
						else if((segLength - this.onLengthS-this.offLength)>0 &&(segLength - this.onLengthS-this.offLength)<this.onLengthL ){
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = this.onLengthL -(segLength - this.onLengthS-this.offLength);
							this.type=0;
						}
						else if((segLength - this.onLengthS-this.offLength)==this.onLengthL){
							this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = 0;
							this.type=1;
						}
					}
					else{
						this.targetMoveTo(x, y);
						if (segLength == this.offLength){
							this.overflow = 0;
							this.type = 2 ;
						}else {
							this.overflow = this.offLength-segLength;
						}
					}
				}
				else if(this.type == 2){
					if(segLength>this.onLengthS){
						this.targetLineTo(this.pen.x+ca*this.onLengthS, this.pen.y+sa*this.onLengthS);
						segLength -=this.onLengthS;
						if(segLength<this.offLength){
							this.targetMoveTo(x,y);
							this.overflow = this.offLength - segLength;
							this.type =3;
						}else if(segLength == this.offLength){
							this.targetMoveTo(x,y);
							this.overflow = 0;
							this.type = 0;
						}else if(segLength < (this.offLength + this.onLengthL) && segLength > this.offLength){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = this.offLength+this.onLengthL - segLength;
							this.type=0;
						}else if(segLength == this.offLength + this.onLengthL){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = 0;
							this.type=1;
						}else if(segLength > (this.offLength + this.onLengthL) && segLength < (2*this.offLength + this.onLengthL)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetMoveTo(x,y);
							this.overflow = (2*this.offLength + this.onLengthL)-segLength;
							this.type=1;
						}else if(segLength == (2*this.offLength + this.onLengthL)){
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetLineTo(x,y);
							this.overflow=0;
							this.type=2;
						}
					}
					else{
						this.targetLineTo(x,y);
						if (segLength == this.onLengthS){
							this.overflow = 0;
							this.type = 3 ;
						}else{
							this.overflow = this.onLengthS-segLength;
						} 
					}
				
				}
				else if(this.type ==3){
					if(segLength > this.offLength){
						this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
						segLength-=this.offLength;
						if(segLength<this.onLengthL){
							this.targetLineTo(x,y);
							this.overflow= this.onLengthL - segLength;
							this.type=0;
						}else if(segLength==this.onLengthL){
							this.targetLineTo(x,y);
							this.overflow=0;
							this.type=1;
						}else if(segLength>this.onLengthL && segLength<(this.onLengthL+this.offLength)){
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetMoveTo(x,y);
							this.overflow=(this.onLengthL+this.offLength)-segLength;
							this.type=1;					
						}else if(segLength==(this.onLengthL+this.offLength)){
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetMoveTo(x,y);
							this.overflow=0;
							this.type=2;
						}else if(segLength>(this.onLengthL+this.offLength) && segLength<(this.onLengthL+this.offLength+this.onLengthS)){
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = (this.onLengthL+this.offLength+this.onLengthS)-segLength;
							this.type=2;
						}else if(segLength==(this.onLengthL+this.offLength+this.onLengthS)){
							this.targetLineTo(this.pen.x+ca*this.onLengthL, this.pen.y+sa*this.onLengthL);
							this.targetMoveTo(this.pen.x+ca*this.offLength, this.pen.y+sa*this.offLength);
							this.targetLineTo(x,y);
							this.overflow = 0;
							this.type=3;
						}
					}
					else{
						this.targetMoveTo(x,y);
						if(segLength == this.offLength){
							this.overflow=0;
							this.type=0;
						}else{
							this.overflow = this.offLength -segLength;
						} 
					
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