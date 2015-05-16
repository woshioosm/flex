package cn.edu.whu.liesmars.asPack.util
{
	import cn.edu.whu.liesmars.Container.LeftContainer_User;
	import cn.edu.whu.liesmars.Container.ParentMDI;
	import cn.edu.whu.liesmars.Container.SimpleContainer;
	import cn.edu.whu.liesmars.Container.UserView;
	import cn.edu.whu.liesmars.components.user.natureLanguageQuery.FeedbackWin;
	import cn.edu.whu.liesmars.components.user.natureLanguageQuery.QueryResultWin;
	import cn.edu.whu.liesmars.directlyEmbedView.nlResult.FeedbackWinEmbed;
	import cn.edu.whu.liesmars.map.MapContainer;
	
	import flash.events.IEventDispatcher;

	public class Controller
	{
		public static var leftContainer_user:IEventDispatcher;
		public static var leftContainer_admin:IEventDispatcher;
		public static var queryHistoryWin:QueryResultWin;
		public static var mapContainer:MapContainer;
		
		public static var container:SimpleContainer=new SimpleContainer();
		public static var feedBackWin:FeedbackWin=new FeedbackWin();// 由于打开时 非常诡异的慢 所以 初始化就加载一个
		
		public static var feedBackWinEmbed:FeedbackWinEmbed;// 由于打开时 非常诡异的慢 所以 初始化就加载一个
		public static var userView:UserView;
		
	
	}
}