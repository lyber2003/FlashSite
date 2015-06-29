package com.greensock.plugins
{
    import com.greensock.*;
    import flash.filters.*;

    public class FilterPlugin extends TweenPlugin
    {
        protected var _remove:Boolean;
        private var _tween:TweenLite;
        protected var _target:Object;
        protected var _index:int;
        protected var _filter:BitmapFilter;
        protected var _type:Class;
        public static const API:Number = 2;

        public function FilterPlugin(param1:String = "", param2:Number = 0)
        {
            super(param1, param2);
            return;
        }// end function

        protected function _initFilter(param1, param2:Object, param3:TweenLite, param4:Class, param5:BitmapFilter, param6:Array) : Boolean
        {
            var _loc_8:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            _target = param1;
            _tween = param3;
            _type = param4;
            var _loc_7:* = _target.filters;
            var _loc_11:* = param2 is BitmapFilter ? ({}) : (param2);
            if ((_loc_11).index != null)
            {
                _index = _loc_11.index;
            }
            else
            {
                _index = _loc_7.length;
                do
                {
                    
                    _index = (_index - 1);
                }while (_index > -1 && !(_loc_7[_index] is _type))
            }
            if (_index < 0 || _loc_7[_index] == null || _loc_11.addFilter == true)
            {
                _index = _loc_7.length;
                _loc_7[_index] = param5;
                _target.filters = _loc_7;
            }
            _filter = _loc_7[_index];
            _remove = _loc_11.remove == true;
            _loc_9 = param6.length;
            while (--_loc_9 > -1)
            {
                
                _loc_8 = param6[_loc_9];
                if (_loc_8 in param2 && _filter[_loc_8] != param2[_loc_8])
                {
                    if (_loc_8 == "color" || _loc_8 == "highlightColor" || _loc_8 == "shadowColor")
                    {
                        _loc_10 = new HexColorsPlugin();
                        _loc_10._initColor(_filter, _loc_8, param2[_loc_8]);
                        _addTween(_loc_10, "setRatio", 0, 1, _propName);
                        continue;
                    }
                    if (_loc_8 == "quality" || _loc_8 == "inner" || _loc_8 == "knockout" || _loc_8 == "hideObject")
                    {
                        _filter[_loc_8] = param2[_loc_8];
                        continue;
                    }
                    _addTween(_filter, _loc_8, _filter[_loc_8], param2[_loc_8], _propName);
                }
            }
            return true;
        }// end function

        override public function setRatio(param1:Number) : void
        {
            super.setRatio(param1);
            var _loc_2:* = _target.filters;
            if (!(_loc_2[_index] is _type))
            {
                _index = _loc_2.length;
                do
                {
                    
                    _index = (_index - 1);
                }while (_index > -1 && !(_loc_2[_index] is _type))
                if (_index == -1)
                {
                    _index = _loc_2.length;
                }
            }
            if (param1 == 1 && _remove && _tween._time == _tween._duration)
            {
                if (_index < _loc_2.length)
                {
                    _loc_2.splice(_index, 1);
                }
            }
            else
            {
                _loc_2[_index] = _filter;
            }
            _target.filters = _loc_2;
            return;
        }// end function

    }
}
