/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Sensor.as.
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
public class _Super_Sensor extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.Sensor") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.Sensor", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.Sensor", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _SensorEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_snr : Number;
	private var _internal_imgway : String;
	private var _internal_radioresolution : Number;
	private var _internal_spectralresolution : Number;
	private var _internal_spectrum : String;
	private var _internal_timeresolution : Number;
	private var _internal_steroimgway : String;
	private var _internal_type : String;
	private var _internal_encounterangle : Number;
	private var _internal_tracktype : String;
	private var _internal_polarway : String;
	private var _internal_side : Number;
	private var _internal_confname : String;
	private var _internal_name : String;
	private var _internal_aliasname : String;
	private var _internal_fabricwidth : Number;
	private var _internal_imgmode : String;
	private var _internal_isimg : String;
	private var _internal_uuid : String;
	private var _internal_sensortype : int;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_Sensor() 
	{	
		_model = new _SensorEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get snr() : Number    
    {
            return _internal_snr;
    }    
	[Bindable(event="propertyChange")] 
    public function get imgway() : String    
    {
            return _internal_imgway;
    }    
	[Bindable(event="propertyChange")] 
    public function get radioresolution() : Number    
    {
            return _internal_radioresolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectralresolution() : Number    
    {
            return _internal_spectralresolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectrum() : String    
    {
            return _internal_spectrum;
    }    
	[Bindable(event="propertyChange")] 
    public function get timeresolution() : Number    
    {
            return _internal_timeresolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get steroimgway() : String    
    {
            return _internal_steroimgway;
    }    
	[Bindable(event="propertyChange")] 
    public function get type() : String    
    {
            return _internal_type;
    }    
	[Bindable(event="propertyChange")] 
    public function get encounterangle() : Number    
    {
            return _internal_encounterangle;
    }    
	[Bindable(event="propertyChange")] 
    public function get tracktype() : String    
    {
            return _internal_tracktype;
    }    
	[Bindable(event="propertyChange")] 
    public function get polarway() : String    
    {
            return _internal_polarway;
    }    
	[Bindable(event="propertyChange")] 
    public function get side() : Number    
    {
            return _internal_side;
    }    
	[Bindable(event="propertyChange")] 
    public function get confname() : String    
    {
            return _internal_confname;
    }    
	[Bindable(event="propertyChange")] 
    public function get name() : String    
    {
            return _internal_name;
    }    
	[Bindable(event="propertyChange")] 
    public function get aliasname() : String    
    {
            return _internal_aliasname;
    }    
	[Bindable(event="propertyChange")] 
    public function get fabricwidth() : Number    
    {
            return _internal_fabricwidth;
    }    
	[Bindable(event="propertyChange")] 
    public function get imgmode() : String    
    {
            return _internal_imgmode;
    }    
	[Bindable(event="propertyChange")] 
    public function get isimg() : String    
    {
            return _internal_isimg;
    }    
	[Bindable(event="propertyChange")] 
    public function get uuid() : String    
    {
            return _internal_uuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensortype() : int    
    {
            return _internal_sensortype;
    }    

    /**
     * data property setters
     */      
    public function set snr(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_snr;               
        if (oldValue !== value)
        {
            _internal_snr = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "snr", oldValue, _internal_snr));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imgway(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imgway == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_imgway;               
        if (oldValue !== value)
        {
            _internal_imgway = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgway", oldValue, _internal_imgway));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set radioresolution(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_radioresolution;               
        if (oldValue !== value)
        {
            _internal_radioresolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "radioresolution", oldValue, _internal_radioresolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spectralresolution(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_spectralresolution;               
        if (oldValue !== value)
        {
            _internal_spectralresolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spectralresolution", oldValue, _internal_spectralresolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spectrum(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_spectrum == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_spectrum;               
        if (oldValue !== value)
        {
            _internal_spectrum = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spectrum", oldValue, _internal_spectrum));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set timeresolution(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_timeresolution;               
        if (oldValue !== value)
        {
            _internal_timeresolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timeresolution", oldValue, _internal_timeresolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set steroimgway(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_steroimgway == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_steroimgway;               
        if (oldValue !== value)
        {
            _internal_steroimgway = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "steroimgway", oldValue, _internal_steroimgway));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set type(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_type == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_type;               
        if (oldValue !== value)
        {
            _internal_type = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "type", oldValue, _internal_type));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set encounterangle(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_encounterangle;               
        if (oldValue !== value)
        {
            _internal_encounterangle = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "encounterangle", oldValue, _internal_encounterangle));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set tracktype(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_tracktype == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_tracktype;               
        if (oldValue !== value)
        {
            _internal_tracktype = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "tracktype", oldValue, _internal_tracktype));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set polarway(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_polarway == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_polarway;               
        if (oldValue !== value)
        {
            _internal_polarway = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "polarway", oldValue, _internal_polarway));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set side(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_side;               
        if (oldValue !== value)
        {
            _internal_side = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "side", oldValue, _internal_side));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set confname(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_confname == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_confname;               
        if (oldValue !== value)
        {
            _internal_confname = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "confname", oldValue, _internal_confname));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set name(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_name == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_name;               
        if (oldValue !== value)
        {
            _internal_name = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "name", oldValue, _internal_name));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set aliasname(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_aliasname == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_aliasname;               
        if (oldValue !== value)
        {
            _internal_aliasname = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "aliasname", oldValue, _internal_aliasname));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fabricwidth(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_fabricwidth;               
        if (oldValue !== value)
        {
            _internal_fabricwidth = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fabricwidth", oldValue, _internal_fabricwidth));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imgmode(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imgmode == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_imgmode;               
        if (oldValue !== value)
        {
            _internal_imgmode = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imgmode", oldValue, _internal_imgmode));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set isimg(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_isimg == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_isimg;               
        if (oldValue !== value)
        {
            _internal_isimg = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "isimg", oldValue, _internal_isimg));
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
    public function set sensortype(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_sensortype;               
        if (oldValue !== value)
        {
            _internal_sensortype = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensortype", oldValue, _internal_sensortype));
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

		if (_model.isImgwayAvailable && _internal_imgway == null)
		{
			violatedConsts.push("imgwayIsRequired");
			validationFailureMessages.push("imgway is required");
		}
		if (_model.isSpectrumAvailable && _internal_spectrum == null)
		{
			violatedConsts.push("spectrumIsRequired");
			validationFailureMessages.push("spectrum is required");
		}
		if (_model.isSteroimgwayAvailable && _internal_steroimgway == null)
		{
			violatedConsts.push("steroimgwayIsRequired");
			validationFailureMessages.push("steroimgway is required");
		}
		if (_model.isTypeAvailable && _internal_type == null)
		{
			violatedConsts.push("typeIsRequired");
			validationFailureMessages.push("type is required");
		}
		if (_model.isTracktypeAvailable && _internal_tracktype == null)
		{
			violatedConsts.push("tracktypeIsRequired");
			validationFailureMessages.push("tracktype is required");
		}
		if (_model.isPolarwayAvailable && _internal_polarway == null)
		{
			violatedConsts.push("polarwayIsRequired");
			validationFailureMessages.push("polarway is required");
		}
		if (_model.isConfnameAvailable && _internal_confname == null)
		{
			violatedConsts.push("confnameIsRequired");
			validationFailureMessages.push("confname is required");
		}
		if (_model.isNameAvailable && _internal_name == null)
		{
			violatedConsts.push("nameIsRequired");
			validationFailureMessages.push("name is required");
		}
		if (_model.isAliasnameAvailable && _internal_aliasname == null)
		{
			violatedConsts.push("aliasnameIsRequired");
			validationFailureMessages.push("aliasname is required");
		}
		if (_model.isImgmodeAvailable && _internal_imgmode == null)
		{
			violatedConsts.push("imgmodeIsRequired");
			validationFailureMessages.push("imgmode is required");
		}
		if (_model.isIsimgAvailable && _internal_isimg == null)
		{
			violatedConsts.push("isimgIsRequired");
			validationFailureMessages.push("isimg is required");
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
    public function get _model() : _SensorEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _SensorEntityMetadata) : void       
    {
    	var oldValue : _SensorEntityMetadata = model_internal::_dminternal_model;               
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
