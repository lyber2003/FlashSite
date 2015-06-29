package com.greensock.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Animation extends Object
    {
        public var _delay:Number;
        public var _prev:Animation;
        public var _reversed:Boolean;
        public var _active:Boolean;
        public var _timeline:SimpleTimeline;
        public var _rawPrevTime:Number;
        public var data:Object;
        public var vars:Object;
        public var _totalTime:Number;
        public var _time:Number;
        public var timeline:SimpleTimeline;
        public var _initted:Boolean;
        public var _paused:Boolean;
        public var _startTime:Number;
        public var _dirty:Boolean;
        public var _next:Animation;
        protected var _onUpdate:Function;
        public var _pauseTime:Number;
        public var _duration:Number;
        public var _totalDuration:Number;
        public var _gc:Boolean;
        public var _timeScale:Number;
        public static var _rootFramesTimeline:SimpleTimeline;
        public static var _rootTimeline:SimpleTimeline;
        public static var ticker:Shape = new Shape();
        static var _rootFrame:Number = -1;
        static var _tickEvent:Event = new Event("tick");
        public static const version:String = "12.0.5";

        public function Animation(param1:Number = 0, param2:Object = null)
        {
            this.vars = param2 || {};
            if (this.vars._isGSVars)
            {
                this.vars = this.vars.vars;
            }
            var _loc_4:* = param1 || 0;
            _totalDuration = param1 || 0;
            _duration = _loc_4;
            _delay = Number(this.vars.delay) || 0;
            _timeScale = 1;
            var _loc_4:* = 0;
            _time = 0;
            _totalTime = _loc_4;
            data = this.vars.data;
            _rawPrevTime = -1;
            if (_rootTimeline == null)
            {
                if (_rootFrame == -1)
                {
                    _rootFrame = 0;
                    _rootFramesTimeline = new SimpleTimeline();
                    _rootTimeline = new SimpleTimeline();
                    _rootTimeline._startTime = getTimer() / 1000;
                    _rootFramesTimeline._startTime = 0;
                    var _loc_4:* = true;
                    _rootFramesTimeline._active = true;
                    _rootTimeline._active = _loc_4;
                    ticker.addEventListener("enterFrame", _updateRoot, false, 0, true);
                }
                else
                {
                    return;
                }
            }
            var _loc_3:* = this.vars.useFrames ? (_rootFramesTimeline) : (_rootTimeline);
            _loc_3.add(this, _loc_3._time);
            _reversed = this.vars.reversed == true;
            if (this.vars.paused)
            {
                paused(true);
            }
            return;
        }// end function

        public function delay(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                return _delay;
            }
            if (_timeline.smoothChildTiming)
            {
                startTime(_startTime + param1 - _delay);
            }
            _delay = param1;
            return this;
        }// end function

        public function totalDuration(param1:Number = NaN)
        {
            _dirty = false;
            return !arguments.length ? (_totalDuration) : (duration(param1));
        }// end function

        public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
        {
            _gc = !param1;
            _active = Boolean(param1 && !_paused && _totalTime > 0 && _totalTime < _totalDuration);
            if (!param2)
            {
                if (param1 && timeline == null)
                {
                    _timeline.add(this, _startTime - _delay);
                }
                else if (!param1 && timeline != null)
                {
                    _timeline._remove(this, true);
                }
            }
            return false;
        }// end function

        public function timeScale(param1:Number = NaN)
        {
            arguments = NaN;
            if (!arguments.length)
            {
                return _timeScale;
            }
            param1 = param1 || 1e-006;
            if (_timeline && _timeline.smoothChildTiming)
            {
                arguments = _pauseTime || _pauseTime == 0 ? (_pauseTime) : (_timeline._totalTime);
                _startTime = arguments - (arguments - _startTime) * _timeScale / param1;
            }
            _timeScale = param1;
            return _uncache(false);
        }// end function

        public function duration(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                _dirty = false;
                return _duration;
            }
            arguments = param1;
            _totalDuration = arguments;
            _duration = arguments;
            _uncache(true);
            if (_timeline.smoothChildTiming)
            {
                if (_time > 0)
                {
                    if (_time < _duration)
                    {
                        if (param1 != 0)
                        {
                            totalTime(_totalTime * (param1 / _duration), true);
                        }
                    }
                }
            }
            return this;
        }// end function

        public function restart(param1:Boolean = false, param2:Boolean = true)
        {
            reversed(false);
            paused(false);
            return totalTime(param1 ? (-_delay) : (0), param2);
        }// end function

        public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            return;
        }// end function

        public function resume(param1 = null, param2:Boolean = true)
        {
            if (arguments.length)
            {
                seek(param1, param2);
            }
            return paused(false);
        }// end function

        public function paused(param1:Boolean = false)
        {
            arguments = NaN;
            var _loc_4:* = NaN;
            if (!arguments.length)
            {
                return _paused;
            }
            if (param1 != _paused)
            {
                if (_timeline)
                {
                    arguments = _timeline.rawTime();
                    _loc_4 = arguments - _pauseTime;
                    if (!param1 && _timeline.smoothChildTiming)
                    {
                        _startTime = _startTime + _loc_4;
                        _uncache(false);
                    }
                    _pauseTime = param1 ? (arguments) : (NaN);
                    _paused = param1;
                    _active = !param1 && _totalTime > 0 && _totalTime < _totalDuration;
                    if (!param1 && _loc_4 != 0)
                    {
                        render(_time, true, true);
                    }
                }
            }
            if (_gc && !param1)
            {
                _enabled(true, false);
            }
            return this;
        }// end function

        public function totalTime(param1:Number = NaN, param2:Boolean = false)
        {
            arguments = null;
            if (!arguments.length)
            {
                return _totalTime;
            }
            if (_timeline)
            {
                if (param1 < 0)
                {
                    param1 = param1 + totalDuration();
                }
                if (_timeline.smoothChildTiming)
                {
                    if (_dirty)
                    {
                        totalDuration();
                    }
                    if (param1 > _totalDuration)
                    {
                        param1 = _totalDuration;
                    }
                    _startTime = (_paused ? (_pauseTime) : (_timeline._time)) - (!_reversed ? (param1) : (_totalDuration - param1)) / _timeScale;
                    if (!_timeline._dirty)
                    {
                        _uncache(false);
                    }
                    if (!_timeline._active)
                    {
                        arguments = _timeline;
                        while (arguments._timeline)
                        {
                            
                            arguments.totalTime(arguments._totalTime, true);
                            arguments = arguments._timeline;
                        }
                    }
                }
                if (_gc)
                {
                    _enabled(true, false);
                }
                if (_totalTime != param1)
                {
                    render(param1, param2, false);
                }
            }
            return this;
        }// end function

        public function play(param1 = null, param2:Boolean = true)
        {
            if (arguments.length)
            {
                seek(param1, param2);
            }
            reversed(false);
            return paused(false);
        }// end function

        public function invalidate()
        {
            return this;
        }// end function

        public function _kill(param1:Object = null, param2:Object = null) : Boolean
        {
            return _enabled(false, false);
        }// end function

        public function reversed(param1:Boolean = false)
        {
            if (!arguments.length)
            {
                return _reversed;
            }
            if (param1 != _reversed)
            {
                _reversed = param1;
                totalTime(_totalTime, true);
            }
            return this;
        }// end function

        public function startTime(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                return _startTime;
            }
            if (param1 != _startTime)
            {
                _startTime = param1;
                if (timeline)
                {
                    if (timeline._sortChildren)
                    {
                        timeline.add(this, param1 - _delay);
                    }
                }
            }
            return this;
        }// end function

        protected function _uncache(param1:Boolean)
        {
            var _loc_2:* = param1 ? (this) : (timeline);
            while (_loc_2)
            {
                
                _loc_2._dirty = true;
                _loc_2 = _loc_2.timeline;
            }
            return this;
        }// end function

        public function time(param1:Number = NaN, param2:Boolean = false)
        {
            if (!arguments.length)
            {
                return _time;
            }
            if (_dirty)
            {
                totalDuration();
            }
            if (param1 > _duration)
            {
                param1 = _duration;
            }
            return totalTime(param1, param2);
        }// end function

        public function kill(param1:Object = null, param2:Object = null)
        {
            _kill(param1, param2);
            return this;
        }// end function

        public function reverse(param1 = null, param2:Boolean = true)
        {
            if (arguments.length)
            {
                seek(param1 || totalDuration(), param2);
            }
            reversed(true);
            return paused(false);
        }// end function

        public function seek(param1, param2:Boolean = true)
        {
            return totalTime(Number(param1), param2);
        }// end function

        public function pause(param1 = null, param2:Boolean = true)
        {
            if (arguments.length)
            {
                seek(param1, param2);
            }
            return paused(true);
        }// end function

        public function eventCallback(param1:String, param2:Function = null, param3:Array = null)
        {
            arguments = 0;
            if (param1 == null)
            {
                return null;
            }
            if (param1.substr(0, 2) == "on")
            {
                if (arguments.length == 1)
                {
                    return vars[param1];
                }
                if (param2 == null)
                {
                    delete vars[param1];
                }
                else
                {
                    vars[param1] = param2;
                    vars[param1 + "Params"] = param3;
                    if (param3)
                    {
                        arguments = param3.length;
                        do
                        {
                            
                            if (param3[arguments] == "{self}")
                            {
                                var _loc_6:* = param3.concat();
                                vars[param1 + "Params"] = param3.concat();
                                param3 = _loc_6;
                                param3[arguments] = this;
                            }
                            arguments = (arguments - 1);
                        }while (arguments > -1)
                    }
                }
                if (param1 == "onUpdate")
                {
                    _onUpdate = param2;
                }
            }
            return this;
        }// end function

        public static function _updateRoot(event:Event = null) : void
        {
            var _loc_3:* = _rootFrame + 1;
            _rootFrame = _loc_3;
            _rootTimeline.render((getTimer() / 1000 - _rootTimeline._startTime) * _rootTimeline._timeScale, false, false);
            _rootFramesTimeline.render((_rootFrame - _rootFramesTimeline._startTime) * _rootFramesTimeline._timeScale, false, false);
            ticker.dispatchEvent(_tickEvent);
            return;
        }// end function

    }
}
