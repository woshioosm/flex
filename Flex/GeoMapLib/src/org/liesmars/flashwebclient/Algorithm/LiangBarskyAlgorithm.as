package org.liesmars.flashwebclient.Algorithm
{
	/**
	 * This is class is created for implementing the LiangBarskyAlgorithm
	 * to increase the efficient when doing the symbolization!
	 */ 
	public class LiangBarskyAlgorithm
	{
//		private static var source:Array;
//		private static var L:int;
//		private static var R:int;
//		private static var B:int;
//		private static var T:int;
		
		public function LiangBarskyAlgorithm()
		{
		}
		
		/**
		 * need to complete the comments!!!
		 */
		public static function clip_liang_barsky(x1:Number,y1:Number,x2:Number,y2:Number,clip_box:Array):Array{
			// initialize the ratio
			var ratio:Ratio = new Ratio(0,1);
			var dx:Number = x2 - x1;
			var dy:Number;
			if(clip(-1*dx,x1-clip_box[0],ratio)){
				if(clip(dx,clip_box[2]-x1,ratio)){
					dy = y2 - y1;
					if(clip(-1*dy,y1-clip_box[1],ratio)){
						if(clip(dy,clip_box[3]-y1,ratio)){
							if(ratio.u2<1.0){
								x2 = x1 + ratio.u2*dx;
								y2 = y1 + ratio.u2*dy;
							}
							if(ratio.u1>0.0){
								x1 = x1 + ratio.u1*dx;
								y1 = y1 + ratio.u1*dy;
							}
							return [x1,y1,x2,y2];
						}
					}
				}
			}
			return null;
		}
		
		/**
		 * clip used to test the boundary
		 * need to complete the comments!
		*/
		private static function clip(p:Number,q:Number,_ratio:Ratio):int{
			var flag:int = 1;	//0 hidden, 1 visible
			var r:Number;
			if(p<0.0){
				r = q/p;
				if(r>_ratio.u2){
					flag = 0;
				}
				else if(r>_ratio.u1){
					_ratio.u1 = r;
				}
			}
			else if(p>0.0){
				r = q/p;
				if(r<_ratio.u1){
					flag = 0;
				}
				else if(r<_ratio.u2){
					_ratio.u2 = r;
				}
			}
			else if(q<0.0){
				flag = 0;
			}
			return flag;
		}
		
		/**
		 * to be continued!!!
		*/
		public static function clip_plg(source:Array,rect:Array,isOutRing:Boolean = true):Array{
			// flag 用于判断上一条线是否至少有部分在可视区域内
			var flag:Boolean = true;
			var result:Array = new Array();
			for(var i:int=0;i<source.length;i=i+2){
				var tmp:Array = clip_liang_barsky(source[i],source[i+1],source[i+2],source[i+3],rect);
				if(tmp && tmp.length == 4){
					if(flag || result.length == 0){
						result.push(tmp[0],tmp[1],tmp[2],tmp[3]);
					}
					else{
						// 对于当前线段，只考虑进入
						var x1:Number = tmp[0];
						var y1:Number = tmp[1];
						var x2:Number = tmp[2];
						var y2:Number = tmp[3];
						var dx:Number = x2 - x1;
						var dy:Number = y2 - y1;
						var location:int = -1;
						if(dx>0){
							// 0
							if(x1 == rect[0]){ // 从左边界进入
								location = 0;
							}
						}
						else{
							// 1
							if(x1 == rect[2]){	// 从右边界进入
								location = 2;
							}
						}
						
						if(dy>0){
							if(y1 == rect[1]){	// 从上边界进入
								location = 1;
							}
						}
						else{
							if(y1 == rect[3]){	// 从下边界进入
								location = 3;
							}
						}
						
						
						var prex1:Number = result[result.length-4];
						var prey1:Number = result[result.length-3];
						var prex2:Number = result[result.length-2];
						var prey2:Number = result[result.length-1];
						var predx:Number = prex2 - prex1;
						var predy:Number = prey2 - prey1;
						var prelocation:int = -1;
						if(predx>0){ 
							if(prex2 == rect[2]){	//	从右边界出来
								prelocation = 2;
							}
						}
						else{
							if(prex2 == rect[0]){	//	从左边界出来
								prelocation = 0;
							}
						}
						if(predy>0){
							if(prey2 == rect[3]){	//	从下边界出来
								prelocation = 3;
							}
						}
						else{
							if(prey2 == rect[1]){	//	从上边界出来
								prelocation = 1;
							}
							
						}
					}
				}
				
			}
			return result;
		}
		
	}
}