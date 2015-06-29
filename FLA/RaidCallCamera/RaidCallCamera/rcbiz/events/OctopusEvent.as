package rcbiz.events
{
    import flash.events.*;

    public class OctopusEvent extends Event
    {
        public var data:Object;
        public static const B_START_OCTOPUS_GAME:String = "b_start_ocotpus_game";
        public static const GET_ACTIVITY_HOURLY_PACKET:String = "get_activity_hourly_packet";
        public static const JOIN_OCTOPUS_GAME:String = "join_octopus_game";
        public static const FORCE_GAME_START:String = "force_game_start";
        public static const SEND_GAME_RESULT:String = "send_game_result";
        public static const GAME_INIT_DATA:String = "game_init_data";
        public static const GET_FB_TOKEN:String = "get_fb_token";
        public static const SHARE_TO_FACEBOOK:String = "share_to_facebook";
        public static const ENERGY_CHANGE:String = "energy_change";

        public function OctopusEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, false, true);
            return;
        }// end function

    }
}
