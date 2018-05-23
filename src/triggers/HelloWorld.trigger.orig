trigger HelloWorld on Account (before insert) {
	integer i = 0;
    for(Account a : Trigger.New) {
	    a.Description = 'New description';
        System.debug('' + i);
        i++;
	} 
}