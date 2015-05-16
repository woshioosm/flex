/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - TFusionresult.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;
import valueObjects.Timestamp;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_TFusionresult extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.TFusionresult") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.TFusionresult", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.TFusionresult", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.Timestamp.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _TFusionresultEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_arg4 : int;
	private var _internal_arg3 : int;
	private var _internal_arg2 : int;
	private var _internal_arg1 : int;
	private var _internal_fusionState : int;
	private var _internal_fusionUuid : String;
	private var _internal_sourceAreas : String;
	private var _internal_fusiontime : valueObjects.Timestamp;
	private var _internal_fusionXml : String;
	private var _internal_ftype : int;
	private var _internal_projUuid : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_TFusionresult() 
	{	
		_model = new _TFusionresultEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get arg4() : int    
    {
            return _internal_arg4;
    }    
	[Bindable(event="propertyChange")] 
    public function get arg3() : int    
    {
            return _internal_arg3;
    }    
	[Bindable(event="propertyChange")] 
    public function get arg2() : int    
    {
            return _internal_arg2;
    }    
	[Bindable(event="propertyChange")] 
    public function get arg1() : int    
    {
            return _internal_arg1;
    }    
	[Bindable(event="propertyChange")] 
    public function get fusionState() : int    
    {
            return _internal_fusionState;
    }    
	[Bindable(event="propertyChange")] 
    public function get fusionUuid() : String    
    {
            return _internal_fusionUuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get sourceAreas() : String    
    {
            return _internal_sourceAreas;
    }    
	[Bindable(event="propertyChange")] 
    public function get fusiontime() : valueObjects.Timestamp    
    {
            return _internal_fusiontime;
    }    
	[Bindable(event="propertyChange")] 
    public function get fusionXml() : String    
    {
            return _internal_fusionXml;
    }    
	[Bindable(event="propertyChange")] 
    public function get ftype() : int    
    {
            return _internal_ftype;
    }    
	[Bindable(event="propertyChange")] 
    public function get projUuid() : String    
    {
            return _internal_projUuid;
    }    

    /**
     * data property setters
     */      
    public function set arg4(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_arg4;               
        if (oldValue !== value)
        {
            _internal_arg4 = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "arg4", oldValue, _internal_arg4));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set arg3(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_arg3;               
        if (oldValue !== value)
        {
            _internal_arg3 = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "arg3", oldValue, _internal_arg3));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set arg2(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_arg2;               
        if (oldValue !== value)
        {
            _internal_arg2 = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "arg2", oldValue, _internal_arg2));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set arg1(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_arg1;               
        if (oldValue !== value)
        {
            _internal_arg1 = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "arg1", oldValue, _internal_arg1));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fusionState(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_fusionState;               
        if (oldValue !== value)
        {
            _internal_fusionState = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusionState", oldValue, _internal_fusionState));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fusionUuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_fusionUuid == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_fusionUuid;               
        if (oldValue !== value)
        {
            _internal_fusionUuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusionUuid", oldValue, _internal_fusionUuid));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sourceAreas(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sourceAreas == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_sourceAreas;               
        if (oldValue !== value)
        {
            _internal_sourceAreas = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sourceAreas", oldValue, _internal_sourceAreas));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fusiontime(value:valueObjects.Timestamp) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_fusiontime == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.Timestamp = _internal_fusiontime;               
        if (oldValue !== value)
        {
            _internal_fusiontime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusiontime", oldValue, _internal_fusiontime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fusionXml(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_fusionXml == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_fusionXml;               
        if (oldValue !== value)
        {
            _internal_fusionXml = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fusionXml", oldValue, _internal_fusionXml));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set ftype(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_ftype;               
        if (oldValue !== value)
        {
            _internal_ftype = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "ftype", oldValue, _internal_ftype));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set projUuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_projUuid == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_projUuid;               
        if (oldValue !== value)
        {
            _internal_projUuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "projUuid", oldValue, _internal_projUuid));
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

		if (_model.isFusionUuidAvailable && _internal_fusionUuid == null)
		{
			violatedConsts.push("fusionUuidIsRequired");
			validationFailureMessages.push("fusionUuid is required");
		}
		if (_model.isSourceAreasAvailable && _internal_sourceAreas == null)
		{
			violatedConsts.push("sourceAreasIsRequired");
			validationFailureMessages.push("sourceAreas is required");
		}
		if (_model.isFusiontimeAvailable && _internal_fusiontime == null)
		{
			violatedConsts.push("fusiontimeIsRequired");
			validationFailureMessages.push("fusiontime is required");
		}
		if (_model.isFusionXmlAvailable && _internal_fusionXml == null)
		{
			violatedConsts.push("fusionXmlIsRequired");
			validationFailureMessages.push("fusionXml is required");
		}
		if (_model.isProjUuidAvailable && _internal_projUuid == null)
		{
			violatedConsts.push("projUuidIsRequired");
			validationFailureMessages.push("projUuid is required");
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
    public function get _model() : _TFusionresultEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _TFusionresultEntityMetadata) : void       
    {
    	var oldValue : _TFusionresultEntityMetadata = model_internal::_dminternal_model;               
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
