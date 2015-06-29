package com.greensock
{
    import com.greensock.core.*;

    public class TimelineLite extends SimpleTimeline
    {
        protected var _labels:Object;
        static const _paramProps:Array = ["onStartParams", "onUpdateParams", "onCompleteParams", "onReverseCompleteParams", "onRepeatParams"];
        public static const version:String = "12.0.5";

        public function TimelineLite(param1:Object = null)
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            super(param1);
            _labels = {};
            autoRemoveChildren = this.vars.autoRemoveChildren == true;
            smoothChildTiming = this.vars.smoothChildTiming == true;
            _sortChildren = true;
            _onUpdate = this.vars.onUpdate;
            var _loc_2:* = _paramProps.length;
            while (--_loc_2 > -1)
            {
                
                var _loc_5:* = this.vars[_paramProps[_loc_2]];
                _loc_4 = this.vars[_paramProps[_loc_2]];
                if (_loc_5)
                {
                    _loc_3 = _loc_4.length;
                    while (--_loc_3 > -1)
                    {
                        
                        if (_loc_4[_loc_3] === "{self}")
                        {
                            var _loc_5:* = _loc_4.concat();
                            this.vars[_paramProps[_loc_2]] = _loc_4.concat();
                            _loc_4 = _loc_5;
                            _loc_4[_loc_3] = this;
                        }
                    }
                }
            }
            if (this.vars.tweens is Array)
            {
                this.add(this.vars.tweens, 0, this.vars.align || "normal", this.vars.stagger || 0);
            }
            return;
        }// end function

        public function stop()
        {
            return paused(true);
        }// end function

        public function remove(param1)
        {
            var _loc_2:* = NaN;
            if (param1 is Animation)
            {
                return _remove(param1, false);
            }
            if (param1 is Array)
            {
                _loc_2 = param1.length;
                while (--_loc_2 > -1)
                {
                    
                    remove(param1[_loc_2]);
                }
                return this;
            }
            else if (typeof(param1) == "string")
            {
                return removeLabel(String(param1));
            }
            return kill(null, param1);
        }// end function

        public function fromTo(param1:Object, param2:Number, param3:Object, param4:Object, param5 = "+=0")
        {
            return add(TweenLite.fromTo(param1, param2, param3, param4), param5);
        }// end function

        public function gotoAndPlay(param1, param2:Boolean = true)
        {
            return play(param1, param2);
        }// end function

        override public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = null;
            if (param1 == _gc)
            {
                _loc_3 = _first;
                while (_loc_3)
                {
                    
                    _loc_3._enabled(param1, true);
                    _loc_3 = _loc_3._next;
                }
            }
            return super._enabled(param1, param2);
        }// end function

        public function appendMultiple(param1:Array, param2 = 0, param3:String = "normal", param4:Number = 0)
        {
            return add(param1, _parseTimeOrLabel(null, param2, true, param1), param3, param4);
        }// end function

        public function clear(param1:Boolean = true)
        {
            var _loc_2:* = getChildren(false, true, true);
            var _loc_3:* = _loc_2.length;
            var _loc_4:* = 0;
            _totalTime = 0;
            _time = _loc_4;
            while (--_loc_3 > -1)
            {
                
                _loc_2[_loc_3]._enabled(false, false);
            }
            if (param1)
            {
                _labels = {};
            }
            return _uncache(true);
        }// end function

        public function staggerTo(param1:Array, param2:Number, param3:Object, param4:Number, param5 = "+=0", param6:Function = null, param7:Array = null)
        {
            var _loc_8:* = new TimelineLite({onComplete:param6, onCompleteParams:param7});
            var _loc_9:* = 0;
            while (_loc_9 < param1.length)
            {
                
                if (param3.startAt != null)
                {
                    param3.startAt = _copy(param3.startAt);
                }
                _loc_8.add(new TweenLite(param1[_loc_9], param2, _copy(param3)), _loc_9 * param4);
                _loc_9++;
            }
            return add(_loc_8, param5);
        }// end function

        public function removeLabel(param1:String)
        {
            delete _labels[param1];
            return this;
        }// end function

        public function staggerFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6 = "+=0", param7:Function = null, param8:Array = null)
        {
            param4 = _prepVars(param4);
            param3 = _prepVars(param3);
            param4.startAt = param3;
            param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
            return staggerTo(param1, param2, param4, param5, param6, param7, param8);
        }// end function

        public function addLabel(param1:String, param2)
        {
            _labels[param1] = _parseTimeOrLabel(param2);
            return this;
        }// end function

        override public function duration(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                if (_dirty)
                {
                    totalDuration();
                }
                return _duration;
            }
            if (duration() !== 0)
            {
                if (param1 !== 0)
                {
                    timeScale(_duration / param1);
                }
            }
            return this;
        }// end function

        public function getTweensOf(param1:Object, param2:Boolean = true) : Array
        {
            var _loc_3:* = TweenLite.getTweensOf(param1);
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = [];
            var _loc_6:* = 0;
            while (--_loc_4 > -1)
            {
                
                if (_loc_3[_loc_4].timeline == this || param2 && _contains(_loc_3[_loc_4]))
                {
                    _loc_5[++_loc_6] = _loc_3[_loc_4];
                }
            }
            return _loc_5;
        }// end function

        public function gotoAndStop(param1, param2:Boolean = true)
        {
            return pause(param1, param2);
        }// end function

        public function usesFrames() : Boolean
        {
            var _loc_1:* = _timeline;
            while (_loc_1._timeline)
            {
                
                _loc_1 = _loc_1._timeline;
            }
            return _loc_1 == _rootFramesTimeline;
        }// end function

        public function append(param1, param2 = 0)
        {
            return add(param1, _parseTimeOrLabel(null, param2, true, param1));
        }// end function

        override public function rawTime() : Number
        {
            return _paused || _totalTime !== 0 && _totalTime !== _totalDuration ? (_totalTime) : ((_timeline.rawTime() - _startTime) * _timeScale);
        }// end function

        override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = false;
            if (_gc)
            {
                _enabled(true, false);
            }
            else if (!_active && !_paused)
            {
                _active = true;
            }
            var _loc_4:* = !_dirty ? (_totalDuration) : (totalDuration());
            var _loc_5:* = _time;
            var _loc_6:* = _startTime;
            var _loc_7:* = _timeScale;
            var _loc_8:* = _paused;
            if (param1 >= _loc_4)
            {
                var _loc_14:* = _loc_4;
                _time = _loc_4;
                _totalTime = _loc_14;
                if (!_reversed)
                {
                    if (!_hasPausedChild())
                    {
                        _loc_10 = true;
                        _loc_12 = "onComplete";
                        if (_duration == 0)
                        {
                            if (param1 == 0 || _rawPrevTime < 0)
                            {
                                if (_rawPrevTime != param1)
                                {
                                    _loc_13 = true;
                                }
                            }
                        }
                    }
                }
                _rawPrevTime = param1;
                param1 = _loc_4 + 1e-006;
            }
            else if (param1 < 1e-007)
            {
                var _loc_14:* = 0;
                _time = 0;
                _totalTime = _loc_14;
                if (_loc_5 != 0 || _duration == 0 && _rawPrevTime > 0)
                {
                    _loc_12 = "onReverseComplete";
                    _loc_10 = _reversed;
                }
                if (param1 < 0)
                {
                    _active = false;
                    if (_duration == 0)
                    {
                        if (_rawPrevTime >= 0)
                        {
                            _loc_13 = true;
                        }
                    }
                }
                else if (!_initted)
                {
                    _loc_13 = true;
                }
                _rawPrevTime = param1;
            }
            else
            {
                var _loc_14:* = param1;
                _rawPrevTime = param1;
                _time = _loc_14;
                _totalTime = _loc_14;
            }
            if (_time == _loc_5 && !param3 && !_loc_13)
            {
                return;
            }
            if (!_initted)
            {
                _initted = true;
            }
            if (_loc_5 == 0)
            {
                if (vars.onStart)
                {
                    if (_time != 0)
                    {
                        if (!param2)
                        {
                            vars.onStart.apply(null, vars.onStartParams);
                        }
                    }
                }
            }
            if (_time >= _loc_5)
            {
                _loc_9 = _first;
                while (_loc_9)
                {
                    
                    _loc_11 = _loc_9._next;
                    if (_paused && !_loc_8)
                    {
                        break;
                    }
                    else if (_loc_9._active || _loc_9._startTime <= _time && !_loc_9._paused && !_loc_9._gc)
                    {
                        if (!_loc_9._reversed)
                        {
                            _loc_9.render((param1 - _loc_9._startTime) * _loc_9._timeScale, param2, param3);
                        }
                        else
                        {
                            _loc_9.render((!_loc_9._dirty ? (_loc_9._totalDuration) : (_loc_9.totalDuration())) - (param1 - _loc_9._startTime) * _loc_9._timeScale, param2, param3);
                        }
                    }
                    _loc_9 = _loc_11;
                }
            }
            else
            {
                _loc_9 = _last;
                while (_loc_9)
                {
                    
                    _loc_11 = _loc_9._prev;
                    if (_paused && !_loc_8)
                    {
                        break;
                    }
                    else if (_loc_9._active || _loc_9._startTime <= _loc_5 && !_loc_9._paused && !_loc_9._gc)
                    {
                        if (!_loc_9._reversed)
                        {
                            _loc_9.render((param1 - _loc_9._startTime) * _loc_9._timeScale, param2, param3);
                        }
                        else
                        {
                            _loc_9.render((!_loc_9._dirty ? (_loc_9._totalDuration) : (_loc_9.totalDuration())) - (param1 - _loc_9._startTime) * _loc_9._timeScale, param2, param3);
                        }
                    }
                    _loc_9 = _loc_11;
                }
            }
            if (_onUpdate != null)
            {
                if (!param2)
                {
                    _onUpdate.apply(null, vars.onUpdateParams);
                }
            }
            if (_loc_12)
            {
                if (!_gc)
                {
                    if (_loc_6 == _startTime || _loc_7 != _timeScale)
                    {
                        if (_time == 0 || _loc_4 >= totalDuration())
                        {
                            if (_loc_10)
                            {
                                if (_timeline.autoRemoveChildren)
                                {
                                    _enabled(false, false);
                                }
                                _active = false;
                            }
                            if (!param2)
                            {
                                if (vars[_loc_12])
                                {
                                    vars[_loc_12].apply(null, vars[_loc_12 + "Params"]);
                                }
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        override public function add(param1, param2 = "+=0", param3:String = "normal", param4:Number = 0)
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            if (typeof(param2) !== "number")
            {
                param2 = _parseTimeOrLabel(param2, 0, true, param1);
            }
            if (!(param1 is Animation))
            {
                if (param1 is Array)
                {
                    _loc_6 = Number(param2);
                    _loc_7 = param1.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_7)
                    {
                        
                        _loc_8 = param1[_loc_5];
                        if (_loc_8 is Array)
                        {
                            _loc_8 = new TimelineLite({tweens:_loc_8});
                        }
                        add(_loc_8, _loc_6);
                        if (typeof(_loc_8) === "string" || typeof(_loc_8) === "function")
                        {
                        }
                        else if (param3 === "sequence")
                        {
                            _loc_6 = _loc_8._startTime + _loc_8.totalDuration() / _loc_8._timeScale;
                        }
                        else if (param3 === "start")
                        {
                            _loc_8._startTime = _loc_8._startTime - _loc_8.delay();
                        }
                        _loc_6 = _loc_6 + param4;
                        _loc_5++;
                    }
                    return _uncache(true);
                }
                else
                {
                    if (typeof(param1) === "string")
                    {
                        return addLabel(String(param1), param2);
                    }
                    if (typeof(param1) === "function")
                    {
                        param1 = TweenLite.delayedCall(0, param1);
                    }
                    else
                    {
                        trace("Cannot add " + param1 + " into the TimelineLite/Max: it is neither a tween, timeline, function, nor a String.");
                        return this;
                    }
                }
            }
            super.add(param1, param2);
            if (_gc)
            {
                if (!_paused)
                {
                    if (_time === _duration)
                    {
                        if (_time < duration())
                        {
                            _loc_9 = this;
                            while (_loc_9._gc && _loc_9._timeline)
                            {
                                
                                if (_loc_9._timeline.smoothChildTiming)
                                {
                                    _loc_9.totalTime(_loc_9._totalTime, true);
                                }
                                else
                                {
                                    _loc_9._enabled(true, false);
                                }
                                _loc_9 = _loc_9._timeline;
                            }
                        }
                    }
                }
            }
            return this;
        }// end function

        public function set(param1:Object, param2:Object, param3 = "+=0")
        {
            param3 = _parseTimeOrLabel(param3, 0, true);
            param2 = _prepVars(param2);
            if (param2.immediateRender == null)
            {
                param2.immediateRender = param3 === _time && !_paused;
            }
            return add(new TweenLite(param1, 0, param2), param3);
        }// end function

        public function call(param1:Function, param2:Array = null, param3 = "+=0")
        {
            return add(TweenLite.delayedCall(0, param1, param2), param3);
        }// end function

        public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0)
        {
            var _loc_5:* = null;
            var _loc_4:* = _first;
            while (_loc_4)
            {
                
                if (_loc_4._startTime >= param3)
                {
                    _loc_4._startTime = _loc_4._startTime + param1;
                }
                _loc_4 = _loc_4._next;
            }
            if (param2)
            {
                for (_loc_5 in _labels)
                {
                    
                    if (_loc_7[_loc_5] >= param3)
                    {
                        _loc_7[_loc_5] = _loc_7[_loc_5] + param1;
                    }
                }
            }
            _uncache(true);
            return this;
        }// end function

        public function insertMultiple(param1:Array, param2 = 0, param3:String = "normal", param4:Number = 0)
        {
            return add(param1, param2 || 0, param3, param4);
        }// end function

        public function from(param1:Object, param2:Number, param3:Object, param4 = "+=0")
        {
            return add(TweenLite.from(param1, param2, param3), param4);
        }// end function

        public function getLabelTime(param1:String) : Number
        {
            return param1 in _labels ? (Number(_labels[param1])) : (-1);
        }// end function

        public function progress(param1:Number = NaN)
        {
            return !arguments.length ? (_time / duration()) : (totalTime(duration() * param1, false));
        }// end function

        protected function _parseTimeOrLabel(param1, param2 = 0, param3:Boolean = false, param4:Object = null) : Number
        {
            var _loc_5:* = 0;
            if (param4 is Animation && param4.timeline === this)
            {
                remove(param4);
            }
            else if (param4 is Array)
            {
                _loc_5 = param4.length;
                while (--_loc_5 > -1)
                {
                    
                    if (param4[_loc_5] is Animation && param4[_loc_5].timeline === this)
                    {
                        remove(param4[_loc_5]);
                    }
                }
            }
            if (typeof(param2) === "string")
            {
                return _parseTimeOrLabel(param2, param3 && typeof(param1) === "number" && !(param2 in _labels) ? (param1 - duration()) : (0), param3);
            }
            param2 = param2 || 0;
            if (typeof(param1) === "string" && (isNaN(param1) || param1 in _labels))
            {
                --_loc_5 = param1.indexOf("=");
                if (--_loc_5 === -1)
                {
                    if (!(param1 in _labels))
                    {
                        return param3 ? (var _loc_6:* = duration() + param2, _labels[param1] = duration() + param2, _loc_6) : (param2);
                    }
                    return _labels[param1] + param2;
                }
                param2 = parseInt(param1.charAt((_loc_5 - 1)) + "1", 10) * Number(param1.substr((_loc_5 + 1)));
                param1 = _loc_5 > 1 ? (_parseTimeOrLabel(param1.substr(0, (_loc_5 - 1)), 0, param3)) : (duration());
            }
            else if (param1 == null)
            {
                param1 = duration();
            }
            return Number(param1) + param2;
        }// end function

        override public function invalidate()
        {
            var _loc_1:* = _first;
            while (_loc_1)
            {
                
                _loc_1.invalidate();
                _loc_1 = _loc_1._next;
            }
            return this;
        }// end function

        public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -1e+010) : Array
        {
            var _loc_5:* = [];
            var _loc_6:* = _first;
            var _loc_7:* = 0;
            while (_loc_6)
            {
                
                if (_loc_6._startTime < param4)
                {
                }
                else if (_loc_6 is TweenLite)
                {
                    if (param2)
                    {
                        _loc_5[++_loc_7] = _loc_6;
                    }
                }
                else
                {
                    if (param3)
                    {
                        _loc_5[++_loc_7] = _loc_6;
                    }
                    if (param1)
                    {
                        _loc_5 = _loc_5.concat(TimelineLite(_loc_6).getChildren(true, param2, param3));
                        _loc_7 = _loc_5.length;
                    }
                }
                _loc_6 = _loc_6._next;
            }
            return _loc_5;
        }// end function

        public function staggerFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5 = "+=0", param6:Function = null, param7:Array = null)
        {
            param3 = _prepVars(param3);
            if (!("immediateRender" in param3))
            {
                param3.immediateRender = true;
            }
            param3.runBackwards = true;
            return staggerTo(param1, param2, param3, param4, param5, param6, param7);
        }// end function

        override public function seek(param1, param2:Boolean = true)
        {
            return totalTime(typeof(param1) === "number" ? (Number(param1)) : (_parseTimeOrLabel(param1)), param2);
        }// end function

        override public function insert(param1, param2 = 0)
        {
            return add(param1, param2 || 0);
        }// end function

        public function _hasPausedChild() : Boolean
        {
            var _loc_1:* = _first;
            while (_loc_1)
            {
                
                if (_loc_1._paused || _loc_1 is TimelineLite && TimelineLite(_loc_1)._hasPausedChild())
                {
                    return true;
                }
                _loc_1 = _loc_1._next;
            }
            return false;
        }// end function

        public function to(param1:Object, param2:Number, param3:Object, param4 = "+=0")
        {
            return add(new TweenLite(param1, param2, param3), param4);
        }// end function

        override public function _kill(param1:Object = null, param2:Object = null) : Boolean
        {
            if (param1 == null)
            {
                if (param2 == null)
                {
                    return _enabled(false, false);
                }
            }
            var _loc_3:* = param2 == null ? (getChildren(true, true, false)) : (getTweensOf(param2));
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = false;
            while (--_loc_4 > -1)
            {
                
                if (_loc_3[_loc_4]._kill(param1, param2))
                {
                    _loc_5 = true;
                }
            }
            return _loc_5;
        }// end function

        private function _contains(param1:Animation) : Boolean
        {
            var _loc_2:* = param1.timeline;
            while (_loc_2)
            {
                
                if (_loc_2 == this)
                {
                    return true;
                }
                _loc_2 = _loc_2.timeline;
            }
            return false;
        }// end function

        override public function totalDuration(param1:Number = NaN)
        {
            arguments = NaN;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            if (!arguments.length)
            {
                if (_dirty)
                {
                    arguments = 0;
                    _loc_4 = _last;
                    _loc_5 = Infinity;
                    while (_loc_4)
                    {
                        
                        _loc_6 = _loc_4._prev;
                        if (_loc_4._dirty)
                        {
                            _loc_4.totalDuration();
                        }
                        if (_loc_4._startTime > _loc_5 && _sortChildren && !_loc_4._paused)
                        {
                            add(_loc_4, _loc_4._startTime - _loc_4._delay);
                        }
                        else
                        {
                            _loc_5 = _loc_4._startTime;
                        }
                        if (_loc_4._startTime < 0 && !_loc_4._paused)
                        {
                            arguments = arguments - _loc_4._startTime;
                            if (_timeline.smoothChildTiming)
                            {
                                _startTime = _startTime + _loc_4._startTime / _timeScale;
                            }
                            shiftChildren(-_loc_4._startTime, false, -9999999999);
                            _loc_5 = 0;
                        }
                        _loc_7 = _loc_4._startTime + _loc_4._totalDuration / _loc_4._timeScale;
                        if (_loc_7 > arguments)
                        {
                            arguments = _loc_7;
                        }
                        _loc_4 = _loc_6;
                    }
                    var _loc_8:* = arguments;
                    _totalDuration = arguments;
                    _duration = _loc_8;
                    _dirty = false;
                }
                return _totalDuration;
            }
            if (totalDuration() != 0)
            {
                if (param1 != 0)
                {
                    timeScale(_totalDuration / param1);
                }
            }
            return this;
        }// end function

        public static function exportRoot(param1:Object = null, param2:Boolean = true) : TimelineLite
        {
            var _loc_6:* = null;
            param1 = param1 || {};
            if (!("smoothChildTiming" in param1))
            {
                param1.smoothChildTiming = true;
            }
            var _loc_3:* = new TimelineLite(param1);
            var _loc_4:* = _loc_3._timeline;
            _loc_4._remove(_loc_3, true);
            _loc_3._startTime = 0;
            var _loc_7:* = _loc_4._time;
            _loc_3._totalTime = _loc_4._time;
            _loc_3._time = _loc_7;
            _loc_3._rawPrevTime = _loc_7;
            var _loc_5:* = _loc_4._first;
            while (_loc_5)
            {
                
                _loc_6 = _loc_5._next;
                if (!param2 || !(_loc_5 is TweenLite && TweenLite(_loc_5).target == _loc_5.vars.onComplete))
                {
                    _loc_3.add(_loc_5, _loc_5._startTime - _loc_5._delay);
                }
                _loc_5 = _loc_6;
            }
            _loc_4.add(_loc_3, 0);
            return _loc_3;
        }// end function

        static function _copy(param1:Object) : Object
        {
            var _loc_3:* = null;
            var _loc_2:* = {};
            for (_loc_3 in param1)
            {
                
                _loc_2[_loc_3] = _loc_5[_loc_3];
            }
            return _loc_2;
        }// end function

        static function _prepVars(param1:Object) : Object
        {
            return param1._isGSVars ? (param1.vars) : (param1);
        }// end function

    }
}
