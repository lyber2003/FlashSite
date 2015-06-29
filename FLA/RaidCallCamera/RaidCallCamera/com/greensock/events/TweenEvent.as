package com.greensock.events
{
    import flash.events.*;

    public class TweenEvent extends Event
    {
        public static const COMPLETE:String = "complete";
        public static const START:String = "start";
        public static const UPDATE:String = "change";
        public static const REVERSE_COMPLETE:String = "reverseComplete";
        public static const VERSION:Number = 12;
        public static const REPEAT:String = "repeat";

        public function TweenEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new TweenEvent(this.type, this.bubbles, this.cancelable);
        }// end function

    }
}
