package demo;

import java.util.ArrayList;
import java.util.Collection;
import java.util.UUID;

public class BatchCalculationResult
{
	private final UUID id = UUID.randomUUID();
	private Collection<CalculationResult> results = new ArrayList<CalculationResult>();
	
	public BatchCalculationResult()
	{
	}
	
	public void addResult(CalculationResult result)
	{
		results.add(result);
	}
	
	public UUID getId()
	{
		return id;
	}
	
	public Collection<CalculationResult> getResults()
	{
		return results;
	}
}
