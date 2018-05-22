trigger ApprovalProcessTrigger on Post__c (after update ) {
	List<Approval.ProcessSubmitRequest> approvalReqList=new List<Approval.ProcessSubmitRequest>();
    Id currentUserId = UserInfo.getUserId();
    User cUser = [SELECT Id,managerId FROM User where Id=:currentUserId];     
   
    try {
        for(Post__c p: Trigger.new){          
            if(trigger.oldMap.get(p.Id).Status__c != p.Status__c &&  p.Status__c == 'Under Review'){
                Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();  
   				req.setComments('Submitted for approval. Please approve.');
   				req.setObjectId(p.Id);
                req.setNextApproverIds(new List<Id>{cUser.ManagerId}); 
                approvalReqList.add(req);
            }
    	}
        List<Approval.ProcessResult> resultList = Approval.process(approvalReqList);
        } catch (exception e) {
            Trigger.new[0].addError('text'+e.getMessage());
        }
}