package cn.edu.whu.liesmars.asPack.AdminBaseModel
{
	public class UserRegisterHandleObj
	{
		protected var _uuid:String;
		protected var _sequence:int;
		protected var _userName:String;
		protected var _realName:String;
		protected var _department:String;
		protected var _e_mail:String;
		protected var _isAdmitted:int;
		protected var _hasRejected:Boolean;
		
//		public function UserRegisterHandleObj(id:String=null,sequence:int=-1,userName:String=null,realName:String=null,department:String=null,e_mail:String=null)
//		{
//			this.id=id;
//			this.sequence=sequence;
//			this.userName=userName;
//			this.realName=realName;
//			this.department=department;
//			this.e_mail=e_mail;
//		}

		public function get uuid():String
		{
			return _uuid;
		}

		public function set uuid(value:String):void
		{
			_uuid = value;
		}

		public function get hasRejected():Boolean
		{
			return _hasRejected;
		}

		public function set hasRejected(value:Boolean):void
		{
			_hasRejected = value;
		}

		public function get isAdmitted():int
		{
			return _isAdmitted;
		}

		public function set isAdmitted(value:int):void
		{
			_isAdmitted = value;
		}

		public function get e_mail():String
		{
			return _e_mail;
		}

		public function set e_mail(value:String):void
		{
			_e_mail = value;
		}

		public function get department():String
		{
			return _department;
		}

		public function set department(value:String):void
		{
			_department = value;
		}

		public function get realName():String
		{
			return _realName;
		}

		public function set realName(value:String):void
		{
			_realName = value;
		}

		public function get userName():String
		{
			return _userName;
		}

		public function set userName(value:String):void
		{
			_userName = value;
		}

		public function get sequence():int
		{
			return _sequence;
		}

		public function set sequence(value:int):void
		{
			_sequence = value;
		}



	}
}