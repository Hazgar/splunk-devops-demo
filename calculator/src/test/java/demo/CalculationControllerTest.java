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
@ContextConfiguration(classes=CalculationController.class)
@WebMvcTest(CalculationController.class)
public class CalculationControllerTest {
	 
	    @Autowired
	    private MockMvc mockMvc;
	
	    @Test
	    public void batchCalculation() throws Exception {
	        mockMvc.perform(get("/calculation/batch/2015-01-29").accept(MediaType.APPLICATION_JSON))
	        		.andExpect(status().isOk());
	    }
	    
	    @Test
	    public void singleCalculation() throws Exception {
	        mockMvc.perform(get("/calculation/single/{cob_date}/{symbol}", "2015-01-29", "AC").accept(MediaType.APPLICATION_JSON))
	        	.andExpect(status().isOk())
	                .andDo(print());
	    }
	    
	    @Test
	    public void postSingleCalculation() throws Exception {
	        mockMvc.perform(post("/calculation/single?cob_date={cob_date}&symbol={symbol}", "2015-01-29", "AC").accept(MediaType.APPLICATION_JSON))
	        	.andExpect(status().isOk())
	                .andDo(print());
	    }
	    
}
