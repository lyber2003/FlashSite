package rcbiz.model.client
{

    public class Singer extends Object
    {
        public var uid:int = 0;
        public var totalFlower:int;
        public var curFlower:int;
        public var heart:int;
        public var heartPerMonth:int;
        public var numHeartConvert:int;
        public var hour:int;
        public var homePageUrl:String = "";
        public var faceBookUrl:String = "";
        public var charm:int;
        public var coinBalance:int;
        public var pointBalance:int;
        public var nobleLevel:int;
        public var singerLevel:int;
        public var titleLevel:int;
        public var singerTitle:String;
        public var experience:int;
        public var experienceLevelUp:int;
        public var currentLevelExperience:int;
        public var images:Array;
        public var ranking:Array;
        public var activity:Object;
        public var background:int;
        public var effect:int;
        public var eggs:Array;
        public var received_coins:Number;
        public var member:int;
        public var rank:int;
        public var sex:int;
        public var isActive:int;
        public var voteRank:int;
        public var giftRank:int;
        public var bUpdateSinger:Boolean = false;
        public var follows:Array;
        public var auth:int;
        public var lastTimeReadNotice:int;
        public var luckyShakeCount:int;
        public var vip:int;
        public var vipLeftTime:int;

        public function Singer()
        {
            this.images = [];
            this.ranking = [];
            this.follows = [];
            return;
        }// end function

    }
}
