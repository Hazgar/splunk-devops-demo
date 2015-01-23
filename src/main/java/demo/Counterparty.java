package demo;

public class Counterparty
{

    private final String symbol;
    private final String name;
    private final Integer deals;

    public Counterparty(String symbol, String name, Integer deals)
    {
        this.symbol = symbol;
        this.name = name;
        this.deals = deals;
    }

    public String getSymbol()
    {
        return symbol;
    }

    public String getName()
    {
        return name;
    }
    
    public Integer getDeals()
    {
    	return deals;
    }
    
    public String toString()
    {
    	return String.format("symbol=%s name=\"%s\"", symbol, name);
    }
}