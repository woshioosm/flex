package com.poyanghu.wfs.util
{
	import mx.collections.ArrayCollection;
	public class PropertyNameBuilder
	{
		/**
		 * 传进来的ArrayCollection应格式如下
		 * 成员为Object类型的关联数组，每个Object中包含有key为property的项，代表对应的propertyName.
		 */ 
		public static function buildFromArrayCollection(attributes:ArrayCollection):String
		{
			try
			{
				if(attributes == null)
				{
					return "";
				}
				var count:int = attributes.length;
				if(count == 0)
				{
					return "";
				}
				
				var arr:Object = null;
				var filter:String = "";
				for(var i:int = 0;i<count;i++)
				{
					arr = attributes.getItemAt(i);
					filter+="<wfs:PropertyName>"+arr["field"]+"</wfs:PropertyName>";
				}
				return filter;
			}
			catch(e:Error)
			{
			}
			return "";
		}
	}
}