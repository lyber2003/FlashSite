package rcbiz.widget
{
    import com.greensock.*;
    import flash.events.*;
    import rcbiz.core.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;
    import rcbiz.interfaces.proto.*;
    import rcbiz.model.client.*;
    import rcbiz.widget.proto.*;

    public class ClientWidget extends Object implements IClientProtoCB, IClientWidget
    {
        private var _channel:Channel;
        private var _group:Group;
        private var _myInfo:User;
        private var _singer:User;
        private var _bChannInited:Boolean = false;
        private var _bBinding:Boolean = false;
        private var _videoEnable:Boolean = true;
        private var _protoApi:ClientProtoApi;
        private var r:RCConnector;
        private var dispatcher:EventDispatcher;
        public static const ID:int = 0;

        public function ClientWidget(param1:RCConnector)
        {
            this._channel = new Channel();
            this._group = new Group();
            this._myInfo = new User();
            this._singer = new User();
            this.r = param1;
            this._protoApi = new ClientProtoApi(param1);
            this.registerWidgetListner(ID, this);
            this.dispatcher = new EventDispatcher();
            return;
        }// end function

        public function initialize() : void
        {
            this._group.sid = this.protoApi.SGetSid();
            this.channel.cid = this.protoApi.SGetCid();
            this.getMyInfo();
            this.protoApi.PInitWidget();
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            this.dispatcher.addEventListener(param1, param2, param3, param4);
            return;
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            this.dispatcher.removeEventListener(param1, param2, param3);
            return;
        }// end function

        private function getMyInfo() : void
        {
            var _loc_1:* = JSON.parse(this.protoApi.SGetMyInfo());
            if (_loc_1 != null)
            {
                this._myInfo = new User();
                this._myInfo.uid = _loc_1.uid;
                this._myInfo.nick = _loc_1.nick;
                this._myInfo.cookie = _loc_1.cookie;
                this._myInfo.imageUrl = _loc_1.imageUrl;
                this._myInfo.isMe = true;
                this._myInfo.role = this.protoApi.SGetMyRole();
            }
            TweenLite.delayedCall(10 * 60, this.getMyInfo);
            return;
        }// end function

        private function updateMicMode() : void
        {
            var _loc_1:* = null;
            if (this.channel.channelMode != ChannelMode.QUEUE)
            {
                _loc_1 = MicMode.NOT_MIC_MODE;
            }
            else if (this._singer.uid == 0)
            {
                _loc_1 = MicMode.MIC_MODE_EMPTY;
            }
            else
            {
                _loc_1 = MicMode.MIC_MODE_ONLINE;
            }
            if (this.channel.micMode != _loc_1)
            {
                this.channel.micMode = _loc_1;
                this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.MIC_MODE_CHANGE));
            }
            return;
        }// end function

        public function BSwitchChannel(param1:int, param2:int) : void
        {
            this._bChannInited = false;
            this._channel = new Channel();
            this.channel.cid = param1;
            this.channel.channelMode = param2;
            this._myInfo.role = this.protoApi.SGetMyRole();
            this.updateMicMode();
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.SWITCH_CHANNEL));
            return;
        }// end function

        public function BMicUserChange(param1:String) : void
        {
            var _loc_2:* = JSON.parse(param1);
            if (_loc_2.uid != this._singer.uid)
            {
                this._singer = new User();
                this._singer.uid = _loc_2.uid;
                this._singer.nick = _loc_2.nick;
                this._singer.isMe = this._singer.uid == this._myInfo.uid;
                this._singer.isOnMic = true;
                this._myInfo.isOnMic = this._singer.uid == this._myInfo.uid;
                if (this._myInfo.isOnMic)
                {
                    this._singer.role = this._myInfo.role;
                }
                this.updateMicMode();
                this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.SINGER_CHANGE));
            }
            if (!this._bChannInited)
            {
                this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.CHANNEL_INITED));
            }
            this._bChannInited = true;
            return;
        }// end function

        public function BChannelModeChange(param1:int) : void
        {
            this.channel.channelMode = param1;
            this.updateMicMode();
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.CHANNEL_MODE_CHANGE));
            return;
        }// end function

        public function BReconnected() : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.RECONNECT));
            return;
        }// end function

        public function BDestroyFlash() : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.DESTORY));
            return;
        }// end function

        public function BFBBinding(param1:int) : void
        {
            this._bBinding = param1 == 1;
            return;
        }// end function

        public function RInitCompelete() : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.INIT_COMPELETE));
            return;
        }// end function

        public function RGetUserNick(param1:String) : void
        {
            return;
        }// end function

        public function CGetVideoEnable() : void
        {
            this._protoApi.PVideoEnableChange(this.channel.videoEnable);
            return;
        }// end function

        public function CSetVideoEnable(param1:int) : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.SET_VIDEO_ENABLE, param1));
            return;
        }// end function

        public function BEnableVideoWidget(param1:int) : void
        {
            this._group.videoEnable = param1;
            this.videoEnable = this._group.videoEnable == 1 && this.channel.videoEnable == 1;
            return;
        }// end function

        public function setChannVideoEnable(param1:int) : void
        {
            this.channel.videoEnable = param1;
            this._protoApi.PVideoEnableChange(this.channel.videoEnable);
            this.videoEnable = this._group.videoEnable == 1 && this.channel.videoEnable == 1;
            return;
        }// end function

        public function BCPUNotify(param1:int) : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.CPU_VALUE_CHNAGE, param1));
            return;
        }// end function

        public function get videoEnable() : Boolean
        {
            return this._videoEnable;
        }// end function

        public function set videoEnable(param1:Boolean) : void
        {
            if (this._videoEnable != param1)
            {
                this._videoEnable = param1;
                this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.VIDEO_ENABLE_CHNAGE));
            }
            return;
        }// end function

        public function BIsUserInChannel(param1:String, param2:String) : void
        {
            this.dispatcher.dispatchEvent(new ClientEvent(ClientEvent.R_ONLINE, {uid:param1, cid:param2}));
            return;
        }// end function

        public function get protoApi() : IClientProtoApi
        {
            return this._protoApi;
        }// end function

        public function registerWidgetListner(param1:int, param2:Object) : void
        {
            this.r.registerWidgetListenter(param1, param2);
            return;
        }// end function

        public function get channel() : Channel
        {
            return this._channel;
        }// end function

        public function get group() : Group
        {
            return this._group;
        }// end function

        public function get myInfo() : User
        {
            return this._myInfo;
        }// end function

        public function get singer() : User
        {
            return this._singer;
        }// end function

        public function get bChannInited() : Boolean
        {
            return this._bChannInited;
        }// end function

        public function get bBinding() : Boolean
        {
            return this._bBinding;
        }// end function

    }
}
