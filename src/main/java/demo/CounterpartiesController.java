package demo;

import java.util.Collection;
import java.util.logging.Logger;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/counterparties")
public class CounterpartiesController
{
	static Logger log = Logger.getLogger(CounterpartiesController.class.getName());
	
	/*
	 * Getters
	 */
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
    public Collection<Counterparty> getCounterparties()
    {
        return Counterparties.getCounterparties();
    }
	
	@RequestMapping(value = "/{symbol}", method = RequestMethod.GET)
    public Counterparty getCounterparty(@PathVariable String symbol)
    {
        return Counterparties.getCounterparty(symbol);
    }
	
	@RequestMapping(value = "/name/{symbol}", method = RequestMethod.GET)
    public String getCounterpartyName(@PathVariable String symbol)
    {
        return Counterparties.getCounterpartyName(symbol);
    }
	
	@RequestMapping(value = "/deals/{symbol}", method = RequestMethod.GET)
    public Integer getCounterpartyDeals(@PathVariable String symbol)
    {
        return Counterparties.getCounterpartyDeals(symbol);
    }
}