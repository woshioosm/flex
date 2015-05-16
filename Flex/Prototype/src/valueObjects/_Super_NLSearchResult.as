/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - NLSearchResult.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_NLSearchResult extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.NLSearchResult") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.NLSearchResult", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.NLSearchResult", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _NLSearchResultEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_nlString : String;
	private var _internal_shallowFramework : String;
	private var _internal_deepFeedback : String;
	private var _internal_username : String;
	private var _internal_primaryTime : Number;
	private var _internal_advanceTime : Number;
	private var _internal_shwllowFeedback : String;
	private var _internal_searchUUID : String;
	private var _internal_searchTime : String;
	private var _internal_inputMethod : int;
	private var _internal_deepFramework : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_NLSearchResult() 
	{	
		_model = new _NLSearchResultEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get nlString() : String    
    {
            return _internal_nlString;
    }    
	[Bindable(event="propertyChange")] 
    public function get shallowFramework() : String    
    {
            return _internal_shallowFramework;
    }    
	[Bindable(event="propertyChange")] 
    public function get deepFeedback() : String    
    {
            return _internal_deepFeedback;
    }    
	[Bindable(event="propertyChange")] 
    public function get username() : String    
    {
            return _internal_username;
    }    
	[Bindable(event="propertyChange")] 
    public function get primaryTime() : Number    
    {
            return _internal_primaryTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get advanceTime() : Number    
    {
            return _internal_advanceTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get shwllowFeedback() : String    
    {
            return _internal_shwllowFeedback;
    }    
	[Bindable(event="propertyChange")] 
    public function get searchUUID() : String    
    {
            return _internal_searchUUID;
    }    
	[Bindable(event="propertyChange")] 
    public function get searchTime() : String    
    {
            return _internal_searchTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get inputMethod() : int    
    {
            return _internal_inputMethod;
    }    
	[Bindable(event="propertyChange")] 
    public function get deepFramework() : String    
    {
            return _internal_deepFramework;
    }    

    /**
     * data property setters
     */      
    public function set nlString(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_nlString;               
        if (oldValue !== value)
        {
            _internal_nlString = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "nlString", oldValue, _internal_nlString));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set shallowFramework(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_shallowFramework;               
        if (oldValue !== value)
        {
            _internal_shallowFramework = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "shallowFramework", oldValue, _internal_shallowFramework));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set deepFeedback(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_deepFeedback;               
        if (oldValue !== value)
        {
            _internal_deepFeedback = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "deepFeedback", oldValue, _internal_deepFeedback));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set username(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_username;               
        if (oldValue !== value)
        {
            _internal_username = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "username", oldValue, _internal_username));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set primaryTime(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_primaryTime;               
        if (oldValue !== value)
        {
            _internal_primaryTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "primaryTime", oldValue, _internal_primaryTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set advanceTime(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_advanceTime;               
        if (oldValue !== value)
        {
            _internal_advanceTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "advanceTime", oldValue, _internal_advanceTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set shwllowFeedback(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_shwllowFeedback;               
        if (oldValue !== value)
        {
            _internal_shwllowFeedback = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "shwllowFeedback", oldValue, _internal_shwllowFeedback));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set searchUUID(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_searchUUID;               
        if (oldValue !== value)
        {
            _internal_searchUUID = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "searchUUID", oldValue, _internal_searchUUID));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set searchTime(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_searchTime;               
        if (oldValue !== value)
        {
            _internal_searchTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "searchTime", oldValue, _internal_searchTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set inputMethod(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_inputMethod;               
        if (oldValue !== value)
        {
            _internal_inputMethod = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "inputMethod", oldValue, _internal_inputMethod));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set deepFramework(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_deepFramework;               
        if (oldValue !== value)
        {
            _internal_deepFramework = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "deepFramework", oldValue, _internal_deepFramework));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    

    /**
     * data property setter listeners
     */   

   model_internal function setterListenerAnyConstraint(value:flash.events.Event):void
   {
        if (model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }        
   }   

    /**
     * valid related derived properties
     */
    model_internal var _isValid : Boolean;
    model_internal var _invalidConstraints:Array = new Array();
    model_internal var _validationFailureMessages:Array = new Array();

    /**
     * derived property calculators
     */

    /**
     * isValid calculator
     */
    model_internal function calculateIsValid():Boolean
    {
        var violatedConsts:Array = new Array();    
        var validationFailureMessages:Array = new Array();    


		var styleValidity:Boolean = true;
	
	
	
	
	
	
	
	
	
	
	
    
        model_internal::_cacheInitialized_isValid = true;
        model_internal::invalidConstraints_der = violatedConsts;
        model_internal::validationFailureMessages_der = validationFailureMessages;
        return violatedConsts.length == 0 && styleValidity;
    }  

    /**
     * derived property setters
     */

    model_internal function set isValid_der(value:Boolean) : void
    {
       	var oldValue:Boolean = model_internal::_isValid;               
        if (oldValue !== value)
        {
        	model_internal::_isValid = value;
        	_model.model_internal::fireChangeEvent("isValid", oldValue, model_internal::_isValid);
        }        
    }

    /**
     * derived property getters
     */

    [Transient] 
	[Bindable(event="propertyChange")] 
    public function get _model() : _NLSearchResultEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _NLSearchResultEntityMetadata) : void       
    {
    	var oldValue : _NLSearchResultEntityMetadata = model_internal::_dminternal_model;               
        if (oldValue !== value)
        {
        	model_internal::_dminternal_model = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_model", oldValue, model_internal::_dminternal_model));
        }     
    }      

    /**
     * methods
     */  


    /**
     *  services
     */                  
     private var _managingService:com.adobe.fiber.services.IFiberManagingService;
    
     public function set managingService(managingService:com.adobe.fiber.services.IFiberManagingService):void
     {
         _managingService = managingService;
     }                      
     
    model_internal function set invalidConstraints_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_invalidConstraints;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_invalidConstraints = value;   
			_model.model_internal::fireChangeEvent("invalidConstraints", oldValue, model_internal::_invalidConstraints);   
        }     	             
    }             
    
     model_internal function set validationFailureMessages_der(value:Array) : void
    {  
     	var oldValue:Array = model_internal::_validationFailureMessages;
     	// avoid firing the event when old and new value are different empty arrays
        if (oldValue !== value && (oldValue.length > 0 || value.length > 0))
        {
            model_internal::_validationFailureMessages = value;   
			_model.model_internal::fireChangeEvent("validationFailureMessages", oldValue, model_internal::_validationFailureMessages);   
        }     	             
    }        
     
     // Individual isAvailable functions     
	// fields, getters, and setters for primitive representations of complex id properties

}

}
