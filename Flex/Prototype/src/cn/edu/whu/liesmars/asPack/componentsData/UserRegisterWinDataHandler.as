package cn.edu.whu.liesmars.asPack.componentsData
{
	import cn.edu.whu.liesmars.asPack.AdminBaseModel.UserRegisterHandleObj;
	
	import mx.collections.ArrayCollection;
	
	import valueObjects.TUserinfo;

	public class UserRegisterWinDataHandler extends  DataHandler
	{
		public function UserRegisterWinDataHandler(result:Object)
		{
			super(result);
		}
		public override function bindData(bindingData:ArrayCollection):void{
			bindingData.removeAll();
			for each(var userInfo:TUserinfo in this.dataFromServer as ArrayCollection){
				var userRegisterHandle:UserRegisterHandleObj=new UserRegisterHandleObj();
				userRegisterHandle.uuid="";
				userRegisterHandle.userName=userInfo.username;
				userRegisterHandle.realName=userInfo.realname;
				userRegisterHandle.department=userInfo.department;
				userRegisterHandle.e_mail=userInfo.email;
				userRegisterHandle.isAdmitted=userInfo.isAdmitted;
				bindingData.addItem(userRegisterHandle);
			}
		}
	}
}