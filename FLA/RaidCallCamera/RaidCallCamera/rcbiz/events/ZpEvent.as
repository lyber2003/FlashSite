package rcbiz.events
{
    import flash.events.*;

    public class ZpEvent extends Event
    {
        public var data:Object;
        public static const GET_ZP_INFO:String = "GET_ZP_INFO";
        public static const G_ZP_RESULT:String = "GET_ZP_RESULT";
        public static const F_ZP_RESULT:String = "FET_ZP_RESULT";
        public static const CLOSE:String = "ZP_CLOSE";
        public static const SHOW_ZP_RESULT:String = "SHOW_ZP_RESULT";
        public static const SHOW_SEND_SINGER:String = "SHOW_SEND_SINGER";
        public static const G_SINGER_RESULT:String = "G_SINGER_RESULT";
        public static const FORWARD_CHANNEL:String = "FORWARD_CHANNEL";
        public static const REC_GIFT_COMP:String = "REC_GIFT_COMP";

        public function ZpEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, true, true);
            return;
        }// end function

        override public function clone() : Event
        {
            return new ZpEvent(type, this.data);
        }// end function

    }
}
