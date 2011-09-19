package  com.rd11.foursquare.views.interfaces
{
	import mx.collections.ArrayCollection;
	
	import org.osflash.signals.ISignal;

	public interface IVenueView
	{
		function get nearbyRequest():ISignal;
		function get venueSelected():ISignal;
		function setNearbyResults( results: ArrayCollection ):void;
	}
}