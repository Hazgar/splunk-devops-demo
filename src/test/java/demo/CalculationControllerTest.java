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
public class CalculationControllerTest {
	 
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
	        public CalculationController calculationController() {
	            return new CalculationController();
	        }
	 
	    }
	    
	    @Test
	    public void batchCalculation() throws Exception {
	        mockMvc.perform(get("/calculation/batch").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk());
	    }
	    
	    @Test
	    public void singleCalculation() throws Exception {
	        mockMvc.perform(get("/calculation/single/{symbol}", "AC").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk())
	                .andDo(print());
	    }
	    
	    @Test
	    public void postSingleCalculation() throws Exception {
	        mockMvc.perform(post("/calculation/single?symbol={symbol}", "AC").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk())
	                .andDo(print());
	    }
	    
}
