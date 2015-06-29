package rcbiz.events
{
    import flash.events.*;

    public class ShowCardEvent extends Event
    {
        private var _data:Object;
        public static const BUY_SHOWCARD:String = "BUY_SHOWCARD";
        public static const GET_GIFT:String = "GET_GIFT";
        public static const ACTION_CHANGE:String = "ACTION_CHANGE";
        public static const RECHARGE:String = "RECHARGE";

        public function ShowCardEvent(param1:String, param2:Object)
        {
            super(param1, bubbles, cancelable);
            this.data = param2;
            return;
        }// end function

        public function get data() : Object
        {
            return this._data;
        }// end function

        public function set data(param1:Object) : void
        {
            this._data = param1;
            return;
        }// end function

    }
}
