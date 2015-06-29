package com.greensock.plugins
{
    import com.greensock.*;

    public class ShortRotationPlugin extends TweenPlugin
    {
        public static const API:Number = 2;

        public function ShortRotationPlugin()
        {
            super("shortRotation");
            _overwriteProps.pop();
            return;
        }// end function

        public function _initRotation(param1:Object, param2:String, param3:Number, param4:Number, param5:Boolean = false) : void
        {
            var _loc_6:* = param5 ? (Math.PI * 2) : (360);
            var _loc_7:* = (param4 - param3) % _loc_6;
            if ((param4 - param3) % _loc_6 != (param4 - param3) % _loc_6 % (_loc_6 / 2))
            {
                _loc_7 = _loc_7 < 0 ? (_loc_7 + _loc_6) : (_loc_7 - _loc_6);
            }
            _addTween(param1, param2, param3, param3 + _loc_7, param2);
            _overwriteProps[_overwriteProps.length] = param2;
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            if (typeof(param2) == "number")
            {
                return false;
            }
            var _loc_4:* = Boolean(param2.useRadians == true);
            for (_loc_6 in param2)
            {
                
                if (_loc_6 != "useRadians")
                {
                    _loc_5 = param1[_loc_6] is Function ? (var _loc_9:* = param1, _loc_9[_loc_6.indexOf("set") || !("get" + _loc_6.substr(3) in param1) ? (_loc_6) : ("get" + _loc_6.substr(3))]()) : (_loc_9[_loc_6]);
                    _initRotation(param1, _loc_6, _loc_5, typeof(_loc_8[_loc_6]) == "number" ? (Number(_loc_8[_loc_6])) : (_loc_5 + Number(_loc_8[_loc_6].split("=").join(""))), _loc_4);
                }
            }
            return true;
        }// end function

    }
}
