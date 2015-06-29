package com.greensock.core
{

    public class SimpleTimeline extends Animation
    {
        public var _first:Animation;
        public var autoRemoveChildren:Boolean;
        public var _last:Animation;
        public var smoothChildTiming:Boolean;
        public var _sortChildren:Boolean;

        public function SimpleTimeline(param1:Object = null)
        {
            super(0, param1);
            var _loc_2:* = true;
            this.smoothChildTiming = true;
            this.autoRemoveChildren = _loc_2;
            return;
        }// end function

        public function add(param1, param2 = "+=0", param3:String = "normal", param4:Number = 0)
        {
            var _loc_6:* = NaN;
            param1._startTime = Number(param2 || 0) + param1._delay;
            if (param1._paused)
            {
                if (param1._timeline != this)
                {
                    param1._pauseTime = param1._startTime + (rawTime() - param1._startTime) / param1._timeScale;
                }
            }
            if (param1.timeline)
            {
                param1.timeline._remove(param1, true);
            }
            var _loc_7:* = this;
            param1._timeline = this;
            param1.timeline = _loc_7;
            if (param1._gc)
            {
                param1._enabled(true, true);
            }
            var _loc_5:* = _last;
            if (_sortChildren)
            {
                _loc_6 = param1._startTime;
                while (_loc_5 && _loc_5._startTime > _loc_6)
                {
                    
                    _loc_5 = _loc_5._prev;
                }
            }
            if (_loc_5)
            {
                param1._next = _loc_5._next;
                _loc_5._next = Animation(param1);
            }
            else
            {
                param1._next = _first;
                _first = Animation(param1);
            }
            if (param1._next)
            {
                param1._next._prev = param1;
            }
            else
            {
                _last = Animation(param1);
            }
            param1._prev = _loc_5;
            if (_timeline)
            {
                _uncache(true);
            }
            return this;
        }// end function

        public function _remove(param1:Animation, param2:Boolean = false)
        {
            if (param1.timeline == this)
            {
                if (!param2)
                {
                    param1._enabled(false, true);
                }
                param1.timeline = null;
                if (param1._prev)
                {
                    param1._prev._next = param1._next;
                }
                else if (_first === param1)
                {
                    _first = param1._next;
                }
                if (param1._next)
                {
                    param1._next._prev = param1._prev;
                }
                else if (_last === param1)
                {
                    _last = param1._prev;
                }
                if (_timeline)
                {
                    _uncache(true);
                }
            }
            return this;
        }// end function

        public function rawTime() : Number
        {
            return _totalTime;
        }// end function

        override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_5:* = null;
            var _loc_4:* = _first;
            var _loc_6:* = param1;
            _rawPrevTime = param1;
            _time = _loc_6;
            _totalTime = _loc_6;
            while (_loc_4)
            {
                
                _loc_5 = _loc_4._next;
                if (_loc_4._active || param1 >= _loc_4._startTime && !_loc_4._paused)
                {
                    if (!_loc_4._reversed)
                    {
                        _loc_4.render((param1 - _loc_4._startTime) * _loc_4._timeScale, param2, param3);
                    }
                    else
                    {
                        _loc_4.render((!_loc_4._dirty ? (_loc_4._totalDuration) : (_loc_4.totalDuration())) - (param1 - _loc_4._startTime) * _loc_4._timeScale, param2, param3);
                    }
                }
                _loc_4 = _loc_5;
            }
            return;
        }// end function

        public function insert(param1, param2 = 0)
        {
            return add(param1, param2 || 0);
        }// end function

    }
}
