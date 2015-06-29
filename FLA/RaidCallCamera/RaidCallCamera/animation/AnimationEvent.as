package animation
{
    import flash.events.*;

    public class AnimationEvent extends Event
    {
        public static const COMPLETE:String = "animationComplete";
        public static const STOP:String = "animationStop";

        public function AnimationEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
