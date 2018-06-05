({
    handleRecordUpdated:function(component,event,helper){
        //Get imputtext
        var ptxt = component.get("v.labelText");
        //Process the text with marked.js and set the output
        ptxt = marked(ptxt);
        component.set("v.labelProcessed", ptxt);   
    },
    recordUpdated: function(component, event, helper) { 
        
        //Clear outputfield
        component.set("v.labelProcessed","");
        //Get imputtext
        var ptxt = component.get("v.labelText");
        //Process the text with marked.js and set the output
        ptxt = marked(ptxt);
        component.set("v.labelProcessed", ptxt); 
        //Save the record after 3 sec
        setTimeout(function(){component.find("postRecordLoader").saveRecord(
            $A.getCallback(function(saveResult) {
                //Manage state no needed
            //if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
            //    console.log("Save completed successfully.");
            //} else if (saveResult.state === "INCOMPLETE") {
            //    console.log("User is offline, device doesn't support drafts.");
            //} else if (saveResult.state === "ERROR") {
            //    console.log('Problem saving record, error: ' + 
            //               JSON.stringify(saveResult.error));
            //} else {
            //    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
            //}   
            }));}, 3000);  
        
 	},
    keyCheck : function(component, event, helper){ 
        var ctrlPressed=0;
        var shiftPressed=0;
        shiftPressed=event.shiftKey;
        ctrlPressed =event.ctrlKey;
        var txt = "" + component.get("v.labelText");
        var cB = "****";
        var cI = "**";
        var cL = "````";
        var cSL = "``````";
        if ((shiftPressed || ctrlPressed)&& (event.keyCode<16 || event.keyCode>18)) {        
        // Ctrl + b
        if(ctrlPressed && (event.keyCode==66)){
             txt = txt + cB;            
        } else 
            // Ctrl + i    
            if(ctrlPressed && (event.keyCode==73)){
                 txt = txt+ cI;
            } else
                // Ctrl + l
                if ((ctrlPressed && !shiftPressed) && (event.keyCode==76)){
                     txt = txt+ cL;
                } else
                    // Ctrl + Shift + l
                    if((shiftPressed && ctrlPressed)&& (event.keyCode==76)){
                        txt = txt + cSL;
                    }
            component.set("v.labelText",txt);
        } 
    }
        
})