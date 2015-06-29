package rcbiz.events
{
    import flash.events.*;

    public class KnockBoxEvent extends Event
    {
        public var data:Object;
        public static const EXPLODE_BOX:String = "EXPLODE_BOX";
        public static const BOX_INTI_COMPLETE:String = "BOX_INTI_COMPLETE";
        public static const TO_MASK:String = "TO_MASK";
        public static const CLEAR_MASK:String = "CLEAR_MASK";
        public static const CHECK_EXPLODE_BOX:String = "CHECK_EXPLODE_BOX";
        public static const OPEN_GIFT_BOX:String = "OPEN_GIFT_BOX";
        public static const OPEN_GIFT_BOX_RESULT:String = "OPEN_GIFT_BOX_RESULT";
        public static const GIFT_BOX_UP_TO_TIME:String = "GIFT_BOX_UP_TO_TIME";
        public static const GET_GIFT_COMPLETE:String = "GET_GIFT_COMPLETE";
        public static const SET_FLAG_HAS_KNOCK:String = "SET_FLAG_HAS_KNOCK";

        public function KnockBoxEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, true, true);
            return;
        }// end function

    }
}
