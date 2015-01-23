package demo;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/calculation")
public class CalculationController
{    
    @RequestMapping("/batch")
    public Collection<CalculationResult> batchCalculation()
    {
    	ArrayList<CalculationResult> results = new ArrayList<CalculationResult>();
    	for (Counterparty ctrp : Counterparties.getCounterparties())
    	{
    		results.add(new Calculation(ctrp).runFull());
    	}
    	return results;
    }
    
    @RequestMapping("/single/{symbol}")
    public CalculationResult singleCalculation(@PathVariable String symbol)
    {
    	Counterparty ctrp = Counterparties.getCounterparty(symbol);
    	return new Calculation(ctrp).runFull();
    }
}