package demo;

import java.util.Collection;
import java.util.UUID;

public class BatchCalculationResult
{
	private final UUID id = UUID.randomUUID();
	private final Collection<CalculationResult> results;
	
	public BatchCalculationResult(Collection<CalculationResult> results)
	{
		this.results = results;
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
