/**
*	QA Training Package 1A
*/
public with sharing class BenefitsPerEmployee {
	
	public List<Benefit__c> 	benefits 	{ get; set; }	// list of benefits
	
	public String 				title 		{ get; set; } 	// title of the table of results
	
	public String 				buttonText 	{ get; set; } 	// text of the button to switch between all and most recent benefits
	
	Integer 					mode 		{ get; set; } 	// 0 - All
															// 1 - Most Recent
	
	String 						employeeId 	{ get; set; }	// id of the employee
	
	
	/**
	*	Constructor of the class
	*	If it receives the id of an employee
	*/
	public BenefitsPerEmployee(){
		employeeId = Apexpages.currentPage().getParameters().get('eId');
		
		showAll(employeeId);
		
	}
	
	/**
	*	Refreshes the page with the corresponding list of benefits
	*/
	public PageReference refresh(){
		if(mode == 0){
			benefits = showMostRecent(employeeId);
		}else{
			showAll(employeeId);
		}
		return null;
	}
	
	/**
	*	Shows all benefits for all employees or the selected employee
	*	@param par		id of the employee
	*/
	void showAll(String par){
		mode = 0;
		if((par == null) || (par == '')){
			benefits = [ 	SELECT 		b.Net_Pay__c, 
										b.Is_approved__c, 
										b.Has_Medical_Insurance__c, 
										b.Has_Dental_Vision_Insurance__c, 
										b.Gross_Pay__c, 
										b.Employee__r.Department, 
										b.Employee__r.Title, 
										b.Employee__r.Name, 
										b.Employee__c 
							FROM 		Benefit__c b 
							ORDER BY 	b.Employee__r.Name asc, b.LastModifiedDate desc ];
			buttonText = 'Show Most Recent Benefits';
			title = 'All Benefits';
		}else{
			benefits = [ 	SELECT 		b.Net_Pay__c, 
										b.Is_approved__c, 
										b.Has_Medical_Insurance__c, 
										b.Has_Dental_Vision_Insurance__c, 
										b.Gross_Pay__c, 
										b.Employee__r.Department, 
										b.Employee__r.Title, 
										b.Employee__r.Name, 
										b.Employee__c 
							FROM 		Benefit__c b
							WHERE		b.Employee__c =: par 
							ORDER BY 	b.Employee__r.Name asc, b.LastModifiedDate desc ];
			buttonText = 'Show Most Recent Benefit of this Employee';
			title = 'All Benefits of the Employee';
		}
	}
	
	/**
	*	Shows the most recent benefits for all employees or the selected employee
	*	@param par		id of the employee
	*	@return			list of the most recent benefits for all employees or the selected employee
	*/
	List<Benefit__c> showMostRecent(String par){
		mode = 1;
		List<Benefit__c> results = new List<Benefit__c>();
		
		if((par == null) || (par == '')){
			Set<ID> employeeIDList = new Set<ID>();
			for(Benefit__c b : benefits){
				if(!employeeIDList.contains(b.Employee__c)){
					results.add(b);
					employeeIDList.add(b.Employee__c);
				}
			}
			buttonText = 'Show All Benefits';
			title = 'Most Recent Benefits';
		}else{
			if(!benefits.isEmpty()){
				results.add(benefits.get(0));
			}
			buttonText = 'Show All Benefits of this Employee';
			title = 'Most Recent Benefits of the Employee';
		}
		
		return results;
	}
	
	static testMethod void testBenefitsPerEmployee(){
		
		Test.startTest();
		
		List<Contact> contactList = [ SELECT c.Id FROM Contact c LIMIT 5 ];
		for(Contact c : contactList){
			c.Email = 'test@test.com';
		}
		upsert contactList;
		
		List<Benefit__c> benefits = new List<Benefit__c>();
		
		for(Contact c : contactList){
			Benefit__c b = new Benefit__c();
			b.Employee__c = c.Id;
			b.Gross_Pay__c = 5001;
			benefits.add(b);
		}
		
		upsert benefits;
		
		BenefitsPerEmployee controller = new BenefitsPerEmployee();
		controller.refresh();
		controller.refresh();
		
		Apexpages.currentPage().getParameters().put('eId', contactList.get(0).Id);
		
		controller = new BenefitsPerEmployee();
		controller.refresh();
		controller.refresh();
		
		Test.stopTest();
		
	}
	
}