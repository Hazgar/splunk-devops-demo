package demo;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;


import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration
@WebAppConfiguration
public class CounterpartiesControllerTest {
	 
		private MockMvc mockMvc;
	
	    @Autowired
	    private WebApplicationContext ctx;
	    
	    @Before
	    public void setUp() {
	        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	    }
	 
	 
	    @Configuration
	    @EnableWebMvc
	    public static class TestConfiguration {
	 
	        @Bean
	        public CounterpartiesController counterpartiesController() {
	            return new CounterpartiesController();
	        }
	 
	    }
	    
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
