package com.greensock.easing
{

    final public class BackInOut extends Ease
    {
        public static var ease:BackInOut = new BackInOut;

        public function BackInOut(param1:Number = 1.70158)
        {
            _p1 = param1;
            _p2 = _p1 * 1.525;
            return;
        }// end function

        public function config(param1:Number = 1.70158) : BackInOut
        {
            return new BackInOut(param1);
        }// end function

        override public function getRatio(param1:Number) : Number
        {
            var _loc_2:* = param1 * 2;
            param1 = param1 * 2;
            return _loc_2 < 1 ? (0.5 * param1 * param1 * ((_p2 + 1) * param1 - _p2)) : (var _loc_2:* = param1 - 2, param1 = param1 - 2, 0.5 * (_loc_2 * param1 * ((_p2 + 1) * param1 + _p2) + 2));
        }// end function

    }
}
