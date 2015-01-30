package demo;


import java.util.logging.Logger;

import javax.validation.Valid;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/calculation")
public class CalculationController
{
	private final static Logger logger = Logger.getLogger(CalculationController.class.getName());;
	
    @RequestMapping(value = "/batch", method = RequestMethod.GET)
    public BatchCalculationResult batchCalculation()
    {
    	Calculation calc;
    	BatchCalculationResult result = new BatchCalculationResult(); 
    	
    	long startBatchTime = System.nanoTime();
    	logger.info(String.format("start batch_calculation_id=\"%s\"", result.getId()));
    	
    	for (Counterparty ctrp : Counterparties.getCounterparties())
    	{
    		calc = new Calculation(ctrp);
    		
    		long startCalcTime = System.nanoTime();
    		logger.info(String.format("start batch_calculation_id=\"%s\" calculation_id=\"%s\" ctrp=\"%s\"", result.getId(), calc.getId(), ctrp.getName()));
    		
    		result.addResult(calc.runFull());
    		
    		long endCalcTime = System.nanoTime();
    		logger.info(String.format("end batch_calculation_id=\"%s\" calculation_id=\"%s\" ctrp=\"%s\" delta=%d", result.getId(), calc.getId(), ctrp.getName(), endCalcTime - startCalcTime));
    	}
    	
    	long endBatchTime = System.nanoTime();
    	logger.info(String.format("end batch_calculation_id=\"%s\" delta=%d", result.getId(), endBatchTime - startBatchTime ));
    	
    	return result;
    }
    
    @RequestMapping(value = "/single/{symbol}", method = RequestMethod.GET)
    public CalculationResult singleCalculation(@PathVariable String symbol)
    {
    	Counterparty ctrp = Counterparties.getCounterparty(symbol);
    	Calculation calc = new Calculation(ctrp);
    	
    	long startCalcTime = System.nanoTime();
		logger.info(String.format("start batch_calculation_id=\"single\" calculation_id=\"%s\" ctrp=\"%s\"", calc.getId(), ctrp.getName()));
    	
		CalculationResult result = calc.runFull();
		
		long endCalcTime = System.nanoTime();
		logger.info(String.format("end batch_calculation_id=\"single\" calculation_id=\"%s\" ctrp=\"%s\" delta=%d", calc.getId(), ctrp.getName(), endCalcTime - startCalcTime));
	
		
    	return result;
    }
    
    @RequestMapping(value = "/single", method = RequestMethod.POST)
    public CalculationResult postSingleCalculation(@Valid String symbol)
    {
    	return singleCalculation(symbol);
    }
}