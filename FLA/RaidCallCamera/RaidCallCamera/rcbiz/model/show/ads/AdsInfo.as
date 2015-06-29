package rcbiz.model.show.ads
{
    import com.debug.*;

    public class AdsInfo extends Object
    {
        public var itemArray:Array;
        public var currentId:int = 0;
        public var bShowAds:Boolean = false;

        public function AdsInfo()
        {
            this.itemArray = [];
            return;
        }// end function

        public function updateData(param1:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            DebugX.trace("收到了广告数：：：：" + JSON.stringify(param1));
            this.itemArray.splice(0, this.itemArray.length);
            var _loc_2:* = param1.info;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_4 = new AdsItem();
                _loc_4.startTime = _loc_3.start;
                _loc_4.endTime = _loc_3.end;
                _loc_4.rid = _loc_3.fid;
                _loc_4.iconURL = _loc_3.icon;
                _loc_4.desURL = _loc_3.icon_text;
                _loc_4.authUrl = _loc_3.link;
                _loc_4.notAuth = _loc_3.notAuth;
                if (this.isDuring(_loc_4.startTime, _loc_4.endTime))
                {
                    this.itemArray.push(_loc_4);
                    this.bShowAds = true;
                }
            }
            this.currentId = Math.random() * this.itemArray.length;
            return;
        }// end function

        public function goToNext() : void
        {
            if (this.itemArray.length > 0)
            {
                var _loc_1:* = this;
                var _loc_2:* = this.currentId + 1;
                _loc_1.currentId = _loc_2;
                this.currentId = this.currentId % this.itemArray.length;
            }
            return;
        }// end function

        public function getCurrentItem() : AdsItem
        {
            if (this.currentId >= this.itemArray.length)
            {
                return null;
            }
            return this.itemArray[this.currentId];
        }// end function

        private function isDuring(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = new Date();
            var _loc_4:* = _loc_3.time / 1000;
            DebugX.trace("广告时间----" + _loc_4);
            if (_loc_4 >= param1 && _loc_4 <= param2)
            {
                DebugX.trace("广告时间----" + param1 + "-----" + _loc_4 + "------");
                return true;
            }
            return false;
        }// end function

    }
}
