/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - TRoutinetask.as.
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
public class _Super_TRoutinetask extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.TRoutinetask") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.TRoutinetask", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.TRoutinetask", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _TRoutinetaskEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_taskId : String;
	private var _internal_spaceRangeStr : String;
	private var _internal_sensorClassType : String;
	private var _internal_expectTime : String;
	private var _internal_department : String;
	private var _internal_spaceRange : String;
	private var _internal_frequency : String;
	private var _internal_endTime : Date;
	private var _internal_taskName : String;
	private var _internal_spaceResol : String;
	private var _internal_startTime : Date;
	private var _internal_bandName : String;
	private var _internal_band : String;
	private var _internal_sensorType : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_TRoutinetask() 
	{	
		_model = new _TRoutinetaskEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get taskId() : String    
    {
            return _internal_taskId;
    }    
	[Bindable(event="propertyChange")] 
    public function get spaceRangeStr() : String    
    {
            return _internal_spaceRangeStr;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorClassType() : String    
    {
            return _internal_sensorClassType;
    }    
	[Bindable(event="propertyChange")] 
    public function get expectTime() : String    
    {
            return _internal_expectTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get department() : String    
    {
            return _internal_department;
    }    
	[Bindable(event="propertyChange")] 
    public function get spaceRange() : String    
    {
            return _internal_spaceRange;
    }    
	[Bindable(event="propertyChange")] 
    public function get frequency() : String    
    {
            return _internal_frequency;
    }    
	[Bindable(event="propertyChange")] 
    public function get endTime() : Date    
    {
            return _internal_endTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get taskName() : String    
    {
            return _internal_taskName;
    }    
	[Bindable(event="propertyChange")] 
    public function get spaceResol() : String    
    {
            return _internal_spaceResol;
    }    
	[Bindable(event="propertyChange")] 
    public function get startTime() : Date    
    {
            return _internal_startTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get bandName() : String    
    {
            return _internal_bandName;
    }    
	[Bindable(event="propertyChange")] 
    public function get band() : String    
    {
            return _internal_band;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorType() : String    
    {
            return _internal_sensorType;
    }    

    /**
     * data property setters
     */      
    public function set taskId(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_taskId;               
        if (oldValue !== value)
        {
            _internal_taskId = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "taskId", oldValue, _internal_taskId));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spaceRangeStr(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_spaceRangeStr;               
        if (oldValue !== value)
        {
            _internal_spaceRangeStr = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spaceRangeStr", oldValue, _internal_spaceRangeStr));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorClassType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_sensorClassType;               
        if (oldValue !== value)
        {
            _internal_sensorClassType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorClassType", oldValue, _internal_sensorClassType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set expectTime(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_expectTime;               
        if (oldValue !== value)
        {
            _internal_expectTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "expectTime", oldValue, _internal_expectTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set department(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_department;               
        if (oldValue !== value)
        {
            _internal_department = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "department", oldValue, _internal_department));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spaceRange(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_spaceRange;               
        if (oldValue !== value)
        {
            _internal_spaceRange = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spaceRange", oldValue, _internal_spaceRange));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set frequency(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_frequency;               
        if (oldValue !== value)
        {
            _internal_frequency = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "frequency", oldValue, _internal_frequency));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set endTime(value:Date) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Date = _internal_endTime;               
        if (oldValue !== value)
        {
            _internal_endTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "endTime", oldValue, _internal_endTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set taskName(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_taskName;               
        if (oldValue !== value)
        {
            _internal_taskName = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "taskName", oldValue, _internal_taskName));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spaceResol(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_spaceResol;               
        if (oldValue !== value)
        {
            _internal_spaceResol = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spaceResol", oldValue, _internal_spaceResol));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set startTime(value:Date) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Date = _internal_startTime;               
        if (oldValue !== value)
        {
            _internal_startTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "startTime", oldValue, _internal_startTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set bandName(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_bandName;               
        if (oldValue !== value)
        {
            _internal_bandName = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bandName", oldValue, _internal_bandName));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set band(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_band;               
        if (oldValue !== value)
        {
            _internal_band = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "band", oldValue, _internal_band));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_sensorType;               
        if (oldValue !== value)
        {
            _internal_sensorType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorType", oldValue, _internal_sensorType));
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
    public function get _model() : _TRoutinetaskEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _TRoutinetaskEntityMetadata) : void       
    {
    	var oldValue : _TRoutinetaskEntityMetadata = model_internal::_dminternal_model;               
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
