package demo;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	private final static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	private final static Logger logger = Logger.getLogger(CalculationController.class.getName());;
	
    @RequestMapping(value = "/batch/{cob_date}", method = RequestMethod.GET)
    public BatchCalculationResult batchCalculation(@PathVariable String cob_date)
    {
    	Date cob = new Date();
    	Calculation calc;
    	
    	try {
    		cob = format.parse(cob_date);
    	} catch (Exception e) {
    		logger.severe(String.format("failed to parse cob_date=%s", cob_date));
    		throw new CobFormatException();
    	}
    	BatchCalculationResult result = new BatchCalculationResult(); 
    	
    	long startBatchTime = System.nanoTime();
    	logger.info(String.format("start batch_calculation_id=\"%s\"", result.getId()));
    	
    	for (Counterparty ctrp : Counterparties.getCounterparties())
    	{
    		calc = new Calculation(cob, ctrp);
    		
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
    
    @RequestMapping(value = "/single/{cob_date}/{symbol}", method = RequestMethod.GET)
    public CalculationResult singleCalculation(@PathVariable String cob_date, @PathVariable String symbol)
    {
    	Date cob = new Date();
    	
    	try {
    		cob = format.parse(cob_date);
    	} catch (Exception e) {
    		logger.severe(String.format("failed to parse cob_date=%s", cob_date));
    		throw new CobFormatException();
    	}
    	
    	Counterparty ctrp = Counterparties.getCounterparty(symbol);
    	Calculation calc = new Calculation(cob, ctrp);
    	
    	long startCalcTime = System.nanoTime();
		logger.info(String.format("start batch_calculation_id=\"single\" calculation_id=\"%s\" ctrp=\"%s\"", calc.getId(), ctrp.getName()));
    	
		CalculationResult result = calc.runFull();
		
		long endCalcTime = System.nanoTime();
		logger.info(String.format("end batch_calculation_id=\"single\" calculation_id=\"%s\" ctrp=\"%s\" delta=%d", calc.getId(), ctrp.getName(), endCalcTime - startCalcTime));
	
		
    	return result;
    }
    
    @RequestMapping(value = "/single", method = RequestMethod.POST)
    public CalculationResult postSingleCalculation(@Valid String cob_date, @Valid String symbol)
    {
    	return singleCalculation(cob_date, symbol);
    }
}