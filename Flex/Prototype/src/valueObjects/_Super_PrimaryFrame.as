/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - PrimaryFrame.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.collections.ArrayCollection;
import mx.events.PropertyChangeEvent;
import valueObjects.PrimaryDescribeList;
import valueObjects.PrimaryImage;
import valueObjects.PrimaryTask;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_PrimaryFrame extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.frame.PrimaryFrame") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.frame.PrimaryFrame", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.frame.PrimaryFrame", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.PrimaryImage.initRemoteClassAliasSingleChild();
        valueObjects.PrimaryImageParameter.initRemoteClassAliasSingleChild();
        valueObjects.PrimaryDescribeList.initRemoteClassAliasSingleChild();
        valueObjects.PrimaryDescribe.initRemoteClassAliasSingleChild();
        valueObjects.PrimaryTask.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _PrimaryFrameEntityMetadata;

	/**
	 * properties
	 */
	private var _internal_frameImages : ArrayCollection;
	model_internal var _internal_frameImages_leaf:valueObjects.PrimaryImage;
	private var _internal_domain : String;
	private var _internal_frameRange : valueObjects.PrimaryDescribeList;
	private var _internal_frameTime : valueObjects.PrimaryDescribeList;
	private var _internal_uuid : String;
	private var _internal_frameTask : valueObjects.PrimaryTask;
	private var _internal_framePlace : valueObjects.PrimaryDescribeList;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_PrimaryFrame() 
	{	
		_model = new _PrimaryFrameEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get frameImages() : ArrayCollection    
    {
            return _internal_frameImages;
    }    
	[Bindable(event="propertyChange")] 
    public function get domain() : String    
    {
            return _internal_domain;
    }    
	[Bindable(event="propertyChange")] 
    public function get frameRange() : valueObjects.PrimaryDescribeList    
    {
            return _internal_frameRange;
    }    
	[Bindable(event="propertyChange")] 
    public function get frameTime() : valueObjects.PrimaryDescribeList    
    {
            return _internal_frameTime;
    }    
	[Bindable(event="propertyChange")] 
    public function get uuid() : String    
    {
            return _internal_uuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get frameTask() : valueObjects.PrimaryTask    
    {
            return _internal_frameTask;
    }    
	[Bindable(event="propertyChange")] 
    public function get framePlace() : valueObjects.PrimaryDescribeList    
    {
            return _internal_framePlace;
    }    

    /**
     * data property setters
     */      
    public function set frameImages(value:*) : void
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:ArrayCollection = _internal_frameImages;               
        if (oldValue !== value)
        {
            if (value is ArrayCollection)
            {
                _internal_frameImages = value;
            }
            else if (value is Array)
            {
                _internal_frameImages = new ArrayCollection(value);
            }
            else
            {
                throw new Error("value of frameImages must be a collection");
            }
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "frameImages", oldValue, _internal_frameImages));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set domain(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
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
    public function set frameRange(value:valueObjects.PrimaryDescribeList) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryDescribeList = _internal_frameRange;               
        if (oldValue !== value)
        {
            _internal_frameRange = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "frameRange", oldValue, _internal_frameRange));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set frameTime(value:valueObjects.PrimaryDescribeList) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryDescribeList = _internal_frameTime;               
        if (oldValue !== value)
        {
            _internal_frameTime = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "frameTime", oldValue, _internal_frameTime));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set uuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
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
    public function set frameTask(value:valueObjects.PrimaryTask) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryTask = _internal_frameTask;               
        if (oldValue !== value)
        {
            _internal_frameTask = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "frameTask", oldValue, _internal_frameTask));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set framePlace(value:valueObjects.PrimaryDescribeList) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.PrimaryDescribeList = _internal_framePlace;               
        if (oldValue !== value)
        {
            _internal_framePlace = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "framePlace", oldValue, _internal_framePlace));
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
    public function get _model() : _PrimaryFrameEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _PrimaryFrameEntityMetadata) : void       
    {
    	var oldValue : _PrimaryFrameEntityMetadata = model_internal::_dminternal_model;               
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
