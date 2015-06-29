package rcbiz.model
{
    import rcbiz.widget.*;

    public class PropItemInfo extends Object
    {
        public var imageUrl:String;
        public var bigSwf:String;
        public var smallSwf:String;
        public var resource:String;
        public var des:String;
        public var money:int;
        public var type:int;
        public var id:int;
        public var canUse:int;
        public var isInPacket:Boolean = false;
        public var num:int;
        public var paymentType:int;
        public var price:int;
        public var name:String;
        public var multi_gifting:Array;
        public var consumeType:int;
        public var state:int;
        public var bBackground:Boolean = false;
        public var packetOnly:int;
        public var preview:String = "";

        public function PropItemInfo(param1:Object = null)
        {
            var _loc_2:* = null;
            this.multi_gifting = [];
            if (param1)
            {
                for (_loc_2 in param1)
                {
                    
                    if (this.hasOwnProperty(_loc_2))
                    {
                        this[_loc_2] = _loc_4[_loc_2];
                    }
                }
            }
            this.imageUrl = ShowWidget.imageHost + this.imageUrl;
            this.resource = ShowWidget.imageHost + this.resource;
            this.bBackground = this.type == PropType.SINGER_BACKGROUND;
            return;
        }// end function

        public function clone() : PropItemInfo
        {
            var _loc_1:* = new PropItemInfo();
            _loc_1.imageUrl = this.imageUrl;
            _loc_1.bigSwf = this.bigSwf;
            _loc_1.canUse = this.canUse;
            _loc_1.des = this.des;
            _loc_1.id = this.id;
            _loc_1.isInPacket = _loc_1.isInPacket;
            _loc_1.money = this.money;
            _loc_1.multi_gifting = this.multi_gifting;
            _loc_1.name = this.name;
            _loc_1.num = this.num;
            _loc_1.paymentType = this.paymentType;
            _loc_1.price = this.price;
            _loc_1.resource = this.resource;
            _loc_1.smallSwf = this.smallSwf;
            _loc_1.type = this.type;
            _loc_1.bBackground = this.bBackground;
            _loc_1.packetOnly = this.packetOnly;
            return _loc_1;
        }// end function

    }
}
