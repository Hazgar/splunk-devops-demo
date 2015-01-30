package demo;

import java.util.ArrayList;
import java.util.Collection;

public class Counterparties
{
	private static ArrayList<Counterparty> counterparties = new ArrayList<Counterparty>()
	{
		private static final long serialVersionUID = 1L;
		{
		add(new Counterparty("AC","Accor SA",492789));
		add(new Counterparty("ACA","Credit Agricole",2532864));
		add(new Counterparty("AI","Air Liquide SA",248460));
		add(new Counterparty("AIR","AIRBUS GROUP",1106223));
		add(new Counterparty("ALO","Alstom SA",1472292));
		add(new Counterparty("ALU","Alcatel-Lucent",5532697));
		add(new Counterparty("BN","Danone",674651));
		add(new Counterparty("BNP","BNP Paribas",1130524));
		add(new Counterparty("CA","Carrefour",519743));
		add(new Counterparty("CAP","Capgemini",218348));
		add(new Counterparty("CS","AXA SA",2173387));
		add(new Counterparty("DG","Vinci",143385));
		add(new Counterparty("EDF","Electricit de France S.A.",326327));
		add(new Counterparty("EI","Essilor International SA",234911));
		add(new Counterparty("EN","Bouygues",348793));
		add(new Counterparty("FP","Total SA",2286953));
		add(new Counterparty("FR","Valeo SA",83457));
		add(new Counterparty("GLE","Socit Gnrale",2040142));
		add(new Counterparty("GSZ","GDF Suez",2132956));
		add(new Counterparty("GTO","Gemalto",56344));
		add(new Counterparty("KER","Kering SA",46459));
		add(new Counterparty("LG","Lafarge SA",194647));
		add(new Counterparty("LR","Legrand SA",125350));
		add(new Counterparty("MC","LVMH Moet Hennessy Louis Vuitton SA",304732));
		add(new Counterparty("ML","Michelin",392563));
		add(new Counterparty("MT","ARCELORMITTAL REG",2449964));
		add(new Counterparty("OR","L'Oreal SA",212349));
		add(new Counterparty("ORA","Orange",2893161));
		add(new Counterparty("PUB","Publicis Groupe SA",140935));
		add(new Counterparty("RI","Pernod Ricard NV",175427));
		add(new Counterparty("RNO","Renault SA",307594));
		add(new Counterparty("SAF","Safran SA",282049));
		add(new Counterparty("SAN","Sanofi",877212));
		add(new Counterparty("SGO","Compagnie de Saint-Gobain",1167585));
		add(new Counterparty("SOLB","SOLVAY",57926));
		add(new Counterparty("SU","Schneider Electric SE",493153));
		add(new Counterparty("TEC","Technip",322276));
		add(new Counterparty("UL","Unibail-Rodamco SE",110491));
		add(new Counterparty("VIE","Veolia Environnement SA",479975));
		add(new Counterparty("VIV","Vivendi SA",1100548));
		add(new Counterparty("SPLK","Splunk Inc",4200));
		}
	};

	public static Collection<Counterparty> getCounterparties()
	{
		return counterparties;
	}
	
	public static Counterparty getCounterparty(String symbol)
	{
		for (Counterparty ctrp : counterparties)
		{
			if (symbol.equals(ctrp.getSymbol()))
				return ctrp;
		}
		return null;
	}
	
	public static String getCounterpartyName(String symbol)
	{
		Counterparty ctrp = getCounterparty(symbol);
		if (ctrp != null)
			return ctrp.getName();
		return null;
	}
	
	public static Integer getCounterpartyDeals(String symbol)
	{
		Counterparty ctrp = getCounterparty(symbol);
		if (ctrp != null)
			return ctrp.getDeals();
		return 0;
	}
}
