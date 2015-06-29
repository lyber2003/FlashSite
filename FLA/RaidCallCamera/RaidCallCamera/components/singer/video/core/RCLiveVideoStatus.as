package components.singer.video.core
{

    public class RCLiveVideoStatus extends Object
    {
        public static const READY_TO_PLAY:String = "ReadyToPlay";
        public static const CONNECTING:String = "CONNECTING";
        public static const CONNECTION_SUCCESS:String = "CONNECTION_SUCCESS";
        public static const CONNECTING_ERROR:String = "CONNECTING_ERROR";
        public static const BUFFER_FULL:String = "BUFFER_FULL";
        public static const BUFFER_EMPTY:String = "BUFFER_EMPTY";
        public static const STOPPED:String = "STOPPED";
        public static const PLAY_START:String = "PLAY_START";
        public static const PLAY_ERROR:String = "PLAY_ERROR";
        public static const PLAYING:String = "PLAYING";
        public static const VIDEO_SIZE_CHANGE:String = "VIDEO_SIZE_CHANGE";
        public static const PLAY_STOP:String = "PLAY_STOP";
        public static const PUBLISH_START:String = "PUBLISH_START";
        public static const PUBLISHING:String = "PUBLISHING";
        public static const PUBLISH_STOP:String = "PUBLISH_STOP";
        public static const PUBLISH_ERROR:String = "PUBLISH_ERROR";

        public function RCLiveVideoStatus()
        {
            return;
        }// end function

    }
}
