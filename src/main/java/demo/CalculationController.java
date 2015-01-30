package demo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.validation.Valid;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/calculation")
public class CalculationController
{    
    @RequestMapping(value = "/batch", method = RequestMethod.GET)
    public Map<UUID,Collection<CalculationResult>> batchCalculation()
    {
    	Map<UUID,Collection<CalculationResult>> batch = new HashMap<UUID,Collection<CalculationResult>>();
    	
    	ArrayList<CalculationResult> results = new ArrayList<CalculationResult>();
    	for (Counterparty ctrp : Counterparties.getCounterparties())
    		results.add(new Calculation(ctrp).runFull());
    	batch.put(UUID.randomUUID(), results);
    	return batch;
    }
    
    @RequestMapping(value = "/single/{symbol}", method = RequestMethod.GET)
    public CalculationResult singleCalculation(@PathVariable String symbol)
    {
    	Counterparty ctrp = Counterparties.getCounterparty(symbol);
    	return new Calculation(ctrp).runFull();
    }
    
    @RequestMapping(value = "/single", method = RequestMethod.POST)
    public CalculationResult postSingleCalculation(@Valid String symbol)
    {
    	Counterparty ctrp = Counterparties.getCounterparty(symbol);
    	return new Calculation(ctrp).runFull();
    }
}