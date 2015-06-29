package com.greensock.plugins
{
    import com.greensock.*;
    import com.greensock.core.*;

    public class TweenPlugin extends Object
    {
        public var _priority:int = 0;
        public var _overwriteProps:Array;
        public var _propName:String;
        protected var _firstPT:PropTween;
        public static const version:String = "12.0.0";
        public static const API:Number = 2;

        public function TweenPlugin(param1:String = "", param2:int = 0)
        {
            _overwriteProps = param1.split(",");
            _propName = _overwriteProps[0];
            _priority = param2 || 0;
            return;
        }// end function

        public function _roundProps(param1:Object, param2:Boolean = true) : void
        {
            var _loc_3:* = _firstPT;
            while (_loc_3)
            {
                
                if (_propName in param1 || _loc_3.n != null && _loc_3.n.split(_propName + "_").join("") in param1)
                {
                    _loc_3.r = param2;
                }
                _loc_3 = _loc_3._next;
            }
            return;
        }// end function

        public function setRatio(param1:Number) : void
        {
            var _loc_3:* = NaN;
            var _loc_2:* = _firstPT;
            while (_loc_2)
            {
                
                _loc_3 = _loc_2.c * param1 + _loc_2.s;
                if (_loc_2.r)
                {
                    _loc_3 = _loc_3 > 0 ? (_loc_3 + 0.5 >> 0) : (_loc_3 - 0.5 >> 0);
                }
                if (_loc_2.f)
                {
                    var _loc_4:* = _loc_2.t;
                    _loc_4[_loc_2.p](_loc_3);
                }
                else
                {
                    _loc_4[_loc_2.p] = _loc_3;
                }
                _loc_2 = _loc_2._next;
            }
            return;
        }// end function

        public function _kill(param1:Object) : Boolean
        {
            var _loc_3:* = 0;
            if (_propName in param1)
            {
                _overwriteProps = [];
            }
            else
            {
                _loc_3 = _overwriteProps.length;
                while (--_loc_3 > -1)
                {
                    
                    if (_overwriteProps[_loc_3] in param1)
                    {
                        _overwriteProps.splice(_loc_3, 1);
                    }
                }
            }
            var _loc_2:* = _firstPT;
            while (_loc_2)
            {
                
                if (_loc_2.n in param1)
                {
                    if (_loc_2._next)
                    {
                        _loc_2._next._prev = _loc_2._prev;
                    }
                    if (_loc_2._prev)
                    {
                        _loc_2._prev._next = _loc_2._next;
                        _loc_2._prev = null;
                    }
                    else if (_firstPT == _loc_2)
                    {
                        _firstPT = _loc_2._next;
                    }
                }
                _loc_2 = _loc_2._next;
            }
            return false;
        }// end function

        protected function _addTween(param1:Object, param2:String, param3:Number, param4, param5:String = null, param6:Boolean = false) : void
        {
            var _loc_7:* = NaN;
            var _loc_8:* = typeof(param4) === "number" || param4.charAt(1) !== "=" ? (Number(param4) - param3) : (int(param4.charAt(0) + "1") * Number(param4.substr(2)));
            _loc_7 = typeof(param4) === "number" || param4.charAt(1) !== "=" ? (Number(param4) - param3) : (int(param4.charAt(0) + "1") * Number(param4.substr(2)));
            if (param4 != null && _loc_8)
            {
                _firstPT = new PropTween(param1, param2, param3, _loc_7, param5 || param2, false, _firstPT);
                _firstPT.r = param6;
            }
            return;
        }// end function

        public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            return false;
        }// end function

        public static function activate(param1:Array) : Boolean
        {
            TweenLite._onPluginEvent = TweenPlugin._onTweenEvent;
            var _loc_2:* = param1.length;
            while (--_loc_2 > -1)
            {
                
                if (param1[_loc_2].API == TweenPlugin.API)
                {
                    TweenLite._plugins[new (param1[_loc_2] as Class)()._propName] = param1[_loc_2];
                }
            }
            return true;
        }// end function

        private static function _onTweenEvent(param1:String, param2:TweenLite) : Boolean
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_3:* = param2._firstPT;
            if (param1 == "_onInitAllProps")
            {
                while (_loc_3)
                {
                    
                    _loc_8 = _loc_3._next;
                    _loc_5 = _loc_6;
                    while (_loc_5 && _loc_5.pr > _loc_3.pr)
                    {
                        
                        _loc_5 = _loc_5._next;
                    }
                    var _loc_9:* = _loc_5 ? (_loc_5._prev) : (_loc_7);
                    _loc_3._prev = _loc_5 ? (_loc_5._prev) : (_loc_7);
                    if (_loc_9)
                    {
                        _loc_3._prev._next = _loc_3;
                    }
                    else
                    {
                        _loc_6 = _loc_3;
                    }
                    var _loc_9:* = _loc_5;
                    _loc_3._next = _loc_5;
                    if (_loc_9)
                    {
                        _loc_5._prev = _loc_3;
                    }
                    else
                    {
                        _loc_7 = _loc_3;
                    }
                    _loc_3 = _loc_8;
                }
                var _loc_9:* = _loc_6;
                param2._firstPT = _loc_6;
                _loc_3 = _loc_9;
            }
            while (_loc_3)
            {
                
                if (_loc_3.pg)
                {
                    if (param1 in _loc_3.t)
                    {
                        var _loc_9:* = _loc_3.t;
                        if (_loc_9[param1]())
                        {
                            _loc_4 = true;
                        }
                    }
                }
                _loc_3 = _loc_3._next;
            }
            return _loc_4;
        }// end function

    }
}
