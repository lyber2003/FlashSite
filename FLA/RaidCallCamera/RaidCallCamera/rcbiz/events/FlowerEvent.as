package rcbiz.events
{
    import flash.events.*;

    public class FlowerEvent extends Event
    {
        public var data:Object;
        public static const SEND_FLOWER_RESULT:String = "SendFlowerResult";
        public static const SINGER_FLOWER_CHANGE:String = "Singer_flower_change";
        public static const FLOWER_WIDGET_INITED:String = "Widget_inited";
        public static const FLOWER_NOTIFY:String = "FLOWER_NOTIFY";

        public function FlowerEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
