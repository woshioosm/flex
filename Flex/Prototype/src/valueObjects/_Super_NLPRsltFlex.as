/**
 * This is a generated class and is not intended for modfication.  To customize behavior
 * of this value object you may modify the generated sub-class of this class - NLPRsltFlex.as.
 */

package valueObjects
{
import com.adobe.fiber.services.IFiberManagingService;
import com.adobe.fiber.valueobjects.IValueObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import mx.events.PropertyChangeEvent;
import valueObjects.TDeepframework;
import valueObjects.TNaturallang;
import valueObjects.TNlqueryfeedbackdeep;
import valueObjects.TNlqueryfeedbackshallow;
import valueObjects.TShallowframework;

import flash.net.registerClassAlias;
import flash.net.getClassByAlias;
import com.adobe.fiber.core.model_internal;
import com.adobe.fiber.valueobjects.IPropertyIterator;
import com.adobe.fiber.valueobjects.AvailablePropertyIterator;

use namespace model_internal;

[ExcludeClass]
public class _Super_NLPRsltFlex extends flash.events.EventDispatcher implements com.adobe.fiber.valueobjects.IValueObject
{
    model_internal static function initRemoteClassAliasSingle(cz:Class) : void 
    {
        try 
        {
            if (flash.net.getClassByAlias("cn.edu.whu.lmars.service54.datawrapFlex.NLPRsltFlex") == null)
            {
                flash.net.registerClassAlias("cn.edu.whu.lmars.service54.datawrapFlex.NLPRsltFlex", cz);
            } 
        }
        catch (e:Error) 
        {
            flash.net.registerClassAlias("cn.edu.whu.lmars.service54.datawrapFlex.NLPRsltFlex", cz); 
        }
    }   
     
    model_internal static function initRemoteClassAliasAllRelated() : void 
    {
        valueObjects.TShallowframework.initRemoteClassAliasSingleChild();
        valueObjects.TDeepframework.initRemoteClassAliasSingleChild();
        valueObjects.TNlqueryfeedbackshallow.initRemoteClassAliasSingleChild();
        valueObjects.TNaturallang.initRemoteClassAliasSingleChild();
        valueObjects.Timestamp.initRemoteClassAliasSingleChild();
        valueObjects.TNlqueryfeedbackdeep.initRemoteClassAliasSingleChild();
    }

	model_internal var _dminternal_model : _NLPRsltFlexEntityMetadata;

	/**
	 * properties
	 */
	private var _internal__primaryFrame : valueObjects.TShallowframework;
	private var _internal__deepFrame : valueObjects.TDeepframework;
	private var _internal__feedbackprimaryFrame : valueObjects.TNlqueryfeedbackshallow;
	private var _internal__nl : valueObjects.TNaturallang;
	private var _internal__uuid : String;
	private var _internal__feedbackdeepFrame : valueObjects.TNlqueryfeedbackdeep;

    private static var emptyArray:Array = new Array();

    /**
     * derived property cache initialization
     */  
    model_internal var _cacheInitialized_isValid:Boolean = false;   
    
	model_internal var _changeWatcherArray:Array = new Array();   

	public function _Super_NLPRsltFlex() 
	{	
		_model = new _NLPRsltFlexEntityMetadata(this);
	
		// Bind to own data properties for cache invalidation triggering  
       
	}

    /**
     * data property getters
     */
	[Bindable(event="propertyChange")] 
    public function get _primaryFrame() : valueObjects.TShallowframework    
    {
            return _internal__primaryFrame;
    }    
	[Bindable(event="propertyChange")] 
    public function get _deepFrame() : valueObjects.TDeepframework    
    {
            return _internal__deepFrame;
    }    
	[Bindable(event="propertyChange")] 
    public function get _feedbackprimaryFrame() : valueObjects.TNlqueryfeedbackshallow    
    {
            return _internal__feedbackprimaryFrame;
    }    
	[Bindable(event="propertyChange")] 
    public function get _nl() : valueObjects.TNaturallang    
    {
            return _internal__nl;
    }    
	[Bindable(event="propertyChange")] 
    public function get _uuid() : String    
    {
            return _internal__uuid;
    }    
	[Bindable(event="propertyChange")] 
    public function get _feedbackdeepFrame() : valueObjects.TNlqueryfeedbackdeep    
    {
            return _internal__feedbackdeepFrame;
    }    

    /**
     * data property setters
     */      
    public function set _primaryFrame(value:valueObjects.TShallowframework) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.TShallowframework = _internal__primaryFrame;               
        if (oldValue !== value)
        {
            _internal__primaryFrame = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_primaryFrame", oldValue, _internal__primaryFrame));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _deepFrame(value:valueObjects.TDeepframework) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.TDeepframework = _internal__deepFrame;               
        if (oldValue !== value)
        {
            _internal__deepFrame = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_deepFrame", oldValue, _internal__deepFrame));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _feedbackprimaryFrame(value:valueObjects.TNlqueryfeedbackshallow) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.TNlqueryfeedbackshallow = _internal__feedbackprimaryFrame;               
        if (oldValue !== value)
        {
            _internal__feedbackprimaryFrame = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_feedbackprimaryFrame", oldValue, _internal__feedbackprimaryFrame));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _nl(value:valueObjects.TNaturallang) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.TNaturallang = _internal__nl;               
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
    public function set _uuid(value:String) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:String = _internal__uuid;               
        if (oldValue !== value)
        {
            _internal__uuid = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_uuid", oldValue, _internal__uuid));
        }    	     
        
        if (recalcValid && model_internal::_cacheInitialized_isValid)
        {
            model_internal::isValid_der = model_internal::calculateIsValid();
        }  
    }    
    public function set _feedbackdeepFrame(value:valueObjects.TNlqueryfeedbackdeep) : void 
    {    	
        var recalcValid:Boolean = false;
    	
    	
    	var oldValue:valueObjects.TNlqueryfeedbackdeep = _internal__feedbackdeepFrame;               
        if (oldValue !== value)
        {
            _internal__feedbackdeepFrame = value;
        	this.dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this, "_feedbackdeepFrame", oldValue, _internal__feedbackdeepFrame));
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
    public function get _model() : _NLPRsltFlexEntityMetadata
    {
		return model_internal::_dminternal_model;              
    }	
    
    public function set _model(value : _NLPRsltFlexEntityMetadata) : void       
    {
    	var oldValue : _NLPRsltFlexEntityMetadata = model_internal::_dminternal_model;               
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
