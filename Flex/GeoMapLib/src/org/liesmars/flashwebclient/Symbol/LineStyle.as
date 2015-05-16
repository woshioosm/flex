package org.liesmars.flashwebclient.Symbol
{
	public class LineStyle
	{
		public var onLengthL:Number;
		public var onLengthS:Number;
		public var offLength:Number;
		public var nS:uint;
		public function LineStyle(l:Number,s:Number,o:Number,n:uint)
		{
			this.onLengthL=l;
			this.onLengthS=s;
			this.offLength=o;
			this.nS=n;
		}
	}
}