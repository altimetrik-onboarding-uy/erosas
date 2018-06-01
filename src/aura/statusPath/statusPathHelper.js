({
    markStatus:function(component, statuss){      
       var action = component.get("c.getPostStatus");       
       var opts = [];
       action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                //component.set("v.statusList",allValues);                
                for (var i = 0; i < allValues.length; i++) {
                    if(allValues[i]==statuss){
                        $A.util.addClass(component.find(allValues[i]), 'slds-is-current'); 
                    }else{
                        $A.util.removeClass(component.find(allValues[i]), 'slds-is-current');
                    } 
                }
            }
        });
        $A.enqueueAction(action);          
    },
    sendMessage:function(component, saveResult){
        var toastEvent = $A.get("e.force:showToast");
                            var txt= "Problem saving record, error: " + saveResult.error[0].message;
                            toastEvent.setParams({
                                "title": "Error!",
                                "type": "error",
                                "message": txt
                            });
                            toastEvent.fire();   
    },
    ErrorMessageOnLoadRecord:function(component,error){
       var toastEvent = $A.get("e.force:showToast");
                            var txt= "Problem saving record, error: " + error;
                            toastEvent.setParams({
                                "title": "Error!",
                                "type": "error",
                                "message": txt
                            });
                            toastEvent.fire();   
    },
})