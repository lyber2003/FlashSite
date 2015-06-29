package rcbiz.widget
{
    import com.greensock.*;
    import flash.events.*;
    import flash.utils.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;
    import rcbiz.interfaces.proto.*;
    import rcbiz.model.show.video.*;
    import rcbiz.widget.proto.*;

    public class VideoWidget extends WidgetBase implements IVideoProtoCB, IVideoWidget
    {
        private var _isLive:Boolean = false;
        private var _isReady:Boolean = false;
        private var _isAgreeRule:Boolean = false;
        private var _protoApi:IVideoProtoApi;
        private var timer:Timer;
        private var _bGetStream:Boolean = false;
        private var _bWidgetInit:Boolean = false;
        public static const ID:int = 7;

        public function VideoWidget(param1:IClientWidget)
        {
            super(param1);
            this._protoApi = new VideoProtoApi(param1.protoApi, ID);
            param1.registerWidgetListner(ID, this);
            param1.addEventListener(ClientEvent.CHANNEL_INITED, this.onChannelInited);
            param1.addEventListener(ClientEvent.SET_VIDEO_ENABLE, this.onSetVideoEnable);
            this.timer = new Timer(2000, 3);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (!this._bWidgetInit)
            {
                this.protoApi.PLiveHandshake();
            }
            return;
        }// end function

        public function init() : void
        {
            this.protoApi.PLiveHandshake();
            this.timer.start();
            return;
        }// end function

        private function onSetVideoEnable(event:ClientEvent) : void
        {
            this.protoApi.PSetVideoEnable(int(event.data));
            return;
        }// end function

        private function onChannelInited(event:ClientEvent) : void
        {
            if (this._isReady)
            {
                this.isLive = false;
                this.getStram();
            }
            return;
        }// end function

        public function get isReady() : Boolean
        {
            return this._isReady;
        }// end function

        public function get isLive() : Boolean
        {
            return this._isLive;
        }// end function

        public function set isLive(param1:Boolean) : void
        {
            if (this._isLive != param1)
            {
                this._isLive = param1;
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.LIVE_CHANGE));
            }
            return;
        }// end function

        public function RLiveHandshake(param1:Object) : void
        {
            if (this._bWidgetInit)
            {
                return;
            }
            this._bWidgetInit = true;
            if (param1.result == 0)
            {
                this._isReady = true;
                this.isLive = false;
                this.getStram();
            }
            else
            {
                this._isReady = false;
            }
            this.timer.stop();
            dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_SHAKE));
            return;
        }// end function

        private function getStram() : void
        {
            this._bGetStream = false;
            this.protoApi.PGetStream();
            TweenLite.delayedCall(2, this.onCheckGetStream);
            return;
        }// end function

        private function onCheckGetStream() : void
        {
            if (!this._bGetStream)
            {
                this.protoApi.PGetStream();
            }
            else
            {
                TweenLite.killDelayedCallsTo(this.onCheckGetStream);
            }
            return;
        }// end function

        public function RCreateStream(param1:Object) : void
        {
            dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_CREATE, new StreamObject(param1)));
            return;
        }// end function

        public function BStreamBegin(param1:Object) : void
        {
            if (!rc.videoEnable)
            {
                return;
            }
            if (rc.videoEnable && !this.isLive)
            {
                this.isLive = true;
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_BEGIN, new StreamObject(param1)));
            }
            else
            {
                this.isLive = false;
            }
            return;
        }// end function

        public function BStreamEnd(param1:Object) : void
        {
            this.isLive = false;
            dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_END, new StreamObject(param1)));
            return;
        }// end function

        public function RPlayStream(param1:Object) : void
        {
            if (int(param1.version) == 1)
            {
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_PLAY_EX, new StreamObject(param1)));
            }
            else
            {
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_PLAY, new StreamObject(param1)));
            }
            return;
        }// end function

        public function RGetStream(param1:Object) : void
        {
            this._bGetStream = true;
            if (param1.hasOwnProperty("enable"))
            {
                rc.setChannVideoEnable(param1.enable);
            }
            if (param1.result == 0 && rc.videoEnable && !this.isLive)
            {
                this.isLive = true;
                dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_BEGIN, new StreamObject(param1)));
            }
            else
            {
                this.isLive = false;
            }
            return;
        }// end function

        public function RSetVideoEnable(param1:Object) : void
        {
            return;
        }// end function

        public function BVideoEnableChange(param1:Object) : void
        {
            rc.setChannVideoEnable(param1.enable);
            rc.protoApi.PVideoEnableChange(param1.enable);
            return;
        }// end function

        public function RPlayStreamEx(param1:Object) : void
        {
            dispatchEvent(new LiveStreamEvent(LiveStreamEvent.STREAM_PLAY_EX, new StreamObject(param1)));
            return;
        }// end function

        public function get isAgreeRule() : Boolean
        {
            return this._isAgreeRule;
        }// end function

        public function set isAgreeRule(param1:Boolean) : void
        {
            this._isAgreeRule = param1;
            return;
        }// end function

        public function get protoApi() : IVideoProtoApi
        {
            return this._protoApi;
        }// end function

    }
}
