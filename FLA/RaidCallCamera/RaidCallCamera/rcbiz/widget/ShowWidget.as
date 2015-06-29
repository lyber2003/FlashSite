package rcbiz.widget
{
    import com.debug.*;
    import com.greensock.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;
    import rcbiz.interfaces.proto.*;
    import rcbiz.model.*;
    import rcbiz.model.client.*;
    import rcbiz.model.show.active.*;
    import rcbiz.model.show.ads.*;
    import rcbiz.model.show.guard.*;
    import rcbiz.widget.proto.*;
    import utils.*;

    public class ShowWidget extends WidgetBase implements IShowProtoCB, IShowWidget
    {
        private var singer:User;
        private var timer:Timer;
        private var _getChanAttrTick:int = 0;
        private var _multiGiftingData:Array;
        private var _bWidgetInit:Boolean = false;
        private var _bAllInit:Boolean = false;
        private var _state:int;
        private var _errorMessage:String = "";
        private var nRetryHand:int = 0;
        private var nReTryInitUser:int = 0;
        private var toolVersion:int = 0;
        private var _protoApi:IShowProtoApi;
        private var bGetUserInfo:Boolean = false;
        private var _giftData:Dictionary;
        private var _classified:Dictionary;
        private var _packetData:Array;
        private var _showToolList:Array;
        private var _toolPacketList:Array;
        private var _toolStateList:Dictionary;
        private var _effect:uint;
        public var _effectUrl:String;
        public var bGetShowToolList:Boolean = false;
        public var bGetToolPacket:Boolean = false;
        public var backImageList:Array;
        private var _background:uint;
        public var _backGroundUrl:String;
        public const VOICE_CHANGE_TIME:int = 300000;
        public var _eggInfoArr:Array;
        public var _refreshTime:Number;
        public var _refreshCost:Number;
        private var _guardInfo:GuardInfo;
        public var _adsInfo:AdsInfo;
        public static const ID:int = 6;
        public static const STATE_HANDLE_SHARK_SUCESS:int = 0;
        public static const STATE_HANDLE_SHARKING:int = 1;
        public static const STATE_SYSTEM_ERROR:int = 2;
        public static const STATE_HANDLE_SHARK_TIMEOUT:int = 3;
        public static const RECHARGE_URL:String = "http://www.raidpay.com.tw/index.php?c=home&a=autoLogin&param=";
        public static const FAQ_URL:String = "http://www.raidcall.com.tw/faqshow.php";
        public static const STORY_MONEY_URL:String = "http://www.raidcall.com.tw/rcec/index.php?cmd=payGiftPacket&param=";
        public static var imageHost:String = "";

        public function ShowWidget(param1:IClientWidget)
        {
            this._multiGiftingData = [];
            this._packetData = new Array();
            this._showToolList = [];
            this._toolPacketList = [];
            this._toolStateList = new Dictionary();
            this.backImageList = [];
            this._eggInfoArr = [];
            this._guardInfo = new GuardInfo();
            this._adsInfo = new AdsInfo();
            this._protoApi = new ShowProtoApi(param1.protoApi, ID);
            super(param1);
            param1.registerWidgetListner(ID, this);
            this.timer = new Timer(2000, 3);
            this.timer.addEventListener(TimerEvent.TIMER, this.onTimer);
            return;
        }// end function

        public function init() : void
        {
            this.protoApi.PHandshake();
            this._state = STATE_HANDLE_SHARKING;
            TweenLite.delayedCall(2, this.onCheckHandleShark);
            return;
        }// end function

        public function initShowWidget() : void
        {
            this.protoApi.PInitEnv(this.toolVersion);
            this.luckDrawInit();
            this.timer.start();
            return;
        }// end function

        public function RInitShowWidget(param1:Object) : void
        {
            if (this._bWidgetInit)
            {
                return;
            }
            this._bWidgetInit = true;
            this.singer = this.rc.singer;
            this.RGetUserInfo(param1.UserInfo);
            this.RGetGiftList(param1.GiftList);
            this.RGetGiftPacket(param1.GiftPacket);
            this.RGetShowTool(param1.ShowTool);
            this.RGetToolPacket(param1.ToolPacket);
            this.RGetEggInfo(param1.EggInfo);
            if (param1.hasOwnProperty("BroadcastInfo"))
            {
                this.BBroadcast(param1.BroadcastInfo);
            }
            if (param1.hasOwnProperty("GiftBoxInfo"))
            {
                this.RGetGiftBox(param1.GiftBoxInfo);
            }
            if (param1.hasOwnProperty("SingerInfo"))
            {
                this.RGetSingerInfo(param1.SingerInfo);
            }
            if (param1.hasOwnProperty("Ranking"))
            {
                this.RGetRanking(param1.Ranking);
            }
            if (param1.hasOwnProperty("SpeakerInfo"))
            {
                this.RSpeakerInfo(param1.SpeakerInfo);
            }
            dispatchEvent(new ShowEvent(ShowEvent.INIT_SHOW_WIDGET));
            DebugX.trace("JSONData.GiftList-----------------");
            DebugX.trace(JSON.stringify(param1.GiftList));
            DebugX.trace("----------------------------------");
            DebugX.trace("JSONData.GiftPacket-----------------");
            DebugX.trace(JSON.stringify(param1.GiftPacket));
            DebugX.trace("----------------------------------");
            DebugX.trace("JSONData.ToolPacket-----------------");
            DebugX.trace(JSON.stringify(param1.ToolPacket));
            DebugX.trace("----------------------------------");
            this._protoApi.PLogActiveUser();
            this._protoApi.PGetAds();
            this.timer.stop();
            this.addListener();
            return;
        }// end function

        public function RInitEnv(param1:Object) : void
        {
            if (this._bWidgetInit)
            {
                return;
            }
            this._bWidgetInit = true;
            this.singer = this.rc.singer;
            if (param1.hasOwnProperty("SingerInfo"))
            {
                this.RGetSingerInfo(param1.SingerInfo);
            }
            dispatchEvent(new ShowEvent(ShowEvent.INIT_SHOW_WIDGET));
            this._protoApi.PLogActiveUser();
            this.timer.stop();
            this.addListener();
            return;
        }// end function

        private function initUser() : void
        {
            if (this.nReTryInitUser < 4)
            {
                TweenLite.delayedCall(3, this.initUser);
                var _loc_1:* = this;
                var _loc_2:* = this.nReTryInitUser + 1;
                _loc_1.nReTryInitUser = _loc_2;
                this._protoApi.PInitUser();
            }
            return;
        }// end function

        public function RInitUser(param1:Object) : void
        {
            TweenLite.killDelayedCallsTo(this.initUser);
            this.RGetUserInfo(param1.UserInfo);
            this.RGetGiftPacket(param1.GiftPacket);
            this.RGetToolPacket(param1.ToolPacket);
            this.RGetEggInfo(param1.EggInfo);
            if (param1.hasOwnProperty("SpeakerInfo"))
            {
                this.RSpeakerInfo(param1.SpeakerInfo);
            }
            if (param1.hasOwnProperty("GiftBoxInfo"))
            {
                this.RGetGiftBox(param1.GiftBoxInfo);
            }
            return;
        }// end function

        private function addListener() : void
        {
            rc.addEventListener(ClientEvent.SINGER_CHANGE, this.onSingerChange);
            rc.addEventListener(ClientEvent.SWITCH_CHANNEL, this.onSwitchChannel);
            return;
        }// end function

        private function onTimer(event:TimerEvent) : void
        {
            if (!this._bWidgetInit)
            {
                this.protoApi.PInitEnv(this.toolVersion);
            }
            return;
        }// end function

        protected function onSwitchChannel(event:ClientEvent) : void
        {
            this._getChanAttrTick = 1;
            this.background = 0;
            this.effect = 0;
            TweenLite.delayedCall(1, this.chanDelayInit);
            return;
        }// end function

        private function chanDelayInit() : void
        {
            if (rc.singer.uid != 0)
            {
                this.protoApi.PGetSingerInfo();
                this.protoApi.PGetRanking();
            }
            return;
        }// end function

        private function onSingerChange(event:ClientEvent) : void
        {
            this.singer = rc.singer;
            this.effect = 0;
            return;
        }// end function

        public function BMicOn(param1:Object) : void
        {
            if (!this._bWidgetInit)
            {
                return;
            }
            DebugX.print("BMicOn");
            this.RGetSingerInfo(param1.SingerInfo);
            return;
        }// end function

        public function BMicOff(param1:Object) : void
        {
            this.background = 0;
            return;
        }// end function

        private function callServer(param1:String, param2:Object = null) : void
        {
            if (param2 == null)
            {
                param2 = new Object();
            }
            param2.cmd = param1;
            rc.protoApi.SecCallServer(ID, JSON.stringify(param2));
            return;
        }// end function

        public function RHandshake(param1:Object) : void
        {
            TweenLite.killDelayedCallsTo(this.onCheckHandleShark);
            if (int(param1.result) == 0)
            {
                this._state = STATE_HANDLE_SHARK_SUCESS;
                this.dispatchEvent(new ShowEvent(ShowEvent.STATE_CHANGE));
                this.initShowWidget();
                this.dispatchEvent(new ShowEvent(ShowEvent.HANDLE_SHARK_SUCESS));
            }
            return;
        }// end function

        private function onCheckHandleShark() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this.nRetryHand + 1;
            _loc_1.nRetryHand = _loc_2;
            if (this.nRetryHand <= 3)
            {
                TweenLite.delayedCall(2, this.onCheckHandleShark);
                this.protoApi.PHandshake();
            }
            else
            {
                this._state = STATE_HANDLE_SHARK_TIMEOUT;
                this._errorMessage = "連接服務器超時，請重進群...";
                this.dispatchEvent(new ShowEvent(ShowEvent.STATE_CHANGE));
            }
            return;
        }// end function

        public function RServerStatus(param1:Object) : void
        {
            TweenLite.killDelayedCallsTo(this.onCheckHandleShark);
            this._state = STATE_SYSTEM_ERROR;
            this._errorMessage = param1.errorMessage;
            this.dispatchEvent(new ShowEvent(ShowEvent.STATE_CHANGE, param1));
            return;
        }// end function

        public function RLogActiveUser(param1:Object) : void
        {
            return;
        }// end function

        public function RGetTimestamp(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_SERVER_TIME, param1));
            return;
        }// end function

        public function RGetLoginPacket(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.GET_LOGIN, param1));
            return;
        }// end function

        public function RSendLoginPacket(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            if (param1.result == 0)
            {
                _loc_2 = param1.packet;
                _loc_6 = 0;
                while (_loc_6 < _loc_2.length)
                {
                    
                    _loc_3 = _loc_2[_loc_6];
                    _loc_4 = _loc_3.giftId;
                    _loc_5 = _loc_3.giftNum;
                    this.updatePacketData(_loc_4, _loc_5, true);
                    _loc_6++;
                }
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.SEND_LOGIN, param1));
            return;
        }// end function

        public function playGame(param1:int) : void
        {
            if (!this.adsInfo.bShowAds)
            {
                return;
            }
            var _loc_2:* = this.adsInfo.getCurrentItem();
            if (this.isHttp(_loc_2.authUrl))
            {
                if (_loc_2.notAuth == 1)
                {
                    this.openGameUrl();
                }
                else
                {
                    this.openAuthGameUrl();
                }
            }
            else
            {
                this.openGameBox();
            }
            this.countGame();
            return;
        }// end function

        private function countGame() : void
        {
            var _loc_1:* = "http://showads.raidtalk.com.tw/click.php?cookie=" + rc.myInfo.cookie + "&fid=" + this.adsInfo.getCurrentItem().rid + "&random=" + new Date().time;
            var _loc_2:* = new URLRequest(_loc_1);
            var _loc_3:* = new URLLoader();
            _loc_3.load(_loc_2);
            return;
        }// end function

        private function isHttp(param1:String) : Boolean
        {
            var _loc_2:* = "http://";
            var _loc_3:* = "https://";
            var _loc_4:* = param1.substr(0, _loc_2.length);
            if (param1.substr(0, _loc_2.length) == _loc_2)
            {
                return true;
            }
            _loc_4 = param1.substr(0, _loc_3.length);
            if (_loc_4 == _loc_3)
            {
                return true;
            }
            return false;
        }// end function

        public function openAuthGameUrl() : void
        {
            var _loc_2:* = 0;
            if (!this.adsInfo.bShowAds)
            {
                return;
            }
            var _loc_1:* = "";
            _loc_1 = this.adsInfo.getCurrentItem().authUrl;
            _loc_2 = this.adsInfo.getCurrentItem().rid;
            var _loc_3:* = new URLVariables();
            _loc_3.uid = rc.myInfo.uid;
            _loc_3.callback = _loc_1;
            var _loc_4:* = _loc_3.toString();
            _loc_4 = _loc_3.toString() + "&cookies=" + rc.myInfo.cookie;
            var _loc_5:* = "http://open.raidtalk.com.tw/oauth/authorize2.php?" + _loc_4;
            var _loc_6:* = "http://open.raidtalk.com.tw/ad/go.php";
            var _loc_7:* = new URLVariables();
            _loc_3.version = "show";
            _loc_7.rid = _loc_2;
            _loc_7.uid = rc.myInfo.uid;
            _loc_7.kver = 726;
            _loc_7.url = _loc_5;
            var _loc_8:* = new URLRequest(_loc_6);
            _loc_8.data = _loc_7;
            navigateToURL(_loc_8);
            return;
        }// end function

        public function openGameUrl() : void
        {
            var _loc_2:* = 0;
            if (!this.adsInfo.bShowAds)
            {
                return;
            }
            var _loc_1:* = "";
            _loc_1 = this.adsInfo.getCurrentItem().authUrl;
            _loc_2 = this.adsInfo.getCurrentItem().rid;
            var _loc_3:* = "http://open.raidtalk.com.tw/oauth/play.php?cookies=" + rc.myInfo.cookie + "&";
            var _loc_4:* = new URLVariables();
            _loc_4.uid = rc.myInfo.uid;
            _loc_4.callback = _loc_1;
            var _loc_5:* = new URLRequest(_loc_3 + _loc_4.toString());
            navigateToURL(_loc_5);
            return;
        }// end function

        public function openGameBox() : void
        {
            var _loc_1:* = this.adsInfo.getCurrentItem().authUrl;
            rc.protoApi.PShowExternalUrl(_loc_1);
            return;
        }// end function

        public function RGetUserInfo(param1:Object) : void
        {
            this.bGetUserInfo = true;
            this.rc.myInfo.singerInfo.charm = param1.charm;
            this.rc.myInfo.silver = param1.silver;
            this.rc.myInfo.singerInfo.heart = int(param1.heart);
            this.rc.myInfo.singerInfo.numHeartConvert = param1.numHeartConvert;
            this.rc.myInfo.singerInfo.hour = int(param1.hour);
            this.rc.myInfo.singerInfo.faceBookUrl = param1.faceBookUrl;
            this.rc.myInfo.singerInfo.homePageUrl = param1.homePageUrl;
            this.rc.myInfo.singerInfo.images = param1.images.concat();
            this.rc.myInfo.singerInfo.coinBalance = param1.coinBalance;
            this.rc.myInfo.singerInfo.pointBalance = param1.pointBalance;
            this.rc.myInfo.singerInfo.experience = param1.experience;
            this.rc.myInfo.singerInfo.singerLevel = param1.singerLevel;
            this.rc.myInfo.singerInfo.nobleLevel = param1.nobleLevel;
            this.rc.myInfo.singerInfo.follows = param1.follows;
            this.rc.myInfo.singerInfo.bUpdateSinger = true;
            this.rc.myInfo.singerInfo.lastTimeReadNotice = param1.lastTimeReadNotice;
            this.rc.myInfo.isNew = param1.isNew;
            this.rc.myInfo.singerInfo.luckyShakeCount = param1.luckyShakeCount;
            this.rc.myInfo.singerInfo.vip = param1.vip;
            this.rc.myInfo.singerInfo.vipLeftTime = param1.vipLeftTime;
            if (param1.hasOwnProperty("activityDailyPacketGiftNum"))
            {
                this.updatePacketData(param1.activityDailyPacketGiftId, param1.activityDailyPacketGiftNum, true);
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_GET_DAY_PACKET, param1.activityDailyPacketGiftNum));
            }
            this.rc.myInfo.singerInfo.eggs = param1.eggs;
            DebugX.trace("------------" + param1.eggs);
            this.dispatchEvent(new ShowEvent(ShowEvent.MYINFO_UPDATE, param1));
            return;
        }// end function

        public function RGetSingerInfo(param1:Object) : void
        {
            DebugX.print("RGetSingerInfo:", param1.result, " uid1:" + param1.uid, " uid2:", this.singer.uid);
            if (int(param1.result) == 0)
            {
                this.singer.singerInfo.uid = param1.uid;
                this.singer.singerInfo.charm = param1.charm;
                this.dispatchEvent(new ShowEvent(ShowEvent.SINGER_INFO_UPDATE, param1));
            }
            return;
        }// end function

        public function RGetLevelInfo(param1:Object) : void
        {
            this.rc.myInfo.singerInfo.lastTimeReadNotice = param1.lastTimeReadNotice;
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_LEVEL_INFO, param1));
            return;
        }// end function

        public function isFollowSinger(param1:int) : Boolean
        {
            var _loc_2:* = this.rc.myInfo.singerInfo.follows;
            var _loc_3:* = false;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                if (_loc_2[_loc_4] == param1)
                {
                    _loc_3 = true;
                    break;
                }
                _loc_4++;
            }
            return _loc_3;
        }// end function

        public function updateFollowSinger(param1:int, param2:Boolean) : void
        {
            var _loc_5:* = 0;
            var _loc_3:* = this.rc.myInfo.singerInfo.follows;
            var _loc_4:* = this.isFollowSinger(param1);
            if (param2)
            {
                if (_loc_4)
                {
                    return;
                }
                _loc_3.push(param1);
            }
            else
            {
                if (!_loc_4)
                {
                    return;
                }
                _loc_5 = 0;
                while (_loc_5 < _loc_3.length)
                {
                    
                    if (_loc_3[_loc_5] == param1)
                    {
                        _loc_3.splice(_loc_5, 1);
                    }
                    _loc_5++;
                }
            }
            return;
        }// end function

        private function updateCoinBalance(param1:Object, param2:Boolean = false) : void
        {
            if (param2)
            {
                this.rc.myInfo.singerInfo.coinBalance = this.rc.myInfo.singerInfo.coinBalance + param1;
            }
            else
            {
                if (!param1.hasOwnProperty("coinBalance"))
                {
                    return;
                }
                this.rc.myInfo.singerInfo.coinBalance = param1.coinBalance;
                DebugX.print("updateCoinBalance:" + param1.coinBalance);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_BALANCE_CHANGE));
            return;
        }// end function

        public function RGetRanking(param1:Object) : void
        {
            this.singer.singerInfo.ranking = param1.list;
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_RANKING, param1));
            return;
        }// end function

        public function BSingerLevelUp(param1:Object) : void
        {
            this.rc.singer.singerInfo.experience = param1.experience;
            this.rc.singer.singerInfo.singerLevel = param1.singerLevel;
            this.rc.singer.singerInfo.currentLevelExperience = param1.currentLevelExperience;
            this.rc.singer.singerInfo.experienceLevelUp = param1.experienceLevelUp;
            this.rc.singer.singerInfo.titleLevel = param1.titleLevel;
            this.rc.singer.singerInfo.singerTitle = param1.singerTitle;
            this.dispatchEvent(new ShowEvent(ShowEvent.SINGER_LEVEL_UP, param1));
            return;
        }// end function

        public function RReadNotice(param1:Object) : void
        {
            this.rc.myInfo.singerInfo.lastTimeReadNotice = param1.lastTimeReadNotice;
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_READ_NOTICE, param1));
            return;
        }// end function

        public function RIkalaVerify(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_IKALA, param1));
            return;
        }// end function

        public function navigatToSingerPage() : void
        {
            var _loc_1:* = this.singer.singerInfo.homePageUrl + "&uid=" + this.singer.uid + "&param=" + this.rc.myInfo.cookie + "&myUid=" + this.rc.myInfo.uid;
            navigateToURL(new URLRequest(_loc_1), "_blank");
            return;
        }// end function

        public function navigateToFBPage() : void
        {
            navigateToURL(new URLRequest(this.singer.singerInfo.faceBookUrl), "_blank");
            return;
        }// end function

        public function navigatToMyHomePage() : void
        {
            var _loc_1:* = this.rc.myInfo.singerInfo.homePageUrl + "&uid=" + this.rc.myInfo.uid + "&param=" + this.rc.myInfo.cookie;
            navigateToURL(new URLRequest(_loc_1), "_blank");
            return;
        }// end function

        public function navigatToHomePage(param1:int) : void
        {
            var _loc_2:* = "http://www.raidcall.com.tw/rcec/index.php?cmd=showPhotoWall&uid=" + "&uid=" + param1;
            navigateToURL(new URLRequest(_loc_2), "_blank");
            return;
        }// end function

        public function navigatToActivetyHome() : void
        {
            var _loc_1:* = "http://www.raidcall.com.tw/rcec/index.php?cmd=summerCarnival";
            navigateToURL(new URLRequest(_loc_1), "_blank");
            return;
        }// end function

        public function RSendHeart(param1:Object) : void
        {
            var _loc_2:* = param1.result;
            if (_loc_2 == 0 && this.rc.myInfo.singerInfo.heart > 0)
            {
                var _loc_3:* = this.rc.myInfo.singerInfo;
                var _loc_4:* = _loc_3.heart - 1;
                _loc_3.heart = _loc_4;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.SEND_HEART_RESULT, param1));
            return;
        }// end function

        public function RConvertHeart(param1:Object) : void
        {
            var _loc_2:* = int(param1.result);
            if (_loc_2 == 0)
            {
                this.rc.myInfo.singerInfo.heart = int(param1.num);
                this.rc.myInfo.silver = int(param1.silver);
                this.rc.myInfo.singerInfo.numHeartConvert = int(param1.numHeartConvert);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.CONVERT_HEART_RESULT, param1));
            return;
        }// end function

        public function BHeart(param1:Object) : void
        {
            if (!this._bWidgetInit)
            {
                return;
            }
            var _loc_2:* = param1.receiver;
            if (this.rc.singer.uid == _loc_2)
            {
                this.rc.singer.singerInfo.charm = param1.charm;
                this.dispatchEvent(new ShowEvent(ShowEvent.HEART_NOTIFY, param1));
            }
            return;
        }// end function

        public function RGetHeart(param1:Object) : void
        {
            return;
        }// end function

        public function RGetGiftList(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_2:* = param1.list;
            this._giftData = new Dictionary();
            this._classified = new Dictionary();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = new Object();
                _loc_4.name = _loc_3.name;
                _loc_4.type = _loc_3.type;
                _loc_4.list = [];
                _loc_5 = 0;
                while (_loc_5 < _loc_3.list.length)
                {
                    
                    _loc_6 = new PropItemInfo(_loc_3.list[_loc_5]);
                    if (_loc_6.packetOnly != 1)
                    {
                        _loc_4.list.push(_loc_6);
                    }
                    this._giftData[_loc_6.id] = _loc_6;
                    _loc_5++;
                }
                this._classified[_loc_3.type] = _loc_4;
            }
            if (param1.multi_gifting != null)
            {
                this._multiGiftingData = param1.multi_gifting;
                PropSegmentHelper.numSegmentX = [];
                _loc_7 = 0;
                while (_loc_7 < this.multiGiftingData.length)
                {
                    
                    PropSegmentHelper.numSegmentX.push(int(this.multiGiftingData[_loc_7].num));
                    this.multiGiftingData[_loc_7].label = this.multiGiftingData[_loc_7].des + "(" + this.multiGiftingData[_loc_7].num + ")";
                    this.multiGiftingData[_loc_7].value = this.multiGiftingData[_loc_7].num;
                    _loc_7++;
                }
                PropSegmentHelper.numSegmentX.sort(Array.NUMERIC);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_GIFT_LIST, param1));
            return;
        }// end function

        public function RGetGiftPacket(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._packetData = new Array();
            for each (_loc_2 in param1.list)
            {
                
                _loc_3 = new PropItemInfo(_loc_2);
                _loc_3.isInPacket = true;
                this._packetData.push(_loc_3);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_PACKET, param1));
            return;
        }// end function

        public function RSendGift(param1:Object) : void
        {
            if (param1.result == 0 && param1.buy == 0)
            {
                this.updatePacketData(param1.id, param1.num);
            }
            if (param1.result == 0)
            {
                this.updateCoinBalance(param1);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_SEND_GIFT_RESULT, param1));
            return;
        }// end function

        public function BGift(param1:Object) : void
        {
            DebugX.trace("----onGiftNotify----" + param1);
            if (!this._bWidgetInit)
            {
                return;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.GIFT_NOTIFY, param1));
            return;
        }// end function

        public function BSendGift(param1:Object) : void
        {
            if (!this._bWidgetInit)
            {
                return;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.GIFT_NOTIFY_NEW, param1));
            return;
        }// end function

        public function BBroadcast(param1:Object) : void
        {
            if (!this._bWidgetInit || param1 == null)
            {
                return;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_BROADCAST_NOTIFY, param1));
            return;
        }// end function

        public function showMagicFlash(param1:String, param2:String) : void
        {
            this.rc.protoApi.PShowMagicFlash(param1, param2);
            return;
        }// end function

        public function giftDealHeartChange() : void
        {
            var _loc_1:* = this._packetData[0];
            _loc_1.num = this.rc.myInfo.singerInfo.heart;
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_PACKET_CHANGE, _loc_1));
            return;
        }// end function

        private function updatePacketData(param1:int, param2:int, param3:Boolean = false) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = false;
            while (_loc_4 < this._packetData.length)
            {
                
                _loc_6 = this._packetData[_loc_4];
                if (_loc_6.id == param1)
                {
                    if (param3)
                    {
                        _loc_6.num = _loc_6.num + param2;
                    }
                    else
                    {
                        _loc_6.num = param2;
                    }
                    if (param2 == 0)
                    {
                        this._packetData.splice(_loc_4, 1);
                        this.dispatchEvent(new ShowEvent(ShowEvent.ON_DEL_PACKET_ITEM, _loc_6));
                    }
                    else
                    {
                        this.dispatchEvent(new ShowEvent(ShowEvent.ON_PACKET_CHANGE, _loc_6));
                    }
                    _loc_5 = true;
                    break;
                }
                _loc_4++;
            }
            if (!_loc_5)
            {
                if (!this.giftData.hasOwnProperty(param1) || param2 == 0)
                {
                    return;
                }
                _loc_7 = this.giftData[param1];
                _loc_8 = _loc_7.clone();
                _loc_8.canUse = 1;
                _loc_8.num = param2;
                _loc_8.isInPacket = true;
                this._packetData.push(_loc_8);
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_PACKET_ADD, _loc_8));
            }
            return;
        }// end function

        public function RGetChanGiftRecord(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_CHAN_RECORD, param1));
            return;
        }// end function

        public function BSpeaker(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_SPEAKER, param1));
            return;
        }// end function

        public function BMakeWish(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_MakeWish, param1));
            return;
        }// end function

        public function RSpeaker(param1:Object) : void
        {
            this.updateCoinBalance(param1);
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_SPEAKER, param1));
            return;
        }// end function

        public function RMakeWish(param1:Object) : void
        {
            this.updateCoinBalance(param1);
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_MakeWish, param1));
            return;
        }// end function

        public function RGetWish(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_GetWish, param1));
            return;
        }// end function

        public function RSpeakerInfo(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_SPEAKER_INFO, param1));
            return;
        }// end function

        public function BDrawLuckyDail(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_LUCKY_DRAW_DAILY, param1));
            return;
        }// end function

        public function RGetShowTool(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.bGetShowToolList = true;
            this._showToolList.splice(0, this._showToolList.length);
            for each (_loc_2 in param1.list)
            {
                
                _loc_3 = new PropItemInfo(_loc_2);
                if (_loc_3.type == PropType.SINGER_BACKGROUND)
                {
                    this.backImageList.push(_loc_3);
                }
                this._showToolList.push(_loc_3);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_SHOW_LIST));
            return;
        }// end function

        private function onShowToolGetChanAttr(param1:Object) : void
        {
            this.effectUrl = param1.effectUrl;
            this.effect = int(param1.effect);
            return;
        }// end function

        public function RGetToolPacket(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.bGetToolPacket = true;
            this._toolPacketList = new Array();
            for each (_loc_2 in param1.list)
            {
                
                _loc_3 = new PropItemInfo(_loc_2);
                _loc_3.isInPacket = true;
                this._toolPacketList.push(_loc_3);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_TOOLPACKET));
            return;
        }// end function

        public function RSetEffect(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (param1.result != 0)
            {
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_ERROR, param1));
                return;
            }
            this.updateCoinBalance(param1);
            if (param1.state == 2)
            {
                for (_loc_2 in this._toolStateList)
                {
                    
                    if (_loc_5[int(_loc_2)] == 2)
                    {
                        _loc_5[int(_loc_2)] = 1;
                        _loc_3 = this.getShowToolItemById(int(_loc_2));
                        if (_loc_3)
                        {
                            _loc_3.state = 1;
                        }
                    }
                }
            }
            _loc_5[param1.id] = param1.state;
            this.getShowToolItemById(param1.id).state = param1.state;
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_SET_EFFECT, param1));
            return;
        }// end function

        public function BEffect(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.list;
            for each (_loc_3 in _loc_2)
            {
                
                if (int(_loc_3.type) == PropType.STAGE_EFFECT)
                {
                    this.effectUrl = imageHost + _loc_3.resource;
                    this.effect = int(_loc_3.id);
                    continue;
                }
                if (int(_loc_3.type) == PropType.SINGER_BACKGROUND)
                {
                    this.backGroundUrl = imageHost + _loc_3.resource;
                    this.background = int(_loc_3.id);
                }
            }
            DebugX.out("on BEffect:", this.effectUrl, this.effect);
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_EFFECT, param1));
            return;
        }// end function

        public function RGetToolState(param1:Object) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            UtilTool.clearDictionary(this._toolStateList);
            var _loc_2:* = param1.list;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_4];
                this._toolStateList[_loc_5.id] = _loc_5.state;
                if (_loc_5.state == 2)
                {
                    _loc_3 = _loc_5.id;
                }
                _loc_6 = this.getShowToolItemById(_loc_5.id);
                if (_loc_6)
                {
                    _loc_6.state = _loc_5.state;
                }
                _loc_4++;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_GET_TOOL_STATE, param1));
            return;
        }// end function

        public function getShowToolItemById(param1:uint) : PropItemInfo
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._showToolList)
            {
                
                if (_loc_2.id == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

        public function changeVoiceNormal() : void
        {
            this.rc.protoApi.PChangeVoiceEffect(0);
            return;
        }// end function

        public function setBg(param1:int, param2:int) : void
        {
            this.protoApi.PSetEffect(PropType.SINGER_BACKGROUND, param1, param2);
            return;
        }// end function

        public function set effect(param1:uint) : void
        {
            if (this._effect != param1)
            {
                this._effect = param1;
                DebugX.out("set effect:", this._effect);
                this.dispatchEvent(new ShowEvent(ShowEvent.EFFECT_CHANGE));
            }
            return;
        }// end function

        public function get effect() : uint
        {
            return this._effect;
        }// end function

        public function get background() : uint
        {
            return this._background;
        }// end function

        public function set background(param1:uint) : void
        {
            if (this._background != param1)
            {
                this._background = param1;
                this.dispatchEvent(new ShowEvent(ShowEvent.BACKGROUND_CHANGE));
            }
            return;
        }// end function

        public function get toolStateList() : Dictionary
        {
            return this._toolStateList;
        }// end function

        public function get effectUrl() : String
        {
            return this._effectUrl;
        }// end function

        public function set effectUrl(param1:String) : void
        {
            this._effectUrl = param1;
            return;
        }// end function

        public function get backGroundUrl() : String
        {
            return this._backGroundUrl;
        }// end function

        public function set backGroundUrl(param1:String) : void
        {
            this._backGroundUrl = param1;
            return;
        }// end function

        private function luckDrawInit() : void
        {
            return;
        }// end function

        public function RGetEggInfo(param1:Object) : void
        {
            this._eggInfoArr = param1.eggs as Array;
            this._refreshTime = param1.refreshDuration;
            this._refreshCost = param1.refreshCost;
            this.dispatchEvent(new BlockEggEvent(BlockEggEvent.INIT_EGG));
            return;
        }// end function

        public function BSmashEgg(param1:Object) : void
        {
            this.dispatchEvent(new BlockEggEvent(BlockEggEvent.EGG_NOTIFY, param1));
            return;
        }// end function

        public function RSmashEgg(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.result;
            if (_loc_2 == 0)
            {
                this.updateCoinBalance(param1);
                if (param1.gift != 0)
                {
                    this.updatePacketData(param1.gift, param1.amount, true);
                }
                _loc_3 = {value:param1.value, count:param1.amount};
                this.dispatchEvent(new BlockEggEvent(BlockEggEvent.BLOCK_EGG_RESULT, param1));
            }
            else
            {
                this.dispatchEvent(new BlockEggEvent(BlockEggEvent.BLOCK_EGG_ERROR, _loc_2));
            }
            return;
        }// end function

        public function RRefreshEgg(param1:Object) : void
        {
            DebugX.trace("REFRESH_EGG_ERROR1" + param1);
            var _loc_2:* = param1.result;
            if (_loc_2 == 0)
            {
                this.updateCoinBalance(param1);
                this.dispatchEvent(new BlockEggEvent(BlockEggEvent.REFRESH_EGG_RESULT, param1));
            }
            else
            {
                DebugX.trace("REFRESH_EGG_ERROR" + _loc_2);
                this.dispatchEvent(new BlockEggEvent(BlockEggEvent.REFRESH_EGG_ERROR, _loc_2));
            }
            return;
        }// end function

        public function get eggInfoArr() : Array
        {
            return this._eggInfoArr;
        }// end function

        public function get refreshTime() : Number
        {
            return this._refreshTime;
        }// end function

        public function get refreshCost() : Number
        {
            return this._refreshCost;
        }// end function

        public function BGiftBox(param1:Object) : void
        {
            this.dispatchEvent(new KnockBoxEvent(KnockBoxEvent.EXPLODE_BOX, param1));
            return;
        }// end function

        public function RGetGiftBox(param1) : void
        {
            this.dispatchEvent(new KnockBoxEvent(KnockBoxEvent.BOX_INTI_COMPLETE));
            return;
        }// end function

        public function ROpenGiftBox(param1:Object) : void
        {
            var _loc_2:* = param1.gift;
            var _loc_3:* = param1.amount;
            if (_loc_2 > 0 && _loc_3 > 0)
            {
                this.updatePacketData(_loc_2, _loc_3, true);
            }
            this.dispatchEvent(new KnockBoxEvent(KnockBoxEvent.OPEN_GIFT_BOX_RESULT, param1));
            return;
        }// end function

        public function BActivityRankChange(param1:Object) : void
        {
            var _loc_2:* = new FsRankingChangeInfo(param1);
            if (_loc_2.singerUid == this.rc.singer.singerInfo.uid)
            {
                _loc_2.member = this.rc.singer.singerInfo.member;
                if (_loc_2.type == 0)
                {
                    this.rc.singer.singerInfo.voteRank = _loc_2.rank;
                }
                if (_loc_2.type == 1)
                {
                    this.rc.singer.singerInfo.giftRank = _loc_2.rank;
                }
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_FS_RANKING_CHANGE, _loc_2));
            }
            return;
        }// end function

        public function RLuckyShake(param1:Object) : void
        {
            if (int(param1.result) == 0)
            {
                DebugX.print("RLuckyShake:" + param1.num);
                this.updateCoinBalance(param1.num, true);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_SHARK, param1));
            return;
        }// end function

        public function BLuckyShake(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_LUCKY_SHAKE, param1));
            return;
        }// end function

        public function RGetActivityDailyPacket(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_ACTIVE_DAY_PACKET, param1));
            return;
        }// end function

        public function RBuyActivityGiftPacket(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.updateCoinBalance(param1);
                this.updatePacketData(param1.giftId, param1.giftNum, true);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_BUY_ACTIVE_GIFT, param1));
            return;
        }// end function

        public function RFollowSinger(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_FOLLOW, param1));
            return;
        }// end function

        public function RUnfollowSinger(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_UN_FOLLOW, param1));
            return;
        }// end function

        public function RCallFans(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_CALL_FANS, param1));
            return;
        }// end function

        public function RIsFollow(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_IS_FOLLOW, param1));
            return;
        }// end function

        public function RCanCallFans(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_CAN_CALL_FANS, param1));
            return;
        }// end function

        public function BFollowSinger(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_B_FOLLOW_SINGER, param1));
            return;
        }// end function

        public function RGetVideoSinger(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_VIDEO_SINGER, param1));
            return;
        }// end function

        public function RGetTaskInfo(param1:Object) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1.result != 0)
            {
                return;
            }
            var _loc_2:* = param1.info;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_4 = _loc_2[_loc_3];
                _loc_5 = this.giftData[_loc_4.giftId];
                DebugX.print("RGetTaskInfo url", _loc_4.id, _loc_5);
                if (_loc_5)
                {
                    _loc_4.url = _loc_5.resource;
                    _loc_4.des = _loc_5.des;
                    DebugX.print("RGetTaskInfo url", _loc_4.url);
                }
                _loc_3++;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.on_R_TASK_IFNO, param1));
            return;
        }// end function

        public function RGetTaskReward(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.rc.singer.singerInfo.experience = this.rc.singer.singerInfo.experience + param1.reward;
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_TASK_REWARD, param1));
            }
            return;
        }// end function

        public function RCheckShowCardSpeaker(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_CHECK_CARD_SPEAKER, param1));
            }
            return;
        }// end function

        public function RGetRankInfo(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_GIFT_RANKING, param1));
            return;
        }// end function

        public function RGetGuardApplyInfo(param1:Object) : void
        {
            DebugX.trace("RGetGuardApplyInfo---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.R_GET_GUARD_APPLY_INFO, param1));
            return;
        }// end function

        public function RGetSingerGuard(param1:Object) : void
        {
            DebugX.trace("RGetSingerGuard---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.R_GET_SINGER_GUARD, param1));
            return;
        }// end function

        public function RGetGuardApplyList(param1:Object) : void
        {
            this._guardInfo.updateData(param1);
            DebugX.trace("RGetGuardApplyList---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.GET_GUARD_APPLY_LIST, param1));
            return;
        }// end function

        public function RApplySingerGuard(param1:Object) : void
        {
            DebugX.trace("RApplySingerGuard---------" + JSON.stringify(param1));
            this.updateCoinBalance(param1);
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.RAPPLY_SINGER_GUARD, param1));
            return;
        }// end function

        public function RAcceptGuardApply(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this._guardInfo.updateGuardState(param1.id);
                DebugX.trace("RAcceptGuardApply---------" + JSON.stringify(param1));
            }
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.RACCEPT_GUARD_APPLY, param1));
            return;
        }// end function

        public function get guardInfo() : GuardInfo
        {
            return this._guardInfo;
        }// end function

        public function BAcceptGuardApply(param1:Object) : void
        {
            DebugX.trace("BAcceptGuardApply---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.BACCEPT_GUARD_APPLY, param1));
            return;
        }// end function

        public function BApplySingerGuard(param1:Object) : void
        {
            DebugX.trace("BAcceptGuardApply---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.BAPPLY_GUARD_FOR, param1));
            return;
        }// end function

        public function BEnterChannel(param1:Object) : void
        {
            DebugX.trace("BEnterChannel---------" + JSON.stringify(param1));
            this.dispatchEvent(new GuardApplyEvent(GuardApplyEvent.ENTER_CHANNEL, param1));
            return;
        }// end function

        public function RGetLuckyDail(param1:Object) : void
        {
            this.dispatchEvent(new ZpEvent(ZpEvent.GET_ZP_INFO, param1));
            return;
        }// end function

        public function RDrawLuckyDail(param1:Object) : void
        {
            if (param1.packet)
            {
                this.updatePacketData(param1.packet.id, param1.packet.num, true);
            }
            this.dispatchEvent(new ZpEvent(ZpEvent.G_ZP_RESULT, param1));
            return;
        }// end function

        public function RGetLuckySinger(param1:Object) : void
        {
            this.dispatchEvent(new ZpEvent(ZpEvent.G_SINGER_RESULT, param1));
            return;
        }// end function

        public function RGetChip(param1:Object) : void
        {
            this.dispatchEvent(new ZqEvent(ZqEvent.GET_CHIP_INFO, param1));
            return;
        }// end function

        public function RMergeChip(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            if (param1.result == 0)
            {
                _loc_2 = param1.giftList;
                _loc_3 = 0;
                while (_loc_3 < _loc_2.length)
                {
                    
                    this.updatePacketData(_loc_2[_loc_3].id, _loc_2[_loc_3].num);
                    _loc_3++;
                }
                _loc_4 = param1.chipList;
                _loc_5 = 0;
                while (_loc_5 < _loc_4.length)
                {
                    
                    this.updatePacketData(_loc_4[_loc_5].id, _loc_4[_loc_5].num);
                    _loc_5++;
                }
                this.updateCoinBalance(param1);
            }
            this.dispatchEvent(new ZqEvent(ZqEvent.GET_MERGE_CHIP, param1));
            return;
        }// end function

        public function RGetAds(param1:Object) : void
        {
            this._adsInfo.updateData(param1);
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_ADS));
            return;
        }// end function

        public function get adsInfo() : AdsInfo
        {
            return this._adsInfo;
        }// end function

        public function RFcGetChess(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_GET_CHESS, param1));
            return;
        }// end function

        public function RFcBuyGamePoint(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_FC_BUY_POINT, param1));
            return;
        }// end function

        public function RFcThrowDice(param1:Object) : void
        {
            DebugX.print("RFcThrowDice:" + JSON.stringify(param1));
            if (param1.result == 0 && param1.info.hasOwnProperty("boxGiftId"))
            {
                DebugX.print("RFcThrowDice:" + param1.info.boxGiftId, param1.info.boxGiftAmount);
                this.updatePacketData(param1.info.boxGiftId, param1.info.boxGiftAmount, true);
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_FC_THROW_DICE, param1));
            return;
        }// end function

        public function RGetDailyPacket(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (param1.result == 0)
            {
                _loc_2 = param1.list;
                for each (_loc_4 in _loc_2)
                {
                    
                    this.updatePacketData(_loc_4.giftId, _loc_4.giftNum, true);
                    _loc_3 = _loc_3 + _loc_4.giftNum;
                }
                param1.num = _loc_3;
            }
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_GET_DAY_PACKET, param1));
            return;
        }// end function

        public function RGetActivityInfo(param1:Object) : void
        {
            this.dispatchEvent(new ShowEvent(ShowEvent.ON_R_FS_INFO, param1));
            return;
        }// end function

        public function RGetDailyShowCardGift(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.updatePacketData(param1.id, param1.giftAmount, true);
            }
            this.dispatchEvent(new ShowCardEvent(ShowCardEvent.GET_GIFT, param1));
            return;
        }// end function

        public function RBuyShowCard(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.updateCoinBalance(param1);
            }
            this.dispatchEvent(new ShowCardEvent(ShowCardEvent.BUY_SHOWCARD, param1));
            return;
        }// end function

        public function RGetActivityHourlyPacket(param1:Object) : void
        {
            this.dispatchEvent(new OctopusEvent(OctopusEvent.GET_ACTIVITY_HOURLY_PACKET, param1));
            return;
        }// end function

        public function RStartGame(param1:Object) : void
        {
            this.dispatchEvent(new OctopusEvent(OctopusEvent.FORCE_GAME_START, param1));
            return;
        }// end function

        public function RGameJoinApply(param1:Object) : void
        {
            this.dispatchEvent(new OctopusEvent(OctopusEvent.JOIN_OCTOPUS_GAME, param1));
            return;
        }// end function

        public function RSendGameStatus(param1:Object) : void
        {
            if (param1.hasOwnProperty("giftId") && param1.hasOwnProperty("giftQty"))
            {
                this.updatePacketData(param1.giftId, param1.giftQty, true);
            }
            this.dispatchEvent(new OctopusEvent(OctopusEvent.SEND_GAME_RESULT, param1));
            return;
        }// end function

        public function RGetFaceBookInfo(param1:Object) : void
        {
            if (param1.result == 0)
            {
                this.rc.myInfo.fbToken = param1.fbToken;
            }
            this.dispatchEvent(new OctopusEvent(OctopusEvent.GET_FB_TOKEN, param1));
            return;
        }// end function

        public function BStartGame(param1:Object) : void
        {
            this.dispatchEvent(new OctopusEvent(OctopusEvent.B_START_OCTOPUS_GAME, param1));
            return;
        }// end function

        public function get giftData() : Dictionary
        {
            return this._giftData;
        }// end function

        public function get classified() : Dictionary
        {
            return this._classified;
        }// end function

        public function get packetData() : Array
        {
            return this._packetData;
        }// end function

        public function get showToolList() : Array
        {
            return this._showToolList;
        }// end function

        public function get toolPacketList() : Array
        {
            return this._toolPacketList;
        }// end function

        public function get multiGiftingData() : Array
        {
            return this._multiGiftingData;
        }// end function

        public function get state() : int
        {
            return this._state;
        }// end function

        public function get protoApi() : IShowProtoApi
        {
            return this._protoApi;
        }// end function

        public function get errorMessage() : String
        {
            return this._errorMessage;
        }// end function

        public function set errorMessage(param1:String) : void
        {
            this._errorMessage = param1;
            return;
        }// end function

        public function get voiceChangeTime() : int
        {
            return this.VOICE_CHANGE_TIME;
        }// end function

        public function get bWidgetInit() : Boolean
        {
            return this._bWidgetInit;
        }// end function

    }
}
