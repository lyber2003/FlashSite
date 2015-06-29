package com.raidcall.rclive
{
    import com.carlcalderon.arthropod.*;
    import components.singer.video.core.*;
    import flash.events.*;
    import flash.net.*;

    public class VideoPlayer extends EventDispatcher
    {
        private var player:Player;
        private var _bP2P:Boolean = false;
        private var _stream:NetStream;

        public function VideoPlayer()
        {
            Player.logger = this.logTrace;
            return;
        }// end function

        public function play(param1:String, param2:String, param3:String, param4:Boolean) : void
        {
            Debug.log("play:" + param4 + "token:" + param2 + "url:" + param1 + " name:" + param3);
            this._bP2P = param4;
            this.stop();
            if (this._bP2P)
            {
                this.player = new Player("fusion");
            }
            else
            {
                this.player = new Player("xrtmp");
            }
            this.player.streamCreateListener = this.onStreamCreate;
            this.player.streamCloseListener = this.onStreamClose;
            this.player.play(param1, param2, param3);
            return;
        }// end function

        public function logTrace(... args) : void
        {
            args = args.join(",") + "\n";
            Debug.log(args);
            return;
        }// end function

        public function onStreamCreate(param1:NetStream) : void
        {
            Debug.log("onStreamCreate");
            this._stream = param1;
            this._stream.bufferTime = 1;
            this._stream.bufferTimeMax = 1;
            this._stream.client = this;
            dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.STREAM_CREATED));
            return;
        }// end function

        public function onStreamData(param1:Object) : void
        {
            var _loc_2:* = new Object();
            _loc_2.info = param1;
            _loc_2.bufferTime = this.stream.bufferTime;
            _loc_2.bufferLength = this.stream.bufferLength;
            dispatchEvent(new RCLiveVideoEvent(RCLiveVideoEvent.onStreamData, "", _loc_2));
            return;
        }// end function

        public function onStreamClose() : void
        {
            Debug.log("onStreamClose");
            this.stop();
            dispatchEvent(new VideoPlayerEvent(VideoPlayerEvent.STREAM_CLOSED));
            return;
        }// end function

        private function onRTXPlayerEvent(event:VideoPlayerEvent) : void
        {
            Debug.log("onRTXPlayerEvent:" + event.type);
            dispatchEvent(new VideoPlayerEvent(event.type));
            return;
        }// end function

        public function stop() : void
        {
            if (this.player)
            {
                this.player.close();
                this.player.streamCreateListener = null;
                this.player.streamCloseListener = null;
                this._stream = null;
                this.player = null;
            }
            return;
        }// end function

        public function get stream() : NetStream
        {
            return this._stream;
        }// end function

        public function get bP2P() : Boolean
        {
            return this._bP2P;
        }// end function

    }
}
