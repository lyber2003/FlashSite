package ExtEffect
{
    import flash.events.*;

    public class ExtEffectEvent extends Event
    {
        public static const REMOVE:String = "remvoe";

        public function ExtEffectEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
