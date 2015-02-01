package demo;

import java.math.BigInteger;
import java.util.Date;
import java.util.UUID;

public class Calculation
{
	private static int MAGIC_FACTORIAL = 50;
	
    private final UUID id = UUID.randomUUID();
    private final Counterparty ctrp;
    private final double cob_date_modifier;

    public Calculation(Date cob_date, Counterparty ctrp)
    {
        this.ctrp = ctrp;
        this.cob_date_modifier = Math.abs(Math.cos(cob_date.getTime() / 100000));
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
    	CalculationResult result = new CalculationResult(ctrp, sqrtDeals(),
    									   powDeals(),
    									   log10Deals(),
    									   cosDeals(),
    									   sinDeals(),
    									   tanDeals(),
    									   factorialDeals(),
    									   isPrimeDeals());
    	return result;
    }
    
    private Double sqrtDeals()
    {
    	return Math.sqrt(ctrp.getDeals() * cob_date_modifier);
    }
    
    private Double powDeals()
    {
    	return Math.pow(ctrp.getDeals() * cob_date_modifier, 42.0);
    }
    
    private Double log10Deals()
    {
    	return Math.log10(ctrp.getDeals() * cob_date_modifier);
    }
    
    private Double cosDeals()
    {
    	return Math.cos(ctrp.getDeals() * cob_date_modifier);
    }
    
    private Double sinDeals()
    {
    	return Math.sin(ctrp.getDeals() * cob_date_modifier);
    }
    
    private Double tanDeals()
    {
    	return Math.tan(ctrp.getDeals() * cob_date_modifier);
    }

    private BigInteger factorialDeals()
    {
    	long n = Math.round((ctrp.getDeals() * cob_date_modifier) / MAGIC_FACTORIAL);
    	BigInteger fact = BigInteger.valueOf(1);
        for (long i = 1; i <= n; i++) {
            fact = fact.multiply(BigInteger.valueOf(i));
        }
        return fact;
    }
    
    public boolean isPrimeDeals()
    {
    	long number = Math.round(ctrp.getDeals() * cob_date_modifier);
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