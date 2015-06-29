package com.greensock.plugins
{
    import com.greensock.*;
    import com.greensock.core.*;

    public class RoundPropsPlugin extends TweenPlugin
    {
        protected var _tween:TweenLite;
        public static const API:Number = 2;

        public function RoundPropsPlugin()
        {
            super("roundProps", -1);
            _overwriteProps.length = 0;
            return;
        }// end function

        public function _add(param1:Object, param2:String, param3:Number, param4:Number) : void
        {
            _addTween(param1, param2, param3, param3 + param4, param2, true);
            _overwriteProps[_overwriteProps.length] = param2;
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            _tween = param3;
            return true;
        }// end function

        public function _onInitAllProps() : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_1:* = _tween.vars.roundProps is Array ? (_tween.vars.roundProps) : (_tween.vars.roundProps.split(","));
            var _loc_2:* = _loc_1.length;
            var _loc_3:* = {};
            var _loc_4:* = _tween._propLookup.roundProps;
            while (--_loc_2 > -1)
            {
                
                _loc_3[_loc_1[_loc_2]] = 1;
            }
            --_loc_2 = _loc_1.length;
            while (--_loc_2 > -1)
            {
                
                _loc_5 = _loc_1[--_loc_2];
                _loc_6 = _tween._firstPT;
                while (_loc_6)
                {
                    
                    _loc_7 = _loc_6._next;
                    if (_loc_6.pg)
                    {
                        _loc_6.t._roundProps(_loc_3, true);
                    }
                    else if (_loc_6.n == _loc_5)
                    {
                        _add(_loc_6.t, _loc_5, _loc_6.s, _loc_6.c);
                        if (_loc_7)
                        {
                            _loc_7._prev = _loc_6._prev;
                        }
                        if (_loc_6._prev)
                        {
                            _loc_6._prev._next = _loc_7;
                        }
                        else if (_tween._firstPT == _loc_6)
                        {
                            _tween._firstPT = _loc_7;
                        }
                        var _loc_8:* = null;
                        _loc_6._prev = null;
                        _loc_6._next = _loc_8;
                        _tween._propLookup[_loc_5] = _loc_4;
                    }
                    _loc_6 = _loc_7;
                }
            }
            return false;
        }// end function

    }
}
