package cn.edu.whu.liesmars.asPack.fusionSpirit
{
	import mx.collections.ArrayCollection;
	
	import valueObjects.RSRelatedEdge;
	import valueObjects.RelatedModel;

	public class FusionRelatedUtil
	{
		public var vertices:Vector.<Vertex>;  //存放所有点
		public var edge:Vector.<Vector.<RSRelatedEdge>>; //存放所有边
		public var part:ArrayCollection;  //存放关系块
	
		private var relatedModel:RelatedModel;
		private var pointList:ArrayCollection;
		private var edgeList:ArrayCollection;
		private var pointNum:int;
		
		public function FusionRelatedUtil(relatedModel:RelatedModel)
		{
			this.pointNum=relatedModel.points.length;
			this.relatedModel=relatedModel;
		}
		public function constructEdge():void{
			pointList=relatedModel.points;
			edgeList=relatedModel.edges;
			 for(var i:int;i<pointNum;i++){
				 for(var j:int;j<pointNum;j++){
					 edge[i][j]=null;
				 }
			 }
			 for(var rsEdge:RSRelatedEdge in edgeList){
			    edge[rsEdge.startPointIndex][rsEdge.endPointIndex]=rsEdge;
				edge[rsEdge.endPointIndex][rsEdge.startPointIndex]=rsEdge;
			 }
		} 
	}
}