package com.greensock.easing
{

    final public class BackIn extends Ease
    {
        public static var ease:BackIn = new BackIn;

        public function BackIn(param1:Number = 1.70158)
        {
            _p1 = param1;
            return;
        }// end function

        public function config(param1:Number = 1.70158) : BackIn
        {
            return new BackIn(param1);
        }// end function

        override public function getRatio(param1:Number) : Number
        {
            return param1 * param1 * ((_p1 + 1) * param1 - _p1);
        }// end function

    }
}
