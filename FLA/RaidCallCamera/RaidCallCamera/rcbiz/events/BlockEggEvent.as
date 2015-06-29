package rcbiz.events
{
    import flash.events.*;

    public class BlockEggEvent extends Event
    {
        public var data:Object;
        public static const BLOCK_EGG:String = "GET_BLOCK_EGG_RESULT";
        public static const REFRESH_BLOCK_EGG:String = "REFRESH_BLOCK_EGG";
        public static const UPDATE_CUR_TIMECOUNT:String = "UPDATE_CUR_TIMECOUNT";
        public static const BLOCK_EGG_RESULT:String = "BLOCK_EGG_RESULT";
        public static const BLOCK_EGG_ERROR:String = "BLOCK_EGG_ERROR";
        public static const REFRESH_EGG_RESULT:String = "REFRESH_EGG_RESULT";
        public static const REFRESH_EGG_ERROR:String = "REFRESH_EGG_ERROR";
        public static const EGG_NOTIFY:String = "EGG_NOTIFY";
        public static const INIT_EGG:String = "INIT_EGG";
        public static const CHECK_BIND_FB:String = "CHECK_BIND_FB";

        public function BlockEggEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, true, true);
            return;
        }// end function

    }
}
