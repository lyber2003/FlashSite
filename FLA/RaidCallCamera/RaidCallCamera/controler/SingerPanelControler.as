package controler
{
    import com.carlcalderon.arthropod.*;
    import com.debug.*;
    import com.raidcall.rclive.*;
    import components.*;
    import components.events.*;
    import components.singer.*;
    import components.singer.video.*;
    import components.singer.video.core.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.media.*;
    import helper.*;
    import language.*;
    import rabitui.component.*;
    import rabitui.manager.*;
    import rcbiz.events.*;
    import rcbiz.model.client.*;
    import utils.*;

    public class SingerPanelControler extends RCControlerBase
    {
        private var singerPanel:SingerPanel;
        private var video:VideoPanel;
        private var videoConver:VideoConver;
        private var mainStage:MainStage;
        public var videoStatus:String;
        private var selectCamera:String;

        public function SingerPanelControler(param1:SingerPanel, param2:MainStage)
        {
            this.singerPanel = param1;
            this.video = param1.video;
            this.video.clientWidget = clientWidget;
            this.videoConver = param1.videoConver;
            this.videoConver.stopPlayBtn.addEventListener(MouseEvent.CLICK, this.onStopPlayBtnClick);
            this.videoConver.stopPublishBtn.addEventListener(MouseEvent.CLICK, this.onStopPublishBtnClick);
            this.videoConver.playBtn.addEventListener(MouseEvent.CLICK, this.onPlayBtnClick);
            this.videoConver.publishBtn.addEventListener(MouseEvent.CLICK, this.onPublishBtnClick);
            this.video.addEventListener(RCLiveVideoEvent.STOP_VIDEO, this.onStopPlayBtnClick);
            this.video.addEventListener(LiveStreamEvent.LIVE_PLAYING_CHANGE, this.onLiveChange);
            var _loc_3:* = this.video.vplayer.player;
            _loc_3.addEventListener(RCLiveVideoEvent.onStreamData, this.onStreamData);
            clientWidget.addEventListener(ClientEvent.SINGER_CHANGE, this.onSingerChange);
            clientWidget.addEventListener(ClientEvent.VIDEO_ENABLE_CHNAGE, this.onVideoEnableChange);
            showWidget.rcbiz.interfaces:IShowWidget::addEventListener(ShowEvent.SINGER_INFO_UPDATE, this.onSingerInfoUpdate);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_CREATE, this.onLiveStreamCreate);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_BEGIN, this.onLiveStreamBegin);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_END, this.onLiveStreamEnd);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_PLAY, this.onLiveStreamPlay);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_PLAY_EX, this.onStreamPlayerEx);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.LIVE_CHANGE, this.onLiveChange);
            videoWidget.rcbiz.interfaces:IVideoWidget::addEventListener(LiveStreamEvent.STREAM_SHAKE, this.onVideoShake);
            return;
        }// end function

        private function onLivePlayChange(event:LiveStreamEvent) : void
        {
            this.updateVideoState();
            return;
        }// end function

        private function onStreamData(event:RCLiveVideoEvent) : void
        {
            var _loc_2:* = event.info;
            clientWidget.protoApi.PStreamData(_loc_2.info, _loc_2.bufferTime, _loc_2.bufferLength);
            return;
        }// end function

        private function onVideoEnableChange(event:ClientEvent) : void
        {
            DebugX.out("---onVideoEnableChange---", clientWidget.videoEnable);
            if (!clientWidget.videoEnable)
            {
                this.video.stopPlayStream();
                this.video.stopPublishStream();
            }
            this.updateVideoState();
            return;
        }// end function

        private function onActiveClick(event:MouseEvent) : void
        {
            showWidget.navigatToActivetyHome();
            return;
        }// end function

        private function onLoaddingComplete(event:Event) : void
        {
            showWidget.changeVoiceNormal();
            return;
        }// end function

        protected function onVideoShake(event:LiveStreamEvent) : void
        {
            return;
        }// end function

        protected function onPlayBtnClick(event:MouseEvent) : void
        {
            this.playStream();
            return;
        }// end function

        protected function onPublishBtnClick(event:MouseEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            Camera.getCamera();
            var _loc_2:* = Camera.names.length;
            if (_loc_2 == 0)
            {
                PopUpManager.Alert(Lang.getString(10006), AlertIconType.WARN);
            }
            else if (_loc_2 == 1)
            {
                this.onCameraSelect(new CameraSelectEvent("0"));
            }
            else if (_loc_2 > 1)
            {
                _loc_3 = new CameraSelect();
                _loc_4 = this.videoConver.publishBtn.localToGlobal(new Point(this.videoConver.publishBtn.width, 0));
                _loc_3.x = _loc_4.x;
                _loc_3.y = _loc_4.y;
                _loc_3.addEventListener(CameraSelectEvent.SELECT, this.onCameraSelect);
                PopUpManager.addPopUp(_loc_3);
            }
            return;
        }// end function

        protected function onStopPlayBtnClick(event:Event) : void
        {
            this.video.stopPlayStream();
            this.updateVideoState();
            return;
        }// end function

        protected function onStopPublishBtnClick(event:MouseEvent) : void
        {
            this.video.stopPublishStream();
            videoWidget.rcbiz.interfaces:IVideoWidget::protoApi.PDeleteStream();
            this.updateVideoState();
            return;
        }// end function

        protected function onLiveStreamBegin(event:Event) : void
        {
            DebugX.trace("onLiveStreamBegin");
            this.playStream();
            return;
        }// end function

        private function playStream() : void
        {
            if (clientWidget.singer.isMe)
            {
                videoWidget.rcbiz.interfaces:IVideoWidget::protoApi.PPlayStream(["rtmp"], UtilTool.getRegion());
            }
            else
            {
                videoWidget.rcbiz.interfaces:IVideoWidget::protoApi.PPlayStream(["rtmp", "fusion"], UtilTool.getRegion());
            }
            return;
        }// end function

        protected function onStreamPlayerEx(event:LiveStreamEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = false;
            var _loc_8:* = null;
            if (event.data.result == 0)
            {
                _loc_2 = event.data;
                _loc_3 = _loc_2.protocols;
                _loc_4 = null;
                _loc_5 = null;
                _loc_6 = "";
                for each (_loc_8 in _loc_3)
                {
                    
                    if (_loc_8.name == "fusion")
                    {
                        _loc_4 = _loc_8;
                    }
                    if (_loc_8.name == "rtmp")
                    {
                        _loc_5 = _loc_8;
                    }
                }
                if (_loc_4)
                {
                    _loc_6 = _loc_4.url;
                    _loc_7 = true;
                }
                else
                {
                    _loc_6 = _loc_5.url;
                    _loc_7 = false;
                }
                this.video.startPlayStream(_loc_6, _loc_2.token, _loc_2.stream, _loc_7);
                this.updateVideoState();
            }
            return;
        }// end function

        protected function onLiveStreamPlay(event:LiveStreamEvent) : void
        {
            if (event.data.result == 0)
            {
                this.video.startPlayStream(event.data.url, event.data.token, event.data.stream, false);
                this.updateVideoState();
            }
            return;
        }// end function

        protected function onLiveStreamEnd(event:LiveStreamEvent) : void
        {
            this.updateVideoState();
            this.video.stopPlayStream();
            return;
        }// end function

        protected function onLiveStreamCreate(event:LiveStreamEvent) : void
        {
            if (event.data.result == 0)
            {
                this.video.startPublishStream(this.selectCamera, event.data.url, event.data.token);
                this.updateVideoState();
            }
            else
            {
                DebugX.trace("*************** create stream failed*************************");
                TipManager.showWarnTip(Lang.getString(10020), this.singerPanel.localToGlobal(new Point(this.singerPanel.preferWidth + 10, this.singerPanel.height / 2)), 1);
            }
            return;
        }// end function

        protected function onUploadBtnClick(event:MouseEvent) : void
        {
            showWidget.navigatToSingerPage();
            return;
        }// end function

        protected function onCameraSelect(event:CameraSelectEvent) : void
        {
            var _loc_2:* = null;
            this.selectCamera = event.selectcamera;
            if (videoWidget.isAgreeRule)
            {
                videoWidget.protoApi.PCreateStream(UtilTool.getRegion());
            }
            else
            {
                _loc_2 = new VideoAgreementWindow();
                _loc_2.addEventListener(CompomentEvent.AGREE_VIDEO_RULE, this.onAgreeVideoRule);
                PopUpManager.addPopUp(_loc_2, false);
            }
            return;
        }// end function

        protected function onAgreeVideoRule(event:CompomentEvent) : void
        {
            videoWidget.isAgreeRule = true;
            videoWidget.protoApi.PCreateStream(UtilTool.getRegion());
            return;
        }// end function

        protected function onBtnHomeClick(event:MouseEvent) : void
        {
            GetURLHelper.goToRCShow(clientWidget.singer.uid, clientWidget.myInfo.cookie);
            return;
        }// end function

        protected function onBtnFBClick(event:MouseEvent) : void
        {
            showWidget.navigateToFBPage();
            return;
        }// end function

        protected function onLiveChange(event:LiveStreamEvent) : void
        {
            clientWidget.singer.isLive = videoWidget.isLive;
            this.updateVideoState();
            return;
        }// end function

        protected function onSingerInfoUpdate(event:ShowEvent) : void
        {
            return;
        }// end function

        protected function onSingerChange(event:ClientEvent) : void
        {
            this.video.stop();
            showWidget.changeVoiceNormal();
            this.updateVideoState();
            return;
        }// end function

        private function updateVideoState() : void
        {
            var _loc_1:* = clientWidget.singer;
            var _loc_2:* = _loc_1.role >= Roler.MEMBER;
            var _loc_3:* = clientWidget.videoEnable;
            var _loc_4:* = _loc_1.isOnMic && _loc_1.isMe && !_loc_1.isLive && _loc_3 && _loc_2;
            Debug.log("bCanPublish:" + _loc_1.isOnMic + " " + _loc_1.isOnMic + " " + _loc_1.isMe + " " + _loc_1.isLive + " " + _loc_3 + " " + _loc_2);
            var _loc_5:* = this.video.bPlaying;
            if (videoWidget.isLive)
            {
                if (_loc_1.isMe)
                {
                    this.videoStatus = VideoConver.STATUS_PUBLISH;
                }
                else if (_loc_5)
                {
                    this.videoStatus = VideoConver.STATUS_PLAY;
                }
                else
                {
                    this.videoStatus = VideoConver.STATUS_LIVE_STOP;
                }
            }
            else if (_loc_4)
            {
                this.videoStatus = VideoConver.STATUS_UNPUBLISH;
            }
            else
            {
                this.videoStatus = VideoConver.STATUS_STOP;
            }
            this.singerPanel.setVideoStatus(this.videoStatus);
            dispatchEvent(new LiveStreamEvent(LiveStreamEvent.LIVE_STATUS_CHANGE));
            return;
        }// end function

        public function set bPlaying(param1:Boolean) : void
        {
            this.updateVideoState();
            return;
        }// end function

    }
}
