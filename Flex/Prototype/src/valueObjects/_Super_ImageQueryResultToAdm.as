/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - ImageQueryResultToAdm.as.
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
public class _Super_ImageQueryResultToAdm extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.model.ImageQueryResultToAdm") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.model.ImageQueryResultToAdm", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.model.ImageQueryResultToAdm", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
    }

	model_internal var _dminternal_model : _ImageQueryResultToAdmEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_imageTime : String;
	private var _internal_username : String;
	private var _internal_coords : String;
	private var _internal_similarityValues : ArrayCollection;
	private var _internal_imagePath : String;
	private var _internal_detailCompareInfo : ArrayCollection;
	private var _internal_no : int;
	private var _internal_imageSensorType : String;
	private var _internal_productUUID : String;
	private var _internal_imageSpatialResol : String;
	private var _internal_sensorName : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_ImageQueryResultToAdm() 
	{	
		_model = new _ImageQueryResultToAdmEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get imageTime() : String    
    {
            return _internal_imageTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get username() : String    
    {
            return _internal_username;
    }    
	[Bindable(event="propertyChange")] 
    public function get coords() : String    
    {
            return _internal_coords;
    }    
	[Bindable(event="propertyChange")] 
    public function get similarityValues() : ArrayCollection    
    {
            return _internal_similarityValues;
    }    
	[Bindable(event="propertyChange")] 
    public function get imagePath() : String    
    {
            return _internal_imagePath;
    }    
	[Bindable(event="propertyChange")] 
    public function get detailCompareInfo() : ArrayCollection    
    {
            return _internal_detailCompareInfo;
    }    
	[Bindable(event="propertyChange")] 
    public function get no() : int    
    {
            return _internal_no;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageSensorType() : String    
    {
            return _internal_imageSensorType;
    }    
	[Bindable(event="propertyChange")] 
    public function get productUUID() : String    
    {
            return _internal_productUUID;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageSpatialResol() : String    
    {
            return _internal_imageSpatialResol;
    }    
	[Bindable(event="propertyChange")] 
    public function get sensorName() : String    
    {
            return _internal_sensorName;
    }    

    /**
     * data property setters
     */      
    public function set imageTime(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_imageTime;               
        if (oldValue !== value)
        {
            _internal_imageTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageTime", oldValue, _internal_imageTime));
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
    public function set coords(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_coords;               
        if (oldValue !== value)
        {
            _internal_coords = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "coords", oldValue, _internal_coords));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set similarityValues(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_similarityValues;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_similarityValues = value;
            }
            else if (value is Array)
            {
                _internal_similarityValues = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of similarityValues must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "similarityValues", oldValue, _internal_similarityValues));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imagePath(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_imagePath;               
        if (oldValue !== value)
        {
            _internal_imagePath = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imagePath", oldValue, _internal_imagePath));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set detailCompareInfo(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_detailCompareInfo;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_detailCompareInfo = value;
            }
            else if (value is Array)
            {
                _internal_detailCompareInfo = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of detailCompareInfo must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "detailCompareInfo", oldValue, _internal_detailCompareInfo));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set no(value:int) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:int = _internal_no;               
        if (oldValue !== value)
        {
            _internal_no = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "no", oldValue, _internal_no));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imageSensorType(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_imageSensorType;               
        if (oldValue !== value)
        {
            _internal_imageSensorType = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageSensorType", oldValue, _internal_imageSensorType));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set productUUID(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_productUUID;               
        if (oldValue !== value)
        {
            _internal_productUUID = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "productUUID", oldValue, _internal_productUUID));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imageSpatialResol(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_imageSpatialResol;               
        if (oldValue !== value)
        {
            _internal_imageSpatialResol = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageSpatialResol", oldValue, _internal_imageSpatialResol));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set sensorName(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal_sensorName;               
        if (oldValue !== value)
        {
            _internal_sensorName = value;
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
    public function get _model() : _ImageQueryResultToAdmEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _ImageQueryResultToAdmEntityMetadata) : void       
    {
    	var oldValue : _ImageQueryResultToAdmEntityMetadata = model_internal::_dminternal_model;               
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
