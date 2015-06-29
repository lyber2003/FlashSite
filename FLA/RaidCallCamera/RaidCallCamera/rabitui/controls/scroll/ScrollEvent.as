package rabitui.controls.scroll
{
    import flash.events.*;

    public class ScrollEvent extends Event
    {
        public static const SCROLL:String = "scroll";

        public function ScrollEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
