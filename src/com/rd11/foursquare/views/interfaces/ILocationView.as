package  com.rd11.foursquare.views.interfaces
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.ISignal;

	public interface ILocationView
	{
		function get nearbyRequest():ISignal;
		function setNearbyResults( results: ArrayCollection ):void;
	}
}