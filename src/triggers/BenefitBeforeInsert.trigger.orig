/**
*	QA Training Package 1A
*/
trigger BenefitBeforeInsert on Benefit__c (before insert) {
	
	// This trigger sets the email address to send an email 
	
	List<ID> contactIDList = new List<ID>();
	
	for(Benefit__c b : Trigger.new){
		contactIDList.add(b.Employee__c);
	}
	
	Map<Id, Contact> contactList = new Map<Id, Contact>([ SELECT c.Id, c.Email FROM Contact c WHERE c.Id IN: contactIDList ]);
	
	for(Benefit__c b : Trigger.new){
		b.Employee_Email__c = contactList.get(b.Employee__c).Email;
	}
	
}