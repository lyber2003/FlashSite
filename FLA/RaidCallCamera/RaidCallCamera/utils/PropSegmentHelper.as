package utils
{
    import flash.display.*;
    import rcbiz.model.*;

    public class PropSegmentHelper extends Object
    {
        public var priceSeg:int;
        public var timeSeg:int;
        public var shapeData:BitmapData;
        public var numSeg:int;
        public var name:String;
        private static var timeSegment:Array = [3, 4, 5, 6, 7, 8, 9, 11, 13, 15];
        private static var totlePriceSegment:Array = [100, 500, 660, 1880, 3760, 7220, 10040, 15540, 33400, 49950];
        private static var priceSegment:Array = [1, 10, 50];
        public static var numSegmentX:Array = [10, 30, 66, 188, 360, 505, 520, 777, 999, 1314, 3344];

        public function PropSegmentHelper(param1:int, param2:int, param3:int, param4:String)
        {
            this.numSeg = param1;
            this.priceSeg = param2;
            this.timeSeg = param3;
            this.name = param4;
            return;
        }// end function

        public static function getSegment(param1:PropItemInfo) : PropSegmentHelper
        {
            var _loc_2:* = param1.num;
            var _loc_3:* = -1;
            var _loc_4:* = 0;
            while (_loc_4 < numSegmentX.length)
            {
                
                if (_loc_2 < numSegmentX[_loc_4])
                {
                    break;
                }
                else
                {
                    _loc_3 = _loc_4;
                }
                _loc_4++;
            }
            var _loc_5:* = 0;
            if (param1.price > 1)
            {
                _loc_5 = 2;
            }
            var _loc_6:* = 3;
            var _loc_7:* = param1.price * param1.num;
            var _loc_8:* = 0;
            while (_loc_8 < totlePriceSegment.length)
            {
                
                if (_loc_7 < totlePriceSegment[_loc_8])
                {
                    break;
                }
                else
                {
                    _loc_6 = timeSegment[_loc_8];
                }
                _loc_8++;
            }
            return new PropSegmentHelper(_loc_3, _loc_5, _loc_6, param1.name);
        }// end function

    }
}
