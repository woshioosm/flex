/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - AdvancedFrame.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.AdvancedImageParameter;
import valueObjects.AdvancedRange;
import valueObjects.AdvancedTime;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_AdvancedFrame extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.frame.AdvancedFrame") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedFrame", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.frame.AdvancedFrame", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.AdvancedRange.initRemoteClassAliasSingleChild();
        valueObjects.AdvancedImageParameter.initRemoteClassAliasSingleChild();
        valueObjects.AdvancedDoubleMinMaxDescribe.initRemoteClassAliasSingleChild();
        valueObjects.AdvancedTime.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _AdvancedFrameEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_imageRanges : ArrayCollection;
	model_internal var _internal_imageRanges_leaf:valueObjects.AdvancedRange;
	private var _internal_imageParameters : ArrayCollection;
	model_internal var _internal_imageParameters_leaf:valueObjects.AdvancedImageParameter;
	private var _internal_area : Number;
	private var _internal_taskIDReasonRule : String;
	private var _internal_domain : String;
	private var _internal_imageTimes : ArrayCollection;
	model_internal var _internal_imageTimes_leaf:valueObjects.AdvancedTime;
	private var _internal_uuid : String;
	private var _internal_taskName : String;
	private var _internal_taskID : String;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_AdvancedFrame() 
	{	
		_model = new _AdvancedFrameEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get imageRanges() : ArrayCollection    
    {
            return _internal_imageRanges;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageParameters() : ArrayCollection    
    {
            return _internal_imageParameters;
    }    
	[Bindable(event="propertyChange")] 
    public function get area() : Number    
    {
            return _internal_area;
    }    
	[Bindable(event="propertyChange")] 
    public function get taskIDReasonRule() : String    
    {
            return _internal_taskIDReasonRule;
    }    
	[Bindable(event="propertyChange")] 
    public function get domain() : String    
    {
            return _internal_domain;
    }    
	[Bindable(event="propertyChange")] 
    public function get imageTimes() : ArrayCollection    
    {
            return _internal_imageTimes;
    }    
	[Bindable(event="propertyChange")] 
    public function get uuid() : String    
    {
            return _internal_uuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get taskName() : String    
    {
            return _internal_taskName;
    }    
	[Bindable(event="propertyChange")] 
    public function get taskID() : String    
    {
            return _internal_taskID;
    }    

    /**
     * data property setters
     */      
    public function set imageRanges(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imageRanges == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_imageRanges;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_imageRanges = value;
            }
            else if (value is Array)
            {
                _internal_imageRanges = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of imageRanges must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageRanges", oldValue, _internal_imageRanges));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imageParameters(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imageParameters == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_imageParameters;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_imageParameters = value;
            }
            else if (value is Array)
            {
                _internal_imageParameters = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of imageParameters must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageParameters", oldValue, _internal_imageParameters));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set area(value:Number) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:Number = _internal_area;               
        if (oldValue !== value)
        {
            _internal_area = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "area", oldValue, _internal_area));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set taskIDReasonRule(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_taskIDReasonRule == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_taskIDReasonRule;               
        if (oldValue !== value)
        {
            _internal_taskIDReasonRule = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "taskIDReasonRule", oldValue, _internal_taskIDReasonRule));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set domain(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_domain == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_domain;               
        if (oldValue !== value)
        {
            _internal_domain = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "domain", oldValue, _internal_domain));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set imageTimes(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_imageTimes == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:ArrayCollection = _internal_imageTimes;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_imageTimes = value;
            }
            else if (value is Array)
            {
                _internal_imageTimes = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of imageTimes must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "imageTimes", oldValue, _internal_imageTimes));
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
    public function set taskName(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_taskName == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
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
    public function set taskID(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	if (value == null || _internal_taskID == null)
    	{
    		recalcValid = true;
    	}	
    	
    	
    	var oldValue:String = _internal_taskID;               
        if (oldValue !== value)
        {
            _internal_taskID = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "taskID", oldValue, _internal_taskID));
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

		if (_model.isImageRangesAvailable && _internal_imageRanges == null)
		{
			violatedConsts.push("imageRangesIsRequired");
			validationFailureMessages.push("imageRanges is required");
		}
		if (_model.isImageParametersAvailable && _internal_imageParameters == null)
		{
			violatedConsts.push("imageParametersIsRequired");
			validationFailureMessages.push("imageParameters is required");
		}
		if (_model.isTaskIDReasonRuleAvailable && _internal_taskIDReasonRule == null)
		{
			violatedConsts.push("taskIDReasonRuleIsRequired");
			validationFailureMessages.push("taskIDReasonRule is required");
		}
		if (_model.isDomainAvailable && _internal_domain == null)
		{
			violatedConsts.push("domainIsRequired");
			validationFailureMessages.push("domain is required");
		}
		if (_model.isImageTimesAvailable && _internal_imageTimes == null)
		{
			violatedConsts.push("imageTimesIsRequired");
			validationFailureMessages.push("imageTimes is required");
		}
		if (_model.isUuidAvailable && _internal_uuid == null)
		{
			violatedConsts.push("uuidIsRequired");
			validationFailureMessages.push("uuid is required");
		}
		if (_model.isTaskNameAvailable && _internal_taskName == null)
		{
			violatedConsts.push("taskNameIsRequired");
			validationFailureMessages.push("taskName is required");
		}
		if (_model.isTaskIDAvailable && _internal_taskID == null)
		{
			violatedConsts.push("taskIDIsRequired");
			validationFailureMessages.push("taskID is required");
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
    public function get _model() : _AdvancedFrameEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _AdvancedFrameEntityMetadata) : void       
    {
    	var oldValue : _AdvancedFrameEntityMetadata = model_internal::_dminternal_model;               
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
