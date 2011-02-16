package com.rd11.foursquare.models.vo
{
	import mx.collections.ArrayCollection;

	public class UserVO
	{

		public var id : int;
		public var firstname : String;
		public var lastname : String;
		public var name_with_initial : String;
		public var email : String;
		public var twitter : String;
		public var facebook : String;
		public var photo : String;
		public var gender : String;
		public var badges : Array = new Array();
		public var city : CityVO;
		
		private static const USERPIX:String = "http://playfoursquare.s3.amazonaws.com/userpix_thumbs";

		public function UserVO(remote : Object= null )
		{
			if( remote ){
				this.id = remote.id;
				this.firstname = remote.firstname;
				this.lastname = remote.lastname;
				this.name_with_initial = this.firstname + ' ' + ((remote.lastname && remote.lastname != null) ? this.lastname.substr(0, 1) : '');
				this.gender = remote.gender;
				this.photo = ((remote.photo) ? remote.photo : (this.gender == "male") ? USERPIX+'/blank_boy.png' : USERPIX+'/blank_girl.png');
	
				if (remote.email) this.email = remote.email;
				if (remote.twitter) this.twitter = remote.twitter;
				if (remote.facebook) this.facebook = remote.facebook;
	
				//TODO Seth: don't like that this is in the VO but oh well for now.
				if (remote.badges)
				{
					var b : ArrayCollection;
					if (remote.badges.badge)
					{
						b = remote.badges.badge as ArrayCollection;
					}
					else
					{
						b = new ArrayCollection(remote.badges);
					}
					
					b.source.forEach(function(el : Object, index : int, arr : Array) : void
					{
						badges.push(new BadgeVO(el));
					});
				}
				this.city = ((remote.city) ? new CityVO(remote.city) : null);
			}
		}
	}
}