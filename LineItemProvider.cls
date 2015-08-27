public class LineItemProvider {
    	private final Id id;
    public string toDelete{get;set;}
    public LineItemProvider(ApexPages.StandardController controller) {
        	this.id = controller.getId();
    }
    public /*List<OpportunityLineItem>*/ string getItemProvider(){
       /* DescribeSObjectResult res = OpportunityLineItem.sObjectType.getDescribe();
       
        string colStr = "";
        Field[] fields = res.getFields();
        for(Field r:res){
            colStr += r.getName()+",";
        }
        colStr = colStr.substring(0, colStr.length()-1);
        return [SELECT :colStr FROM OpportunityLineItem WHERE OpportunityId= :ApexPages.currentPage().getParameters().get('Id')];*/
        
        Map<String, Schema.SObjectField> nm = Schema.sObjectType.OpportunityLineItem.fields.getMap();
        String l = '';
        for(String f : nm.keySet()){
           l += f+',';
        }
        l=l.substring(0,l.length()-1);
        
        List<OpportunityLineItem> ol = database.query('SELECT '+l+' FROM OpportunityLineItem WHERE OpportunityId=\''+string.valueOf(this.id)+'\'');

        JSONGenerator jg = JSON.createGenerator(false);
        jg.writeStartObject();
        jg.writeObjectField('fields',nm.keySet());
        jg.writeObjectField('data',ol);
        jg.writeEndObject();
        return jg.getAsString();
    }
    
    public PageReference DelLineItem() {
       
        	List<OpportunityLineItem> oppItem = [SELECT id FROM OpportunityLineItem where id=:this.toDelete];
        	delete oppItem;
        	return ApexPages.currentPage();
        
    }
    public List<string> getLineIds(){
        	List<string> ids = new List<string>();
        	List<OpportunityLineItem> line = [SELECT Id FROM OpportunityLineItem where OpportunityId=:string.valueOf(this.id)];
        	for(OpportunityLineItem opp : line){
            	ids.add(string.valueOf(opp.Id));
        	}	
        return ids;
    }

}