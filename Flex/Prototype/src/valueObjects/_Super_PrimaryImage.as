/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - PrimaryImage.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.PrimaryImageParameter;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_PrimaryImage extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.frame.PrimaryImage") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.frame.PrimaryImage", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.frame.PrimaryImage", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.PrimaryImageParameter.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _PrimaryImageEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_snr : valueObjects.PrimaryImageParameter;
	private var _internal_scale : valueObjects.PrimaryImageParameter;
	private var _internal_fabricWidth : valueObjects.PrimaryImageParameter;
	private var _internal_imageLevel : valueObjects.PrimaryImageParameter;
	private var _internal_spatialResolution : valueObjects.PrimaryImageParameter;
	private var _internal_temporalResolution : valueObjects.PrimaryImageParameter;
	private var _internal_frequency : valueObjects.PrimaryImageParameter;
	private var _internal_sensorSARPolarType : String;
	private var _internal_radiometricResolution : valueObjects.PrimaryImageParameter;
	private var _internal_sensorSARPolarLst : ArrayCollection;
	private var _internal_band : valueObjects.PrimaryImageParameter;
	private var _internal_extendsParams : Object;
	private var _internal_sensorType : ArrayCollection;
	private var _internal_encounterAngle : valueObjects.PrimaryImageParameter;
	private var _internal_senorWorkType : ArrayCollection;
	private var _internal_spectralResolution : valueObjects.PrimaryImageParameter;
	private var _internal_sensorName : ArrayCollection;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_PrimaryImage() 
	{	
		_model = new _PrimaryImageEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get snr() : valueObjects.PrimaryImageParameter    
    {
            return _internal_snr;
    }    
	[Bindable(event="propertyChange")] 
    public function get scale() : valueObjects.PrimaryImageParameter    
    {
            return _internal_scale;
    }    
	[Bindable(event="propertyChange")] 
    public function get fabricWidth() : valueObjects.PrimaryImageParameter    
    {
            return _internal_fabricWidth;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageLevel() : valueObjects.PrimaryImageParameter    
    {
            return _internal_imageLevel;
    }    
	[Bindable(event="propertyChange")] 
    public function get spatialResolution() : valueObjects.PrimaryImageParameter    
    {
            return _internal_spatialResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get temporalResolution() : valueObjects.PrimaryImageParameter    
    {
            return _internal_temporalResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get frequency() : valueObjects.PrimaryImageParameter    
    {
            return _internal_frequency;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorSARPolarType() : String    
    {
            return _internal_sensorSARPolarType;
    }    
	[Bindable(event="propertyChange")] 
    public function get radiometricResolution() : valueObjects.PrimaryImageParameter    
    {
            return _internal_radiometricResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorSARPolarLst() : ArrayCollection    
    {
            return _internal_sensorSARPolarLst;
    }    
	[Bindable(event="propertyChange")] 
    public function get band() : valueObjects.PrimaryImageParameter    
    {
            return _internal_band;
    }    
	[Bindable(event="propertyChange")] 
    public function get extendsParams() : Object    
    {
            return _internal_extendsParams;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorType() : ArrayCollection    
    {
            return _internal_sensorType;
    }    
	[Bindable(event="propertyChange")] 
    public function get encounterAngle() : valueObjects.PrimaryImageParameter    
    {
            return _internal_encounterAngle;
    }    
	[Bindable(event="propertyChange")] 
    public function get senorWorkType() : ArrayCollection    
    {
            return _internal_senorWorkType;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectralResolution() : valueObjects.PrimaryImageParameter    
    {
            return _internal_spectralResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorName() : ArrayCollection    
    {
            return _internal_sensorName;
    }    

    /**
     * data property setters
     */      
    public function set snr(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_snr;               
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
    public function set scale(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_scale;               
        if (oldValue !== value)
        {
            _internal_scale = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "scale", oldValue, _internal_scale));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set fabricWidth(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_fabricWidth;               
        if (oldValue !== value)
        {
            _internal_fabricWidth = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "fabricWidth", oldValue, _internal_fabricWidth));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imageLevel(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_imageLevel;               
        if (oldValue !== value)
        {
            _internal_imageLevel = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageLevel", oldValue, _internal_imageLevel));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spatialResolution(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_spatialResolution;               
        if (oldValue !== value)
        {
            _internal_spatialResolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spatialResolution", oldValue, _internal_spatialResolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set temporalResolution(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_temporalResolution;               
        if (oldValue !== value)
        {
            _internal_temporalResolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "temporalResolution", oldValue, _internal_temporalResolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set frequency(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_frequency;               
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
    public function set sensorSARPolarType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_sensorSARPolarType;               
        if (oldValue !== value)
        {
            _internal_sensorSARPolarType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorSARPolarType", oldValue, _internal_sensorSARPolarType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set radiometricResolution(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_radiometricResolution;               
        if (oldValue !== value)
        {
            _internal_radiometricResolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "radiometricResolution", oldValue, _internal_radiometricResolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorSARPolarLst(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_sensorSARPolarLst;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_sensorSARPolarLst = value;
            }
            else if (value is Array)
            {
                _internal_sensorSARPolarLst = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of sensorSARPolarLst must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorSARPolarLst", oldValue, _internal_sensorSARPolarLst));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set band(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_band;               
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
    public function set extendsParams(value:Object) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Object = _internal_extendsParams;               
        if (oldValue !== value)
        {
            _internal_extendsParams = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "extendsParams", oldValue, _internal_extendsParams));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorType(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_sensorType;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_sensorType = value;
            }
            else if (value is Array)
            {
                _internal_sensorType = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of sensorType must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorType", oldValue, _internal_sensorType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set encounterAngle(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_encounterAngle;               
        if (oldValue !== value)
        {
            _internal_encounterAngle = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "encounterAngle", oldValue, _internal_encounterAngle));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set senorWorkType(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_senorWorkType;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_senorWorkType = value;
            }
            else if (value is Array)
            {
                _internal_senorWorkType = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of senorWorkType must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "senorWorkType", oldValue, _internal_senorWorkType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spectralResolution(value:valueObjects.PrimaryImageParameter) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryImageParameter = _internal_spectralResolution;               
        if (oldValue !== value)
        {
            _internal_spectralResolution = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spectralResolution", oldValue, _internal_spectralResolution));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorName(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_sensorName;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_sensorName = value;
            }
            else if (value is Array)
            {
                _internal_sensorName = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of sensorName must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorName", oldValue, _internal_sensorName));
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
    public function get _model() : _PrimaryImageEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _PrimaryImageEntityMetadata) : void       
    {
    	var oldValue : _PrimaryImageEntityMetadata = model_internal::_dminternal_model;               
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
