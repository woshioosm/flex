/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - Conf.as.
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
public class _Super_Conf extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.Conf") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.Conf", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.Conf", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _ConfEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_imgway : String;
	private var _internal_bandmin : Number;
	private var _internal_imagemode : String;
	private var _internal_spectrum : String;
	private var _internal_steroimgway : String;
	private var _internal_type : int;
	private var _internal_spatialmax : Number;
	private var _internal_agility : String;
	private var _internal_tracktype : String;
	private var _internal_polarway : String;
	private var _internal_spatialmin : Number;
	private var _internal_timemax : Number;
	private var _internal_side : String;
	private var _internal_name : String;
	private var _internal_isimg : String;
	private var _internal_timemin : Number;
	private var _internal_spectral : String;
	private var _internal_bandmax : Number;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_Conf() 
	{	
		_model = new _ConfEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get imgway() : String    
    {
            return _internal_imgway;
    }    
	[Bindable(event="propertyChange")] 
    public function get bandmin() : Number    
    {
            return _internal_bandmin;
    }    
	[Bindable(event="propertyChange")] 
    public function get imagemode() : String    
    {
            return _internal_imagemode;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectrum() : String    
    {
            return _internal_spectrum;
    }    
	[Bindable(event="propertyChange")] 
    public function get steroimgway() : String    
    {
            return _internal_steroimgway;
    }    
	[Bindable(event="propertyChange")] 
    public function get type() : int    
    {
            return _internal_type;
    }    
	[Bindable(event="propertyChange")] 
    public function get spatialmax() : Number    
    {
            return _internal_spatialmax;
    }    
	[Bindable(event="propertyChange")] 
    public function get agility() : String    
    {
            return _internal_agility;
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
    public function get spatialmin() : Number    
    {
            return _internal_spatialmin;
    }    
	[Bindable(event="propertyChange")] 
    public function get timemax() : Number    
    {
            return _internal_timemax;
    }    
	[Bindable(event="propertyChange")] 
    public function get side() : String    
    {
            return _internal_side;
    }    
	[Bindable(event="propertyChange")] 
    public function get name() : String    
    {
            return _internal_name;
    }    
	[Bindable(event="propertyChange")] 
    public function get isimg() : String    
    {
            return _internal_isimg;
    }    
	[Bindable(event="propertyChange")] 
    public function get timemin() : Number    
    {
            return _internal_timemin;
    }    
	[Bindable(event="propertyChange")] 
    public function get spectral() : String    
    {
            return _internal_spectral;
    }    
	[Bindable(event="propertyChange")] 
    public function get bandmax() : Number    
    {
            return _internal_bandmax;
    }    

    /**
     * data property setters
     */      
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
    public function set bandmin(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_bandmin;               
        if (oldValue !== value)
        {
            _internal_bandmin = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bandmin", oldValue, _internal_bandmin));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imagemode(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imagemode == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_imagemode;               
        if (oldValue !== value)
        {
            _internal_imagemode = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imagemode", oldValue, _internal_imagemode));
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
    public function set type(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_type;               
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
    public function set spatialmax(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_spatialmax;               
        if (oldValue !== value)
        {
            _internal_spatialmax = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spatialmax", oldValue, _internal_spatialmax));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set agility(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_agility == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_agility;               
        if (oldValue !== value)
        {
            _internal_agility = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "agility", oldValue, _internal_agility));
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
    public function set spatialmin(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_spatialmin;               
        if (oldValue !== value)
        {
            _internal_spatialmin = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spatialmin", oldValue, _internal_spatialmin));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set timemax(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_timemax;               
        if (oldValue !== value)
        {
            _internal_timemax = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timemax", oldValue, _internal_timemax));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set side(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_side == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_side;               
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
    public function set timemin(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_timemin;               
        if (oldValue !== value)
        {
            _internal_timemin = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "timemin", oldValue, _internal_timemin));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set spectral(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_spectral == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_spectral;               
        if (oldValue !== value)
        {
            _internal_spectral = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "spectral", oldValue, _internal_spectral));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set bandmax(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_bandmax;               
        if (oldValue !== value)
        {
            _internal_bandmax = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "bandmax", oldValue, _internal_bandmax));
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
		if (_model.isImagemodeAvailable && _internal_imagemode == null)
		{
			violatedConsts.push("imagemodeIsRequired");
			validationFailureMessages.push("imagemode is required");
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
		if (_model.isAgilityAvailable && _internal_agility == null)
		{
			violatedConsts.push("agilityIsRequired");
			validationFailureMessages.push("agility is required");
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
		if (_model.isSideAvailable && _internal_side == null)
		{
			violatedConsts.push("sideIsRequired");
			validationFailureMessages.push("side is required");
		}
		if (_model.isNameAvailable && _internal_name == null)
		{
			violatedConsts.push("nameIsRequired");
			validationFailureMessages.push("name is required");
		}
		if (_model.isIsimgAvailable && _internal_isimg == null)
		{
			violatedConsts.push("isimgIsRequired");
			validationFailureMessages.push("isimg is required");
		}
		if (_model.isSpectralAvailable && _internal_spectral == null)
		{
			violatedConsts.push("spectralIsRequired");
			validationFailureMessages.push("spectral is required");
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
    public function get _model() : _ConfEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _ConfEntityMetadata) : void       
    {
    	var oldValue : _ConfEntityMetadata = model_internal::_dminternal_model;               
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
