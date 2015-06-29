package com.greensock.plugins
{
    import com.greensock.*;

    public class EndArrayPlugin extends TweenPlugin
    {
        protected var _a:Array;
        protected var _info:Array;
        protected var _round:Boolean;
        public static const API:Number = 2;

        public function EndArrayPlugin()
        {
            _info = [];
            super("endArray");
            return;
        }// end function

        override public function _roundProps(param1:Object, param2:Boolean = true) : void
        {
            if ("endArray" in param1)
            {
                _round = param2;
            }
            return;
        }// end function

        public function _init(param1:Array, param2:Array) : void
        {
            _a = param1;
            var _loc_3:* = param2.length;
            var _loc_4:* = 0;
            while (--_loc_3 > -1)
            {
                
                if (param1[_loc_3] != param2[_loc_3] && param1[_loc_3] != null)
                {
                    _info[++_loc_4] = new ArrayTweenInfo(_loc_3, _a[_loc_3], param2[_loc_3] - _a[_loc_3]);
                }
            }
            return;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_2:* = _info.length;
            if (_round)
            {
                while (--_loc_2 > -1)
                {
                    
                    _loc_3 = _info[_loc_2];
                    var _loc_5:* = _loc_3.c * param1 + _loc_3.s;
                    _loc_4 = _loc_3.c * param1 + _loc_3.s;
                    _a[_loc_3.i] = _loc_5 > 0 ? (_loc_4 + 0.5 >> 0) : (_loc_4 - 0.5 >> 0);
                }
            }
            else
            {
                while (--_loc_2 > -1)
                {
                    
                    _loc_3 = _info[--_loc_2];
                    _a[_loc_3.i] = _loc_3.c * param1 + _loc_3.s;
                }
            }
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            if (!(param1 is Array) || !(param2 is Array))
            {
                return false;
            }
            _init(param1 as Array, param2);
            return true;
        }// end function

    }
}

import com.greensock.*;

class ArrayTweenInfo extends Object
{
    public var s:Number;
    public var i:uint;
    public var c:Number;

    function ArrayTweenInfo(param1:uint, param2:Number, param3:Number)
    {
        this.i = param1;
        this.s = param2;
        this.c = param3;
        return;
    }// end function

}

