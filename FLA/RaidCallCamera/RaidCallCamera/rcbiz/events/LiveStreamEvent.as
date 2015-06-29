package rcbiz.events
{
    import flash.events.*;
    import rcbiz.model.show.video.*;

    public class LiveStreamEvent extends Event
    {
        public var data:StreamObject;
        public static const STREAM_SHAKE:String = "STREAM_SHAKE";
        public static const STREAM_BEGIN:String = "STREAM_BEGIN";
        public static const STREAM_END:String = "STREAM_END";
        public static const STREAM_CREATE:String = "STREAM_CREATE";
        public static const STREAM_PLAY:String = "STREAM_PLAY";
        public static const STREAM_PLAY_EX:String = "STREAM_PLAY_EX";
        public static const LIVE_CHANGE:String = "LIVE_CHANGE";
        public static const ENABLE_CHANGE:String = "ENABLE_CHANGE";
        public static const LIVE_PLAYING_CHANGE:String = "LIVE_PLAYING_CHANGE";
        public static const LIVE_STATUS_CHANGE:String = "LIVE_STATUS_CHANGE";

        public function LiveStreamEvent(param1:String, param2:StreamObject = null, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

    }
}
