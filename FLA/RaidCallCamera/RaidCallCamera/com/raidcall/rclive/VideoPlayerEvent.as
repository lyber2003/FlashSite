package com.raidcall.rclive
{
    import flash.events.*;

    public class VideoPlayerEvent extends Event
    {
        public var data:Object;
        public static const STREAM_CREATED:String = "STREAM_CREATED";
        public static const STREAM_CLOSED:String = "STREAM_CLOSED";
        public static const STREAM_RESET:String = "STREAM_RESET";

        public function VideoPlayerEvent(param1:String, param2:Object = null)
        {
            super(param1);
            this.data = param2;
            return;
        }// end function

    }
}
