package org.liesmars.flashwebclient.Algorithm
{
	internal class Ratio
	{
		public var u1:Number;
		public var u2:Number;
		
		/**
		 * Ratio is only used by LiangBarskyAlgorithm.as.
		 * This class is used to record the u1 & u2 of LiangBarskyAlgorithm.
		 * For more infos of u1 & u2,plz see the LiangBarskyAlgorithm.as :)
		 */ 
		public function Ratio(_u1:Number,_u2:Number)
		{
			u1 = _u1;
			u2 = _u2;
		}
	}
}