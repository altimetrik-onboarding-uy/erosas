global class sendEmailEveryDay implements Schedulable{
	 global void execute(SchedulableContext SC) { 
        SendEmailListofPoststoReview m = new SendEmailListofPoststoReview();   
        database.executeBatch(m);
        //String sch = '0 0 0 * * ?'; 
	    //String jobID = system.schedule('Email everyday', sch, m);
     }
}