/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - FusionSrcFlex.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_FusionSrcFlex extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.service54.datawrapFlex.FusionSrcFlex") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.service54.datawrapFlex.FusionSrcFlex", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.service54.datawrapFlex.FusionSrcFlex", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _FusionSrcFlexEntityMetadata;

	/**
	 * properties
	 */
	private var _internal__etime : String;
	private var _internal__cell : String;
	private var _internal__fusionUUID : String;
	private var _internal__stime : String;
	private var _internal__xqtype : int;
	private var _internal__prjUUId : String;
	private var _internal__srcUUID : String;
	private var _internal__nl : String;
	private var _internal__task : String;
	private var _internal__coordLst : ArrayCollection;
	private var _internal__coord : String;
	private var _internal__sensor : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_FusionSrcFlex() 
	{	
		_model = new _FusionSrcFlexEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get _etime() : String    
    {
            return _internal__etime;
    }    
	[Bindable(event="propertyChange")] 
    public function get _cell() : String    
    {
            return _internal__cell;
    }    
	[Bindable(event="propertyChange")] 
    public function get _fusionUUID() : String    
    {
            return _internal__fusionUUID;
    }    
	[Bindable(event="propertyChange")] 
    public function get _stime() : String    
    {
            return _internal__stime;
    }    
	[Bindable(event="propertyChange")] 
    public function get _xqtype() : int    
    {
            return _internal__xqtype;
    }    
	[Bindable(event="propertyChange")] 
    public function get _prjUUId() : String    
    {
            return _internal__prjUUId;
    }    
	[Bindable(event="propertyChange")] 
    public function get _srcUUID() : String    
    {
            return _internal__srcUUID;
    }    
	[Bindable(event="propertyChange")] 
    public function get _nl() : String    
    {
            return _internal__nl;
    }    
	[Bindable(event="propertyChange")] 
    public function get _task() : String    
    {
            return _internal__task;
    }    
	[Bindable(event="propertyChange")] 
    public function get _coordLst() : ArrayCollection    
    {
            return _internal__coordLst;
    }    
	[Bindable(event="propertyChange")] 
    public function get _coord() : String    
    {
            return _internal__coord;
    }    
	[Bindable(event="propertyChange")] 
    public function get _sensor() : String    
    {
            return _internal__sensor;
    }    

    /**
     * data property setters
     */      
    public function set _etime(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__etime == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__etime;               
        if (oldValue !== value)
        {
            _internal__etime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_etime", oldValue, _internal__etime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _cell(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__cell == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__cell;               
        if (oldValue !== value)
        {
            _internal__cell = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_cell", oldValue, _internal__cell));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _fusionUUID(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__fusionUUID == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__fusionUUID;               
        if (oldValue !== value)
        {
            _internal__fusionUUID = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_fusionUUID", oldValue, _internal__fusionUUID));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _stime(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__stime == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__stime;               
        if (oldValue !== value)
        {
            _internal__stime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_stime", oldValue, _internal__stime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _xqtype(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal__xqtype;               
        if (oldValue !== value)
        {
            _internal__xqtype = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_xqtype", oldValue, _internal__xqtype));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _prjUUId(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__prjUUId == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__prjUUId;               
        if (oldValue !== value)
        {
            _internal__prjUUId = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_prjUUId", oldValue, _internal__prjUUId));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _srcUUID(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__srcUUID == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__srcUUID;               
        if (oldValue !== value)
        {
            _internal__srcUUID = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_srcUUID", oldValue, _internal__srcUUID));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _nl(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__nl == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__nl;               
        if (oldValue !== value)
        {
            _internal__nl = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_nl", oldValue, _internal__nl));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _task(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__task == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__task;               
        if (oldValue !== value)
        {
            _internal__task = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_task", oldValue, _internal__task));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _coordLst(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__coordLst == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal__coordLst;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal__coordLst = value;
            }
            else if (value is Array)
            {
                _internal__coordLst = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of _coordLst must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_coordLst", oldValue, _internal__coordLst));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _coord(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__coord == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__coord;               
        if (oldValue !== value)
        {
            _internal__coord = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_coord", oldValue, _internal__coord));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _sensor(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal__sensor == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal__sensor;               
        if (oldValue !== value)
        {
            _internal__sensor = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_sensor", oldValue, _internal__sensor));
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

		if (_model.is_etimeAvailable && _internal__etime == null)
		{
			violatedConsts.push("_etimeIsRequired");
			validationFailureMessages.push("_etime is required");
		}
		if (_model.is_cellAvailable && _internal__cell == null)
		{
			violatedConsts.push("_cellIsRequired");
			validationFailureMessages.push("_cell is required");
		}
		if (_model.is_fusionUUIDAvailable && _internal__fusionUUID == null)
		{
			violatedConsts.push("_fusionUUIDIsRequired");
			validationFailureMessages.push("_fusionUUID is required");
		}
		if (_model.is_stimeAvailable && _internal__stime == null)
		{
			violatedConsts.push("_stimeIsRequired");
			validationFailureMessages.push("_stime is required");
		}
		if (_model.is_prjUUIdAvailable && _internal__prjUUId == null)
		{
			violatedConsts.push("_prjUUIdIsRequired");
			validationFailureMessages.push("_prjUUId is required");
		}
		if (_model.is_srcUUIDAvailable && _internal__srcUUID == null)
		{
			violatedConsts.push("_srcUUIDIsRequired");
			validationFailureMessages.push("_srcUUID is required");
		}
		if (_model.is_nlAvailable && _internal__nl == null)
		{
			violatedConsts.push("_nlIsRequired");
			validationFailureMessages.push("_nl is required");
		}
		if (_model.is_taskAvailable && _internal__task == null)
		{
			violatedConsts.push("_taskIsRequired");
			validationFailureMessages.push("_task is required");
		}
		if (_model.is_coordLstAvailable && _internal__coordLst == null)
		{
			violatedConsts.push("_coordLstIsRequired");
			validationFailureMessages.push("_coordLst is required");
		}
		if (_model.is_coordAvailable && _internal__coord == null)
		{
			violatedConsts.push("_coordIsRequired");
			validationFailureMessages.push("_coord is required");
		}
		if (_model.is_sensorAvailable && _internal__sensor == null)
		{
			violatedConsts.push("_sensorIsRequired");
			validationFailureMessages.push("_sensor is required");
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
    public function get _model() : _FusionSrcFlexEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _FusionSrcFlexEntityMetadata) : void       
    {
    	var oldValue : _FusionSrcFlexEntityMetadata = model_internal::_dminternal_model;               
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
