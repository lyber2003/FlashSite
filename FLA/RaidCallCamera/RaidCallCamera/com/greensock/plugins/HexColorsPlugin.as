package com.greensock.plugins
{
    import com.greensock.*;

    public class HexColorsPlugin extends TweenPlugin
    {
        protected var _colors:Array;
        public static const API:Number = 2;

        public function HexColorsPlugin()
        {
            super("hexColors");
            _overwriteProps = [];
            _colors = [];
            return;
        }// end function

        public function _initColor(param1:Object, param2:String, param3:uint) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_4:* = typeof(param1[param2]) == "function";
            var _loc_5:* = typeof(param1[param2]) != "function" ? (param1[param2]) : (var _loc_9:* = param1, _loc_9[param2.indexOf("set") || !("get" + param2.substr(3) in param1) ? (param2) : ("get" + param2.substr(3))]());
            if ((typeof(param1[param2]) != "function" ? (param1[param2]) : (var _loc_9:* = param1, _loc_9[param2.indexOf("set") || !("get" + param2.substr(3) in param1) ? (param2) : ("get" + param2.substr(3))]())) != param3)
            {
                _loc_6 = _loc_5 >> 16;
                _loc_7 = _loc_5 >> 8 & 255;
                _loc_8 = _loc_5 & 255;
                _colors[_colors.length] = new ColorProp(param1, param2, _loc_4, _loc_6, (param3 >> 16) - _loc_6, _loc_7, (param3 >> 8 & 255) - _loc_7, _loc_8, (param3 & 255) - _loc_8);
                _overwriteProps[_overwriteProps.length] = param2;
            }
            return;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = NaN;
            var _loc_2:* = _colors.length;
            while (--_loc_2 > -1)
            {
                
                _loc_3 = _colors[_loc_2];
                _loc_4 = _loc_3.rs + param1 * _loc_3.rc << 16 | _loc_3.gs + param1 * _loc_3.gc << 8 | _loc_3.bs + param1 * _loc_3.bc;
                if (_loc_3.f)
                {
                    var _loc_5:* = _loc_3.t;
                    _loc_5[_loc_3.p](_loc_4);
                    continue;
                }
                _loc_5[_loc_3.p] = _loc_4;
            }
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_4:* = null;
            for (_loc_4 in param2)
            {
                
                _initColor(param1, _loc_4, uint(_loc_6[_loc_4]));
            }
            return true;
        }// end function

        override public function _kill(param1:Object) : Boolean
        {
            var _loc_2:* = _colors.length;
            while (_loc_2--)
            {
                
                if (param1[_colors[_loc_2].p] != null)
                {
                    _colors.splice(_loc_2, 1);
                }
            }
            return super._kill(param1);
        }// end function

    }
}

import com.greensock.*;

class ColorProp extends Object
{
    public var rs:int;
    public var f:Boolean;
    public var gs:int;
    public var p:String;
    public var rc:int;
    public var t:Object;
    public var bc:int;
    public var gc:int;
    public var bs:int;

    function ColorProp(param1:Object, param2:String, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int)
    {
        this.t = param1;
        this.p = param2;
        this.f = param3;
        this.rs = param4;
        this.rc = param5;
        this.gs = param6;
        this.gc = param7;
        this.bs = param8;
        this.bc = param9;
        return;
    }// end function

}

