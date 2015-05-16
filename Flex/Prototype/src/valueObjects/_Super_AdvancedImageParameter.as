/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - AdvancedImageParameter.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.AdvancedDoubleMinMaxDescribe;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_AdvancedImageParameter extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.frame.AdvancedImageParameter") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedImageParameter", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedImageParameter", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.AdvancedDoubleMinMaxDescribe.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _AdvancedImageParameterEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_snr : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_scale : int;
	private var _internal_fabricWidth : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_bands : ArrayCollection;
	model_internal var _internal_bands_leaf:valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_extendsParam : Object;
	private var _internal_sensorSARPloarType : String;
	private var _internal_spectralresolution : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_imageLevel : int;
	private var _internal_spatialResolution : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_temporalResolution : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_frequency : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_sensorNames : ArrayCollection;
	private var _internal_radiometricResolution : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_sensorSARPolarLst : ArrayCollection;
	private var _internal_sensorType : ArrayCollection;
	private var _internal_encounterAngle : valueObjects.AdvancedDoubleMinMaxDescribe;
	private var _internal_senorWorkType : ArrayCollection;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_AdvancedImageParameter() 
	{	
		_model = new _AdvancedImageParameterEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get snr() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_snr;
    }    
	[Bindable(event="propertyChange")] 
    public function get scale() : int    
    {
            return _internal_scale;
    }    
	[Bindable(event="propertyChange")] 
    public function get fabricWidth() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_fabricWidth;
    }    
	[Bindable(event="propertyChange")] 
    public function get bands() : ArrayCollection    
    {
            return _internal_bands;
    }    
	[Bindable(event="propertyChange")] 
    public function get extendsParam() : Object    
    {
            return _internal_extendsParam;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorSARPloarType() : String    
    {
            return _internal_sensorSARPloarType;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectralresolution() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_spectralresolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageLevel() : int    
    {
            return _internal_imageLevel;
    }    
	[Bindable(event="propertyChange")] 
    public function get spatialResolution() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_spatialResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get temporalResolution() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_temporalResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get frequency() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_frequency;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorNames() : ArrayCollection    
    {
            return _internal_sensorNames;
    }    
	[Bindable(event="propertyChange")] 
    public function get radiometricResolution() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_radiometricResolution;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorSARPolarLst() : ArrayCollection    
    {
            return _internal_sensorSARPolarLst;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorType() : ArrayCollection    
    {
            return _internal_sensorType;
    }    
	[Bindable(event="propertyChange")] 
    public function get encounterAngle() : valueObjects.AdvancedDoubleMinMaxDescribe    
    {
            return _internal_encounterAngle;
    }    
	[Bindable(event="propertyChange")] 
    public function get senorWorkType() : ArrayCollection    
    {
            return _internal_senorWorkType;
    }    

    /**
     * data property setters
     */      
    public function set snr(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_snr == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_snr;               
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
    public function set scale(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_scale;               
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
    public function set fabricWidth(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_fabricWidth == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_fabricWidth;               
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
    public function set bands(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_bands == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_bands;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_bands = value;
            }
            else if (value is Array)
            {
                _internal_bands = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of bands must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bands", oldValue, _internal_bands));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set extendsParam(value:Object) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_extendsParam == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:Object = _internal_extendsParam;               
        if (oldValue !== value)
        {
            _internal_extendsParam = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "extendsParam", oldValue, _internal_extendsParam));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorSARPloarType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sensorSARPloarType == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_sensorSARPloarType;               
        if (oldValue !== value)
        {
            _internal_sensorSARPloarType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorSARPloarType", oldValue, _internal_sensorSARPloarType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spectralresolution(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_spectralresolution == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_spectralresolution;               
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
    public function set imageLevel(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_imageLevel;               
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
    public function set spatialResolution(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_spatialResolution == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_spatialResolution;               
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
    public function set temporalResolution(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_temporalResolution == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_temporalResolution;               
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
    public function set frequency(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_frequency == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_frequency;               
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
    public function set sensorNames(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sensorNames == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_sensorNames;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_sensorNames = value;
            }
            else if (value is Array)
            {
                _internal_sensorNames = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of sensorNames must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "sensorNames", oldValue, _internal_sensorNames));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set radiometricResolution(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_radiometricResolution == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_radiometricResolution;               
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
    	if (value == null || _internal_sensorSARPolarLst == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
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
    public function set sensorType(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_sensorType == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
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
    public function set encounterAngle(value:valueObjects.AdvancedDoubleMinMaxDescribe) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_encounterAngle == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:valueObjects.AdvancedDoubleMinMaxDescribe = _internal_encounterAngle;               
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
    	if (value == null || _internal_senorWorkType == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
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

		if (_model.isSnrAvailable && _internal_snr == null)
		{
			violatedConsts.push("snrIsRequired");
			validationFailureMessages.push("snr is required");
		}
		if (_model.isFabricWidthAvailable && _internal_fabricWidth == null)
		{
			violatedConsts.push("fabricWidthIsRequired");
			validationFailureMessages.push("fabricWidth is required");
		}
		if (_model.isBandsAvailable && _internal_bands == null)
		{
			violatedConsts.push("bandsIsRequired");
			validationFailureMessages.push("bands is required");
		}
		if (_model.isExtendsParamAvailable && _internal_extendsParam == null)
		{
			violatedConsts.push("extendsParamIsRequired");
			validationFailureMessages.push("extendsParam is required");
		}
		if (_model.isSensorSARPloarTypeAvailable && _internal_sensorSARPloarType == null)
		{
			violatedConsts.push("sensorSARPloarTypeIsRequired");
			validationFailureMessages.push("sensorSARPloarType is required");
		}
		if (_model.isSpectralresolutionAvailable && _internal_spectralresolution == null)
		{
			violatedConsts.push("spectralresolutionIsRequired");
			validationFailureMessages.push("spectralresolution is required");
		}
		if (_model.isSpatialResolutionAvailable && _internal_spatialResolution == null)
		{
			violatedConsts.push("spatialResolutionIsRequired");
			validationFailureMessages.push("spatialResolution is required");
		}
		if (_model.isTemporalResolutionAvailable && _internal_temporalResolution == null)
		{
			violatedConsts.push("temporalResolutionIsRequired");
			validationFailureMessages.push("temporalResolution is required");
		}
		if (_model.isFrequencyAvailable && _internal_frequency == null)
		{
			violatedConsts.push("frequencyIsRequired");
			validationFailureMessages.push("frequency is required");
		}
		if (_model.isSensorNamesAvailable && _internal_sensorNames == null)
		{
			violatedConsts.push("sensorNamesIsRequired");
			validationFailureMessages.push("sensorNames is required");
		}
		if (_model.isRadiometricResolutionAvailable && _internal_radiometricResolution == null)
		{
			violatedConsts.push("radiometricResolutionIsRequired");
			validationFailureMessages.push("radiometricResolution is required");
		}
		if (_model.isSensorSARPolarLstAvailable && _internal_sensorSARPolarLst == null)
		{
			violatedConsts.push("sensorSARPolarLstIsRequired");
			validationFailureMessages.push("sensorSARPolarLst is required");
		}
		if (_model.isSensorTypeAvailable && _internal_sensorType == null)
		{
			violatedConsts.push("sensorTypeIsRequired");
			validationFailureMessages.push("sensorType is required");
		}
		if (_model.isEncounterAngleAvailable && _internal_encounterAngle == null)
		{
			violatedConsts.push("encounterAngleIsRequired");
			validationFailureMessages.push("encounterAngle is required");
		}
		if (_model.isSenorWorkTypeAvailable && _internal_senorWorkType == null)
		{
			violatedConsts.push("senorWorkTypeIsRequired");
			validationFailureMessages.push("senorWorkType is required");
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
    public function get _model() : _AdvancedImageParameterEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _AdvancedImageParameterEntityMetadata) : void       
    {
    	var oldValue : _AdvancedImageParameterEntityMetadata = model_internal::_dminternal_model;               
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
