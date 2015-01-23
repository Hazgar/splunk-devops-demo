package demo;

import java.math.BigInteger;
import java.util.UUID;
import java.util.logging.Logger;

public class Calculation
{
	private static int MAGIC_FACTORIAL = 100;
	
	private static Logger logger = Logger.getLogger(Calculation.class.getName());;
	
    private final UUID id = UUID.randomUUID();
    private final Counterparty ctrp;

    public Calculation(Counterparty ctrp)
    {
        this.ctrp = ctrp;
    }

    public UUID getId()
    {
        return id;
    }

    public Counterparty getCounterparty()
    {
        return ctrp;
    }
    
    public CalculationResult runFull()
    {
    	long startTime = System.nanoTime();
    	logger.info(String.format("Start full calculation for %s with calculationId=\"%s\"", ctrp, id));
    	CalculationResult result = new CalculationResult(ctrp, sqrtDeals(),
    									   powDeals(),
    									   log10Deals(),
    									   cosDeals(),
    									   sinDeals(),
    									   tanDeals(),
    									   factorialDeals(),
    									   isPrimeDeals());
    	long endTime = System.nanoTime();
    	logger.info(String.format("Calculation for %s with calculationId=\"%s\" completed delta=%d", ctrp, id, endTime - startTime));
    	return result;
    }
    
    private Double sqrtDeals()
    {
    	return Math.sqrt(ctrp.getDeals());
    }
    
    private Double powDeals()
    {
    	return Math.pow(ctrp.getDeals(), 42.0);
    }
    
    private Double log10Deals()
    {
    	return Math.log10(ctrp.getDeals());
    }
    
    private Double cosDeals()
    {
    	return Math.cos(ctrp.getDeals());
    }
    
    private Double sinDeals()
    {
    	return Math.sin(ctrp.getDeals());
    }
    
    private Double tanDeals()
    {
    	return Math.tan(ctrp.getDeals());
    }

    private BigInteger factorialDeals()
    {
    	Integer n = ctrp.getDeals() / MAGIC_FACTORIAL;
    	BigInteger fact = BigInteger.valueOf(1);
        for (Integer i = 1; i <= n; i++) {
            fact = fact.multiply(BigInteger.valueOf(i));
        }
        return fact;
    }
    
    public boolean isPrimeDeals()
    {
    	Integer number = ctrp.getDeals();
        if (number == 2 || number == 3)
            return true;
        if (number % 2 == 0)
            return false;
        int sqrt = (int) Math.sqrt(number) + 1;
        for (int i = 3; i < sqrt; i += 2) {
            if (number % i == 0)
                return false;
        }
        return true;
    }
}