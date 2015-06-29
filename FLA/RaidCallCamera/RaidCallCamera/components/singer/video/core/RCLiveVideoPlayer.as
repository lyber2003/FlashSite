package components.singer.video.core
{
    import com.debug.*;
    import com.raidcall.rclive.*;
    import flash.media.*;

    public class RCLiveVideoPlayer extends Video
    {
        private var token:String;
        private var connstr:String;
        private var strStream:String;
        private var _status:String;
        public var player:VideoPlayer;

        public function RCLiveVideoPlayer(param1:int = 320, param2:int = 240)
        {
            this.player = new VideoPlayer();
            super(param1, param2);
            this.init();
            return;
        }// end function

        private function init() : void
        {
            this.player.addEventListener(VideoPlayerEvent.STREAM_CREATED, this.onStreamCreate);
            this.player.addEventListener(VideoPlayerEvent.STREAM_CLOSED, this.onStreamReset);
            return;
        }// end function

        public function play(param1:String, param2:String, param3:String, param4:Boolean) : void
        {
            clear();
            DebugX.print("RCLiveVideo: Play:" + param1 + " | token=" + param2);
            this.status = RCLiveVideoStatus.PLAY_START;
            this.player.play(param1, param2, param3, param4);
            return;
        }// end function

        public function stop() : void
        {
            clear();
            this.player.stop();
            return;
        }// end function

        private function onStreamCreate(event:VideoPlayerEvent) : void
        {
            DebugX.print("onStreamCreate");
            attachNetStream(this.player.stream);
            this.status = RCLiveVideoStatus.PLAYING;
            return;
        }// end function

        private function onStreamReset(event:VideoPlayerEvent) : void
        {
            this.status = RCLiveVideoStatus.PLAY_STOP;
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            if (this._status != param1)
            {
                this._status = param1;
                dispatchEvent(new RCLiveVideoEvent(RCLiveVideoEvent.StatusChange, param1));
            }
            return;
        }// end function

    }
}
