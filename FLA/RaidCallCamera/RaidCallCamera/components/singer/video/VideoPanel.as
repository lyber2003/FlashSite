package components.singer.video
{
    import com.debug.*;
    import components.singer.video.core.*;
    import flash.media.*;
    import rabitui.uicore.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;

    public class VideoPanel extends UIObject
    {
        public var vplayer:RCLiveVideoPlayer;
        private var rcShowLogo:AssetRCShowLogo;
        private var _isPlaying:Boolean;
        public var isPublishing:Boolean;
        public var clientWidget:IClientWidget;

        public function VideoPanel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.vplayer = new RCLiveVideoPlayer();
            this.vplayer.addEventListener(RCLiveVideoEvent.StatusChange, this.onPlayerStatusChange);
            addChild(this.vplayer);
            this.rcShowLogo = new AssetRCShowLogo();
            this.rcShowLogo.visible = false;
            addChild(this.rcShowLogo);
            return;
        }// end function

        public function startPlayStream(param1:String, param2:String, param3:String, param4:Boolean) : void
        {
            this.vplayer.play(param1, param2, param3, param4);
            return;
        }// end function

        public function stopPlayStream() : void
        {
            this.bPlaying = false;
            this.vplayer.stop();
            return;
        }// end function

        public function startPublishStream(param1:String, param2:String, param3:String) : void
        {
            this.isPublishing = true;
            this.clientWidget.protoApi.PSetFPS(24);
            this.clientWidget.protoApi.PPublish(param2, param3, Camera.names[param1]);
            return;
        }// end function

        public function stopPublishStream() : void
        {
            this.isPublishing = false;
            this.clientWidget.protoApi.PStopPublish();
            this.vplayer.stop();
            return;
        }// end function

        public function stop() : void
        {
            this.stopPlayStream();
            this.stopPublishStream();
            this.clientWidget.protoApi.PSetStopSpeaker();
            return;
        }// end function

        private function onPlayerStatusChange(event:RCLiveVideoEvent) : void
        {
            DebugX.trace("Play Status Change:" + event.status);
            switch(event.status)
            {
                case RCLiveVideoStatus.PLAY_START:
                {
                    this.bPlaying = true;
                    this.clientWidget.protoApi.PSetSpeaker(this.clientWidget.singer.uid);
                    break;
                }
                case RCLiveVideoStatus.BUFFER_FULL:
                {
                    break;
                }
                case RCLiveVideoStatus.PLAYING:
                {
                    break;
                }
                case RCLiveVideoStatus.VIDEO_SIZE_CHANGE:
                {
                    break;
                }
                case RCLiveVideoStatus.PLAY_STOP:
                {
                    this.bPlaying = false;
                    this.clientWidget.protoApi.PSetStopSpeaker();
                    dispatchEvent(new RCLiveVideoEvent(RCLiveVideoEvent.STOP_VIDEO));
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onPublishStatusChange(event:RCLiveVideoEvent) : void
        {
            DebugX.trace("Publish Status Change:" + event.status);
            switch(event.status)
            {
                case RCLiveVideoStatus.PUBLISH_START:
                {
                    break;
                }
                case RCLiveVideoStatus.PUBLISHING:
                {
                    break;
                }
                case RCLiveVideoStatus.PUBLISH_STOP:
                {
                    this.stop();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function set bPlaying(param1:Boolean) : void
        {
            if (this._isPlaying != param1)
            {
                this._isPlaying = param1;
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.LIVE_PLAYING_CHANGE));
            }
            return;
        }// end function

        public function get bPlaying() : Boolean
        {
            return this._isPlaying;
        }// end function

        override protected function updateDisplay() : void
        {
            this.vplayer.width = preferWidth;
            this.vplayer.height = preferHeight;
            this.rcShowLogo.x = preferWidth - this.rcShowLogo.width;
            this.rcShowLogo.y = preferHeight - this.rcShowLogo.height + 5;
            return;
        }// end function

    }
}
