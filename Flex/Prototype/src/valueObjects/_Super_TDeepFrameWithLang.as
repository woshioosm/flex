/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - TDeepFrameWithLang.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;
import valueObjects.TDeepframework;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_TDeepFrameWithLang extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.TDeepFrameWithLang") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.TDeepFrameWithLang", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.TDeepFrameWithLang", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.TDeepframework.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _TDeepFrameWithLangEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_canQuery : Boolean;
	private var _internal_tdeepFrameWork : valueObjects.TDeepframework;
	private var _internal_naturaLang : String;
	private var _internal_uuid : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_TDeepFrameWithLang() 
	{	
		_model = new _TDeepFrameWithLangEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get canQuery() : Boolean    
    {
            return _internal_canQuery;
    }    
	[Bindable(event="propertyChange")] 
    public function get tdeepFrameWork() : valueObjects.TDeepframework    
    {
            return _internal_tdeepFrameWork;
    }    
	[Bindable(event="propertyChange")] 
    public function get naturaLang() : String    
    {
            return _internal_naturaLang;
    }    
	[Bindable(event="propertyChange")] 
    public function get uuid() : String    
    {
            return _internal_uuid;
    }    

    /**
     * data property setters
     */      
    public function set canQuery(value:Boolean) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Boolean = _internal_canQuery;               
        if (oldValue !== value)
        {
            _internal_canQuery = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "canQuery", oldValue, _internal_canQuery));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set tdeepFrameWork(value:valueObjects.TDeepframework) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_tdeepFrameWork == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.TDeepframework = _internal_tdeepFrameWork;               
        if (oldValue !== value)
        {
            _internal_tdeepFrameWork = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tdeepFrameWork", oldValue, _internal_tdeepFrameWork));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set naturaLang(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_naturaLang == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_naturaLang;               
        if (oldValue !== value)
        {
            _internal_naturaLang = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "naturaLang", oldValue, _internal_naturaLang));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set uuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_uuid == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_uuid;               
        if (oldValue !== value)
        {
            _internal_uuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "uuid", oldValue, _internal_uuid));
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

		if (_model.isTdeepFrameWorkAvailable && _internal_tdeepFrameWork == null)
		{
			violatedConsts.push("tdeepFrameWorkIsRequired");
			validationFailureMessages.push("tdeepFrameWork is required");
		}
		if (_model.isNaturaLangAvailable && _internal_naturaLang == null)
		{
			violatedConsts.push("naturaLangIsRequired");
			validationFailureMessages.push("naturaLang is required");
		}
		if (_model.isUuidAvailable && _internal_uuid == null)
		{
			violatedConsts.push("uuidIsRequired");
			validationFailureMessages.push("uuid is required");
		}

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
    public function get _model() : _TDeepFrameWithLangEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _TDeepFrameWithLangEntityMetadata) : void       
    {
    	var oldValue : _TDeepFrameWithLangEntityMetadata = model_internal::_dminternal_model;               
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
