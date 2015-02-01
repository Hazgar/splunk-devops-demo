package demo;

import static com.eclipsesource.restfuse.Assert.assertOk;
import org.junit.Rule;
import org.junit.runner.RunWith;
import com.eclipsesource.restfuse.Destination;
import com.eclipsesource.restfuse.HttpJUnitRunner;
import com.eclipsesource.restfuse.Method;
import com.eclipsesource.restfuse.PollState;
import com.eclipsesource.restfuse.Response;
import com.eclipsesource.restfuse.annotation.Context;
import com.eclipsesource.restfuse.annotation.Header;
import com.eclipsesource.restfuse.annotation.HttpTest;
import com.eclipsesource.restfuse.annotation.Poll;


@RunWith( HttpJUnitRunner.class )
public class DemoLoadTest
{ 
	@Rule
	public Destination restfuse = new Destination( this, "http://localhost:8080" );
	
	@Context
	private PollState pollState;
	
	@Context
	private Response response;
	
	@HttpTest( method = Method.GET, path = "/devops-demo/calculation/single/2015-01-01/AC" )
	@Poll( times = 10, interval = 1 )
	public void checkRestfuseOnlineStatus()
	{
		System.out.println( "Attemt " + pollState.getTimes() );
		System.out.println( pollState.getTimes() + ". Responsecode = " + pollState.getResponse( pollState.getTimes() ).getStatus() );
	}
	
	@HttpTest( method = Method.GET, path = "/devops-demo/counterparties/",
	headers = { @Header( name = "Accepted-Language", value = "en-en" ) } )
	public void checkRestfuseOnlineStatusWithHeader()
	{
		assertOk( response );
	}
}