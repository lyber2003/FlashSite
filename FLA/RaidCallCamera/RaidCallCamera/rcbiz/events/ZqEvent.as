package rcbiz.events
{
    import flash.events.*;

    public class ZqEvent extends Event
    {
        public var data:Object;
        public static const GET_CHIP_INFO:String = "GET_CHIP_INFO";
        public static const GET_MERGE_CHIP:String = "GET_MERGE_CHIP";
        public static const UPDATE_PACKET_DATA:String = "UPDATE_PACKET_DATA";

        public function ZqEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1, true, true);
            return;
        }// end function

        override public function clone() : Event
        {
            return new ZqEvent(type, this.data);
        }// end function

    }
}
