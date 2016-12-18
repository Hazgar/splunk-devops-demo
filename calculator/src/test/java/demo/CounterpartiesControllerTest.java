package demo;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes=CounterpartiesController.class)
@WebMvcTest(CounterpartiesController.class)
public class CounterpartiesControllerTest {
	 
	    @Autowired
	    private MockMvc mockMvc;
	
	    @Test
	    public void getCounterparties() throws Exception {
	        mockMvc.perform(get("/counterparties/").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk())
	                .andDo(print());
	    }
	    
	    @Test
	    public void getCounterparty() throws Exception {
	        mockMvc.perform(get("/counterparties/{symbol}", "AC").accept(MediaType.APPLICATION_JSON))
	        	    .andExpect(status().isOk())
	                .andDo(print());
	    }
	    
	    @Test
	    public void getCounterpartyName() throws Exception {
	        mockMvc.perform(get("/counterparties/name/{symbol}", "AC").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk())
	                .andDo(print());
	    }

	    @Test
	    public void getCounterpartyDeals() throws Exception {
	        mockMvc.perform(get("/counterparties/deals/{symbol}", "AC").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk())
	                .andDo(print());
	    }
}
