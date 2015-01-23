package demo;

import java.math.BigInteger;
import java.util.UUID;

public class CalculationResult
{

    private final UUID id = UUID.randomUUID();
    private final Counterparty ctrp;
    
    private Double sqrt = 0.0;
    private Double pow42 = 0.0;
    private Double log10 = 0.0;
    private Double cos = 0.0;
    private Double sin = 0.0;
    private Double tan = 0.0;
    private BigInteger factorial = BigInteger.valueOf(0);
    private boolean isPrime = false;
    
    
    public CalculationResult(Counterparty ctrp, Double sqrt,
    											Double pow42,
    											Double log10,
    											Double cos,
    											Double sin,
    											Double tan,
    											BigInteger factorial,
    											boolean isPrime)
    {
        this.ctrp = ctrp;
        this.sqrt = sqrt;
        this.pow42 = pow42;
        this.log10 = log10;
        this.cos = cos;
        this.sin = sin;
        this.tan = tan;
        this.factorial = factorial;
        this.isPrime = isPrime;
    }

    public UUID getId()
    {
        return id;
    }

    public Counterparty getCounterparty()
    {
        return ctrp;
    }
    
    public Double getSqrt()
    {
    	return sqrt;
    }
    
    public Double getPow()
    {
    	return pow42;
    }
    
    public Double getLog10()
    {
    	return log10;
    }
    
    public Double getCos()
    {
    	return cos;
    }
    
    public Double getSin()
    {
    	return sin;
    }
    
    public Double getTan()
    {
    	return tan;
    }
    
    public BigInteger getFactorial()
    {
    	return factorial;
    }
    
    public boolean isPrime()
    {
    	return isPrime;
    }
}