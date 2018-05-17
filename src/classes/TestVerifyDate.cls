@isTest
public class TestVerifyDate {

     @isTest static void testDate1MayDate2() {
         	Date d= Date.today();
            Date d2 = Date.newInstance(d.year(),3,1);
		    Date d1 = Date.newInstance(d.year(),3,31);
	        Date ret = VerifyDate.CheckDates(d1,d2);
	        System.assertEquals(ret, d1);
	    }
    @isTest static void testDate1MenDate2() {
            Date d= Date.today();
            Date d1 = Date.newInstance(d.year(),3,1);
		    Date d2 = Date.newInstance(d.year(),5,31);
	        Date ret = VerifyDate.CheckDates(d1,d2);
	        System.assertEquals(ret, d1);
	    }
    @isTest static void testDate2w29d() {
            Date d1 = Date.today();
         	Integer totalDays = Date.daysInMonth(d1.year(), d1.month());
        	integer dif = totalDays - d1.day();
        	integer loqfalta = 29-dif;
		    Date d2 = Date.newInstance(d1.year(), d1.month(), d1.day()+loqfalta);
	        Date ret = VerifyDate.CheckDates(d1,d2);
	        System.assertEquals(ret, d2);
	    }
    @isTest static void testDate2w30d() {
            Date d1 = Date.today();
         	Integer totalDays = Date.daysInMonth(d1.year(), d1.month());
        	integer dif = totalDays - d1.day();
        	integer loqfalta = 30-dif;
		    Date d2 = Date.newInstance(d1.year(), d1.month(), d1.day()+loqfalta);
	        Date ret = VerifyDate.CheckDates(d1,d2);
	        System.assertEquals(ret, d2);
	    }
    @isTest static void testDate2w31d() {
            Date d= Date.today();
            Date d1 = Date.newInstance(d.year(),3,1);/*
         	Integer totalDays = Date.daysInMonth(d1.year(), d1.month());
        	integer dif = totalDays - d1.day();
        	integer loqfalta = 31-dif;*/
		    Date d2 = Date.newInstance(d.year(),4,1);
	        Date ret = VerifyDate.CheckDates(d1,d2);
	        System.assertEquals(ret, d1);
	    }
    @isTest static void testLastDay() {
         	Date d1 = Date.today();
            Date d2 = Date.newInstance(d1.year(), d1.month()-1, d1.day());
	        Date ret = VerifyDate.CheckDates(d1,d2);
            Integer totalDays = Date.daysInMonth(d1.year(), d1.month());
	        System.assertEquals(ret.day(), totalDays);
	    }    
    
    
    
    
    
    
    
    
    
    
}