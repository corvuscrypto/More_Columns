@isTest
Private class TestLineItemProvider {
	@isTest static void assertReturn(){
        Opportunity o = new Opportunity(Name='test',StageName='Prospecting',CloseDate=Date.today());
        insert o;
        System.Test.startTest();
        System.Test.setCurrentPage(Page.columnRestraintBypass);
        LineItemProvider l = new LineItemProvider(new ApexPages.StandardController(o));
		boolean isString=false;
        boolean isList=false;
        if(l.getItemProvider().length() > 0){
            isString = true;
        }
        if(l.getLineIds().size() >= 0){
    		isList = true;
		}
        
        l.toDelete=o.Id;
        l.DelLineItem();
        delete o;
        
        String items = l.getItemProvider();
        System.assert(isString&&isList);
        System.Test.stopTest();
    }
}