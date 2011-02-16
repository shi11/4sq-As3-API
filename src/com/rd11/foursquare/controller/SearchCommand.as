////////////////////////////////////////////////////////////
// Project: foursquair 
// Author: Seth Hillinger
// Created: Mar 7, 2010 
////////////////////////////////////////////////////////////

package com.rd11.foursquare.controller
{
	import com.rd11.foursquare.models.FoursquareModel;
	import com.rd11.foursquare.models.vo.CityVO;
	import com.rd11.foursquare.services.IFoursquareService;
	import com.rd11.foursquare.signals.FoursquareSignalBus;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	
	public class SearchCommand extends Command
	{
		[Inject]
		public var service : IFoursquareService;
		
		[Inject]
		public var bus : FoursquareSignalBus;
		
		[Inject]
		public var model : FoursquareModel;
		
		[Inject]
		public var cityVO : CityVO;
		
		[Inject]
		public var keywords : String;
		
		public function SearchCommand()
		{
			super();
		}
		
		override public function execute():void{
			bus.nearbyResult.add( handleQuery );
			query(cityVO, keywords );
		}
		
		/**
		 * queries foursquare and returns venue's nearby 
		 * @param keywords (optional) search
		 * 
		 */		
		private function query(cityVO:CityVO, keywords:String=null):void{
			service.getVenues(	cityVO.geolat, cityVO.geolong, 25, 10, keywords );
		}
		
		/**
		 * handles query results 
		 * @param results
		 * 
		 */		
		private function handleQuery(results : ArrayCollection):void{
			bus.nearbyResult.dispatch( results );
		}
	}	
}