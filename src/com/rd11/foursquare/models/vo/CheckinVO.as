package com.rd11.foursquare.models.vo
{
	import com.rd11.foursquare.util.TimeAgoInWords;
	

	public class CheckinVO
	{
		public var id : int = 0;
		public var user : UserVO;
		public var venue : VenueVO;
		public var display : String;
		public var shout : String;
		public var created : Date;
		public var created_in_words : String;
		public var is_shout_only : Boolean = false;

		public function CheckinVO(remote : Object)
		{
			this.id = remote.id;
			if (remote.user)
				this.user = new UserVO(remote.user);
			this.venue = (remote.venue && remote.venue != null) ? new VenueVO(remote.venue) : null;
			this.display = remote.display;
			this.shout = remote.shout || '';
			this.is_shout_only = this.venue == null;

			var then : Date = new Date();
			var isDate : Boolean = remote.created is Date;
			if (isDate == false)
			{
				var cleaned : String = String(remote.created).replace(/(\w{3}+)(.{1}+) (\d{2}+) (\w{3}+) (\d{2}+) (\d{2}:\d{2}:\d{2}+) (\+|\-+)(\d{4}+)/g, "$1 $4 $3 $6 GMT$7$8 20$5");
				then.setTime(Date.parse(cleaned));
			}
			then.setTime(then.getTime() - (then.getTimezoneOffset()));
			this.created = then;
			this.created_in_words = TimeAgoInWords.format(then) + ' ago';
		}
	}
}