package cn.edu.whu.liesmars.asPack.util
{
	import mx.validators.ValidationResult;  
	import mx.validators.Validator;  
	
	public class MyPasswordValidator extends Validator  
	{  
		private var results:Array;  
		
		private var _pass:String;  
		
		public function MyPasswordValidator()  
		{  
			super();  
		}  
		
		override protected function doValidation(value:Object):Array{  
			
			var inputValue:String = String(value);  
			results = [];  
			results = super.doValidation(value);  
			// Return if there are errors.  
			if (results.length > 0){  
				return results;  
			}  
			
			if(inputValue == ""){  
				results.push(new ValidationResult(true,null,"repassnull","确认密码不能为空"))  
				return results;  
			}  
			
			if(inputValue != pass){  
				results.push(new ValidationResult(true,null,"repassnull","确认密码与密码不一致"))  
				return results;  
			}  
			return results;  
		}  
		
		public function get pass():String  
		{  
			return _pass;  
		}  
		
		public function set pass(value:String):void  
		{  
			_pass = value;  
		}  
	}  
}