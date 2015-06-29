package components.singer.video.core
{
    import flash.events.*;

    public class RCLiveVideoEvent extends Event
    {
        public var status:String;
        public var info:Object;
        public static const StatusChange:String = "StatusChange";
        public static const muteChange:String = "MuteChange";
        public static const videoSizeChange:String = "VideoSizeChange";
        public static const onMetaData:String = "OnMetaData";
        public static const onStreamData:String = "onStreamData";
        public static const onRoomStatusUpdate:String = "OnRoomStatusUpdate";
        public static const STOP_VIDEO:String = "STOP_VIDEO";

        public function RCLiveVideoEvent(param1:String, param2:String = "", param3:Object = null, param4:Boolean = false, param5:Boolean = false)
        {
            this.status = param2;
            this.info = param3;
            super(param1, param4, param5);
            return;
        }// end function

    }
}
