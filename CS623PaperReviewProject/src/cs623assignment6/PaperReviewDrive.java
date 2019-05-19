package cs623assignment6;

//STEP 1. Import required packages
import java.sql.*;

public class PaperReviewDrive {
 // JDBC driver name and database URL
 static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
 static final String DB_URL = "jdbc:mysql://localhost:3306/CONFERENCE_REVIEW?useLegacyDatetimeCode=false&serverTimezone=UTC";
 
 static final String USER = "root";
 static final String PASS = "135246135246";
  
 public static void main(String[] args) {
 Connection conn = null;
 Statement stmt = null;
 try{
   
    Class.forName("com.mysql.cj.jdbc.Driver");
   
    System.out.println("Connecting to database...");
    conn = DriverManager.getConnection(DB_URL,USER,PASS);

    System.out.println("Creating statement...");

    String Result1 = "SELECT * FROM author,AUTHOR_SUBMIT,paper where author.EmailAddr=AUTHOR_SUBMIT.AuthorId and AUTHOR_SUBMIT.PaperId=paper.id and author.emailaddr = ?";
    String Result2 = "SELECT * FROM REVIEW, REVIEWER_SUBMIT, ASSIGNED, REVIEWER, PAPER where REVIEW.Id=REVIEWER_SUBMIT.ReviewId and REVIEWER_SUBMIT.ReviewerId=Reviewer.EmailAddr and REVIEWER.EmailAddr=ASSIGNED.ReviewerId and Paper.ID=ASSIGNED.PaperId and recommendation = ?";
    String Result3 = "SELECT COUNT(*) as numPapers from Paper";
    String Result4 = "insert into author values('Amly@gmail.com', 'Amly', 'John')";
    String Result5 = "insert into paper values(12, 'Planet', 'Our environment', 'science')";
    String Result6 = "insert into AUTHOR_SUBMIT values('Amly@gmail.com', 12)";
    String Result7 = "delete from author where EmailAddr = 'ChrisE@hotmail.com'";
    
    PreparedStatement ppsf = conn.prepareStatement(Result1);
    PreparedStatement ppss = conn.prepareStatement(Result2);
    Statement statement = conn.createStatement();
    ResultSet set3 = statement.executeQuery(Result3);
    ppsf.setString(1, "ChrisE@hotmail.com");
    ppss.setString(1, "I learned a lot from this book, and even cited learnings from it to friends and colleagues.");
    ResultSet set1 = ppsf.executeQuery();
    ResultSet set2 = ppss.executeQuery();
    
   
    while(set1.next()){
  
       System.out.println();
       System.out.println(" Question1: Get a submitted paper’s details by the author’s Primary Key ");
       
       String AuthorEmailAddr = set1.getString("EmailAddr");
       System.out.println(" AuthorEmailAddr : " + AuthorEmailAddr);
       
       String AuthorFirstName = set1.getString("FirstName");
       System.out.println(" AuthorFirstName :" + AuthorFirstName);
       
       String AuthorLastName = set1.getString("LastName");
       System.out.println(" AuthorLastName : " + AuthorLastName);
       
       String PaperId = set1.getString("Id");
       System.out.println(" PaperId : " + PaperId);
       
       String PaperTitle = set1.getString("Title");
       System.out.println(" PaperTitle : " + PaperTitle);
       
       String PaperAbsrract = set1.getString("Absrract");
       System.out.println(" PaperAbsrract : " + PaperAbsrract);
       
       String PaperFileName = set1.getString("FileName");
       System.out.println(" PaperFileName : " + PaperFileName);
       System.out.println();
       
    }
    
    while(set2.next()) {
    	System.out.println(" Question2: Get all reviews for a paper by the paper’s Id ");
    	String recommendation = set2.getString("Recommendation");
    	System.out.println(" Reconmmendation : " + recommendation);
    	
    	int id = set2.getInt("Id");
    	System.out.println(" Id :" + id);
    	
    	int ms = set2.getInt("MeritScore");
    	System.out.println(" MeritScore =" + ms);
    	
    	int pid = set2.getInt("PaperId");
    	System.out.println(" PaperId :" + pid);
    	
    	int rscore = set2.getInt("ReadabilityScore");
    	System.out.println(" ReadabilityScore =" + rscore);
    	
    	String rid = set2.getString("ReviewerId");
    	System.out.println(" ReviewerId : " + rid);
    	
    	int relevancescore = set2.getInt("RelevanceScore");
    	System.out.println(" RelevanceScore = " + relevancescore);
    	
    	int originalityscore = set2.getInt("OriginalityScore");
    	System.out.println(" OriginalityScore =" + originalityscore );
    	
    }
    while(set3.next()) {
    	int number = set3.getInt("numPapers");
    	System.out.println();
    	System.out.println("Question3: Get a count of all papers submitted" );
    	System.out.println("The number of Paper: " + number);
    }
    
    int effect1 = statement.executeUpdate(Result4) + statement.executeUpdate(Result5) + statement.executeUpdate(Result6);
    System.out.println("The number of lines changed =  " + effect1);
    System.out.println("Question4:Create a new paper submission." );
    
 
    int effect2 = 0;
    
    try {
    	effect2 = statement.executeUpdate(Result7);
    	
    } catch(SQLException se) {
    	System.out.println(se);
    } finally {
    	System.out.println("Question 4 : The number of lines changed = " + effect2);
    }
    
    System.out.println("Question 5 messages:");
    //Clean-up environment
    set1.close();
    set1.close();
    set2.close();
    set2.close();
    conn.close();
 }catch(SQLException se){
    //Handle errors for JDBC
    se.printStackTrace();
 }catch(Exception e){
    //Handle errors for Class.forName
    e.printStackTrace();
 }finally{
    //finally block used to close resources
    try{
       if(stmt!=null)
          stmt.close();
    }catch(SQLException se2){
    }
    try{
       if(conn!=null)
          conn.close();
    }catch(SQLException se){
       se.printStackTrace();
    }//end finally try
 }

}
}