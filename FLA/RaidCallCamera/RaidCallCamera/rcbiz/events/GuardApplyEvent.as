package rcbiz.events
{
    import flash.events.*;

    public class GuardApplyEvent extends Event
    {
        public var data:Object;
        public static const GET_GUARD_APPLY_INFO:String = "GET_GUARD_APPLY_INFO";
        public static const R_GET_GUARD_APPLY_INFO:String = "R_GET_GUARD_APPLY_INFO";
        public static const GET_SINGER_GUARD:String = "GET_SINGER_GUARD";
        public static const R_GET_SINGER_GUARD:String = "R_GET_SINGER_GUARD";
        public static const GET_GUARD_APPLY_LIST:String = "GET_GUARD_APPLY_LIST";
        public static const APPLY_SINGER_GUARD:String = "APPLY_SINGER_GUARD";
        public static const RAPPLY_SINGER_GUARD:String = "RAPPLY_SINGER_GUARD";
        public static const RACCEPT_GUARD_APPLY:String = "RACCEPT_GUARD_APPLY";
        public static const BACCEPT_GUARD_APPLY:String = "BAcceptGuardApply";
        public static const BAPPLY_GUARD_FOR:String = "BAPPLY_GUARD_FOR";
        public static const SHOW_CONTINUE:String = "SHOW_CONTINUE";
        public static const SHOW:String = "SHOW";
        public static const SHOW_OPEN:String = "SHOW_OPEN";
        public static const CHECK_USER_IN_CHANNEL:String = "CHECK_USER_IN_CHANNEL";
        public static const SHOW_MORE_GZ:String = "SHOW_MORE_GZ";
        public static const PLAYING_ALERT:String = "PLAYING_ALERT";
        public static const PLAYING_ALERT_START:String = "PLAYING_ALERT_START";
        public static const GUARD_ONLINE:String = "GUARD_ONLINE";
        public static const ENTER_CHANNEL:String = "ENTER_CHANNEL";

        public function GuardApplyEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, true, true);
            return;
        }// end function

    }
}
