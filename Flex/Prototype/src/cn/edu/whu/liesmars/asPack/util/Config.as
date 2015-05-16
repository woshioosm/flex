package cn.edu.whu.liesmars.asPack.util
{
	import flexlib.mdi.containers.MDICanvas;
	
	import mx.collections.ArrayCollection;

	public class Config
	{
		public function Config()
		{
		}
		public static var  depratments:XML; //读取配置中的部门名 初始化登陆界面中的部门
		//public static var  admin:XML;
		
		public static var  tileServerUrl:String;   //初始化瓦片服务器的地址
		public static var crossDomainUrl:String;
		public static var serverUrl:String;    
		public static var stageOffsetX:int;   // 初始化地图在stage上的偏移
		public static var stageOffsetY:int;   // 同上
		public static var midCanvs:MDICanvas;　　//保存 全局的mid容器
		public static var midCanvs1:MDICanvas;　 
		public static var midCanvs2:MDICanvas;　　//保存 全局的mid容器 弹出框
		public static var midCanvs3:MDICanvas;　　//保存 全局的mid容器 弹出框
		public static var midCanvs4:MDICanvas;　　//保存 全局的mid容器 弹出框 最上层
		public static var isAdmin:Boolean;
		public static var userName:String; //保存用户的姓名
		public static var page:int; //保存页面
		public static var layerName:ArrayCollection=new ArrayCollection();
		public static var searchId:String="";
		
		public static var startTime:Number; //开始时间
		public static var endTime:Number;   //结束时间
		public static var totleSearchNum:Number; //总共的查询时间
		
		public static var fusionResultCurPage:int;//融合结果的分页记录
		public static var imagePath:String="";
		public static var mainApp:Prototype;
		public static var orderId:int=0;
		public static var departmentName:String="";
	}
}