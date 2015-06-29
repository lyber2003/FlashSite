package rcbiz.widget
{
    import flash.events.*;
    import flash.utils.*;
    import rcbiz.events.*;
    import rcbiz.interfaces.*;
    import rcbiz.interfaces.proto.*;
    import rcbiz.widget.proto.*;

    public class FlowerWidget extends WidgetBase implements IFlowerProtoCB, IFlowerWidget
    {
        private var ready:Boolean = false;
        private var _flowerTime:int;
        private var _maxFlower:int;
        private var _remainTime:int = 150;
        private var _myFlowerNum:int;
        private var flowerTimer:Timer;
        private var checkTimer:Timer;
        public var _protoApi:IFlowerProtoApi;
        public static const ID:int = 2;

        public function FlowerWidget(param1:IClientWidget)
        {
            this._protoApi = new FloweProtorApi(param1.protoApi, ID);
            super(param1);
            param1.registerWidgetListner(ID, this);
            this.flowerTimer = new Timer(1000, 0);
            this.flowerTimer.addEventListener(TimerEvent.TIMER, this.onFlowerTimer);
            this.checkTimer = new Timer(2000, 4);
            this.checkTimer.addEventListener(TimerEvent.TIMER, this.onCheckTimer);
            return;
        }// end function

        private function onCheckTimer(event:TimerEvent) : void
        {
            if (!this.ready)
            {
                this._protoApi.PHandshake();
            }
            return;
        }// end function

        public function initialize() : void
        {
            this.checkTimer.start();
            this._protoApi.PHandshake();
            return;
        }// end function

        public function sendFlower() : void
        {
            var _loc_1:* = new Object();
            _loc_1.number = 1;
            _loc_1.presenttype = 1;
            _loc_1.uid = rc.singer.uid;
            _loc_1.cid = rc.channel.cid;
            _loc_1.qid = rc.group.sid;
            this._protoApi.PSendFlower(_loc_1);
            return;
        }// end function

        private function getMyFlowers() : void
        {
            this._protoApi.PGetFlowers({uid:rc.myInfo.uid, cid:rc.channel.cid, qid:rc.group.sid});
            return;
        }// end function

        private function onFlowerTimer(event:TimerEvent) : void
        {
            (this._remainTime - 1);
            if (this._remainTime < 0 && this._myFlowerNum < this._maxFlower)
            {
                this._remainTime = this._flowerTime;
                this.getMyFlowers();
            }
            return;
        }// end function

        public function RHandshake(param1:Object) : void
        {
            if (int(param1.state) == 0)
            {
                this._flowerTime = int(param1.timer);
                this._maxFlower = int(param1.maxflower);
                this.getMyFlowers();
                this.flowerTimer.start();
                this.ready = true;
                this.checkTimer.stop();
                dispatchEvent(new FlowerEvent(FlowerEvent.FLOWER_WIDGET_INITED, param1));
            }
            return;
        }// end function

        public function RGetFlowers(param1:Object) : void
        {
            this._myFlowerNum = int(param1.number);
            this._remainTime = int(param1.remain_second);
            return;
        }// end function

        public function RSpeakerNotify(param1:Object) : void
        {
            if (!this.ready)
            {
                return;
            }
            if (param1.uid == rc.singer.uid)
            {
                rc.singer.singerInfo.totalFlower = param1.total;
                rc.singer.singerInfo.curFlower = param1.number;
                dispatchEvent(new FlowerEvent(FlowerEvent.SINGER_FLOWER_CHANGE, param1));
            }
            return;
        }// end function

        public function RSendFlower(param1:Object) : void
        {
            this.getMyFlowers();
            dispatchEvent(new FlowerEvent(FlowerEvent.SEND_FLOWER_RESULT, param1));
            return;
        }// end function

        public function RFlowerNotify(param1:Object) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            if (!this.ready)
            {
                return;
            }
            if (param1.notifyinfo != null)
            {
                _loc_2 = param1.notifyinfo;
                _loc_3 = param1.receiver;
                for each (_loc_4 in _loc_2)
                {
                    
                    dispatchEvent(new FlowerEvent(FlowerEvent.FLOWER_NOTIFY, _loc_4));
                }
            }
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

        public function get maxFlower() : int
        {
            return this._maxFlower;
        }// end function

        public function get flowerTime() : int
        {
            return this._flowerTime;
        }// end function

        public function get myFlowerNum() : int
        {
            return this._myFlowerNum;
        }// end function

        public function get remainTime() : int
        {
            return this._remainTime;
        }// end function

        public function get protoApi() : IFlowerProtoApi
        {
            return this._protoApi;
        }// end function

    }
}
