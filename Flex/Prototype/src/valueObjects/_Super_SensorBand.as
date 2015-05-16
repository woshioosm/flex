/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - SensorBand.as.
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
public class _Super_SensorBand extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.SensorBand") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.SensorBand", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.SensorBand", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _SensorBandEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_id : int;
	private var _internal_bandname : String;
	private var _internal_sensorname : String;
	private var _internal_minvalue : Number;
	private var _internal_maxvalue : Number;
	private var _internal_spatialresolution : Number;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_SensorBand() 
	{	
		_model = new _SensorBandEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get id() : int    
    {
            return _internal_id;
    }    
	[Bindable(event="propertyChange")] 
    public function get bandname() : String    
    {
            return _internal_bandname;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorname() : String    
    {
            return _internal_sensorname;
    }    
	[Bindable(event="propertyChange")] 
    public function get minvalue() : Number    
    {
            return _internal_minvalue;
    }    
	[Bindable(event="propertyChange")] 
    public function get maxvalue() : Number    
    {
            return _internal_maxvalue;
    }    
	[Bindable(event="propertyChange")] 
    public function get spatialresolution() : Number    
    {
            return _internal_spatialresolution;
    }    

    /**
     * data property setters
     */      
    public function set id(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_id;               
        if (oldValue !== value)
        {
            _internal_id = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "id", oldValue, _internal_id));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set bandname(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_bandname == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_bandname;               
        if (oldValue !== value)
        {
            _internal_bandname = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bandname", oldValue, _internal_bandname));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorname(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sensorname == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_sensorname;               
        if (oldValue !== value)
        {
            _internal_sensorname = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorname", oldValue, _internal_sensorname));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set minvalue(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_minvalue;               
        if (oldValue !== value)
        {
            _internal_minvalue = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "minvalue", oldValue, _internal_minvalue));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set maxvalue(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_maxvalue;               
        if (oldValue !== value)
        {
            _internal_maxvalue = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "maxvalue", oldValue, _internal_maxvalue));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spatialresolution(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_spatialresolution;               
        if (oldValue !== value)
        {
            _internal_spatialresolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spatialresolution", oldValue, _internal_spatialresolution));
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

		if (_model.isBandnameAvailable && _internal_bandname == null)
		{
			violatedConsts.push("bandnameIsRequired");
			validationFailureMessages.push("bandname is required");
		}
		if (_model.isSensornameAvailable && _internal_sensorname == null)
		{
			violatedConsts.push("sensornameIsRequired");
			validationFailureMessages.push("sensorname is required");
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
    public function get _model() : _SensorBandEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _SensorBandEntityMetadata) : void       
    {
    	var oldValue : _SensorBandEntityMetadata = model_internal::_dminternal_model;               
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
