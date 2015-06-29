package com.greensock
{
    import com.greensock.core.*;
    import com.greensock.events.*;
    import com.greensock.plugins.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class TweenMax extends TweenLite implements IEventDispatcher
    {
        protected var _dispatcher:EventDispatcher;
        public var _yoyo:Boolean;
        protected var _hasUpdateListener:Boolean;
        protected var _cycle:int = 0;
        protected var _repeatDelay:Number = 0;
        protected var _repeat:int = 0;
        public static var allFromTo:Function = staggerFromTo;
        public static var ticker:Shape = Animation.ticker;
        public static const version:String = "12.0.5";
        public static var allFrom:Function = staggerFrom;
        static var _listenerLookup:Object = {onCompleteListener:TweenEvent.COMPLETE, onUpdateListener:TweenEvent.UPDATE, onStartListener:TweenEvent.START, onRepeatListener:TweenEvent.REPEAT, onReverseCompleteListener:TweenEvent.REVERSE_COMPLETE};
        public static var allTo:Function = staggerTo;

        public function TweenMax(param1:Object, param2:Number, param3:Object)
        {
            super(param1, param2, param3);
            _yoyo = this.vars.yoyo == true;
            _repeat = uint(this.vars.repeat);
            _repeatDelay = this.vars.repeatDelay || 0;
            _dirty = true;
            if (this.vars.onCompleteListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener)
            {
                _initDispatcher();
                if (_duration == 0)
                {
                    if (_delay == 0)
                    {
                        if (this.vars.immediateRender)
                        {
                            _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                            _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                        }
                    }
                }
            }
            return;
        }// end function

        public function dispatchEvent(event:Event) : Boolean
        {
            return _dispatcher == null ? (false) : (_dispatcher.dispatchEvent(event));
        }// end function

        override public function invalidate()
        {
            _yoyo = Boolean(this.vars.yoyo == true);
            _repeat = this.vars.repeat || 0;
            _repeatDelay = this.vars.repeatDelay || 0;
            _hasUpdateListener = false;
            _initDispatcher();
            _uncache(true);
            return super.invalidate();
        }// end function

        public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            if (_dispatcher)
            {
                _dispatcher.removeEventListener(param1, param2, param3);
            }
            return;
        }// end function

        public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            if (_dispatcher == null)
            {
                _dispatcher = new EventDispatcher(this);
            }
            if (param1 == TweenEvent.UPDATE)
            {
                _hasUpdateListener = true;
            }
            _dispatcher.addEventListener(param1, param2, param3, param4, param5);
            return;
        }// end function

        public function willTrigger(param1:String) : Boolean
        {
            return _dispatcher == null ? (false) : (_dispatcher.willTrigger(param1));
        }// end function

        override public function duration(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                return this._duration;
            }
            return super.duration(param1);
        }// end function

        override public function time(param1:Number = NaN, param2:Boolean = false)
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
            if (_yoyo && (_cycle & 1) !== 0)
            {
                param1 = _duration - param1 + _cycle * (_duration + _repeatDelay);
            }
            else if (_repeat != 0)
            {
                param1 = param1 + _cycle * (_duration + _repeatDelay);
            }
            return totalTime(param1, param2);
        }// end function

        override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_4:* = !_dirty ? (_totalDuration) : (totalDuration());
            var _loc_5:* = _time;
            var _loc_6:* = _totalTime;
            var _loc_7:* = _cycle;
            if (param1 >= _loc_4)
            {
                _totalTime = _loc_4;
                _cycle = _repeat;
                if (_yoyo && (_cycle & 1) != 0)
                {
                    _time = 0;
                    ratio = _ease._calcEnd ? (_ease.getRatio(0)) : (0);
                }
                else
                {
                    _time = _duration;
                    ratio = _ease._calcEnd ? (_ease.getRatio(1)) : (1);
                }
                if (!_reversed)
                {
                    _loc_8 = true;
                    _loc_9 = "onComplete";
                }
                if (_duration == 0)
                {
                    if (param1 == 0 || _rawPrevTime < 0)
                    {
                        if (_rawPrevTime != param1)
                        {
                            param3 = true;
                        }
                    }
                    _rawPrevTime = param1;
                }
            }
            else if (param1 < 1e-007)
            {
                var _loc_15:* = 0;
                _cycle = 0;
                _time = _loc_15;
                _totalTime = _loc_15;
                ratio = _ease._calcEnd ? (_ease.getRatio(0)) : (0);
                if (_loc_6 != 0 || _duration == 0 && _rawPrevTime > 0)
                {
                    _loc_9 = "onReverseComplete";
                    _loc_8 = _reversed;
                }
                if (param1 < 0)
                {
                    _active = false;
                    if (_duration == 0)
                    {
                        if (_rawPrevTime >= 0)
                        {
                            param3 = true;
                        }
                        _rawPrevTime = param1;
                    }
                }
                else if (!_initted)
                {
                    param3 = true;
                }
            }
            else
            {
                var _loc_15:* = param1;
                _time = param1;
                _totalTime = _loc_15;
                if (_repeat != 0)
                {
                    _loc_11 = _duration + _repeatDelay;
                    _cycle = _totalTime / _loc_11 >> 0;
                    if (_cycle !== 0)
                    {
                        if (_cycle === _totalTime / _loc_11)
                        {
                            var _loc_16:* = _cycle - 1;
                            _cycle = _loc_16;
                        }
                    }
                    _time = _totalTime - _cycle * _loc_11;
                    if (_yoyo)
                    {
                        if ((_cycle & 1) != 0)
                        {
                            _time = _duration - _time;
                        }
                    }
                    if (_time > _duration)
                    {
                        _time = _duration;
                    }
                    else if (_time < 0)
                    {
                        _time = 0;
                    }
                }
                if (_easeType)
                {
                    _loc_12 = _time / _duration;
                    _loc_13 = _easeType;
                    _loc_14 = _easePower;
                    if (_loc_13 == 1 || _loc_13 == 3 && _loc_12 >= 0.5)
                    {
                        _loc_12 = 1 - _loc_12;
                    }
                    if (_loc_13 == 3)
                    {
                        _loc_12 = _loc_12 * 2;
                    }
                    if (_loc_14 == 1)
                    {
                        _loc_12 = _loc_12 * _loc_12;
                    }
                    else if (_loc_14 == 2)
                    {
                        _loc_12 = _loc_12 * (_loc_12 * _loc_12);
                    }
                    else if (_loc_14 == 3)
                    {
                        _loc_12 = _loc_12 * (_loc_12 * _loc_12 * _loc_12);
                    }
                    else if (_loc_14 == 4)
                    {
                        _loc_12 = _loc_12 * (_loc_12 * _loc_12 * _loc_12 * _loc_12);
                    }
                    if (_loc_13 == 1)
                    {
                        ratio = 1 - _loc_12;
                    }
                    else if (_loc_13 == 2)
                    {
                        ratio = _loc_12;
                    }
                    else if (_time / _duration < 0.5)
                    {
                        ratio = _loc_12 / 2;
                    }
                    else
                    {
                        ratio = 1 - _loc_12 / 2;
                    }
                }
                else
                {
                    ratio = _ease.getRatio(_time / _duration);
                }
            }
            if (_loc_5 == _time && !param3)
            {
                if (_loc_6 !== _totalTime)
                {
                    if (_onUpdate != null)
                    {
                        if (!param2)
                        {
                            _onUpdate.apply(vars.onUpdateScope || this, vars.onUpdateParams);
                        }
                    }
                }
                return;
            }
            else if (!_initted)
            {
                _init();
                if (!_initted)
                {
                    return;
                }
                if (_time && !_loc_8)
                {
                    ratio = _ease.getRatio(_time / _duration);
                }
                else if (_loc_8 && _ease._calcEnd)
                {
                    ratio = _ease.getRatio(_time === 0 ? (0) : (1));
                }
            }
            if (!_active)
            {
                if (!_paused)
                {
                    _active = true;
                }
            }
            if (_loc_6 == 0)
            {
                if (_startAt != null)
                {
                    if (param1 >= 0)
                    {
                        _startAt.render(param1, param2, param3);
                    }
                    else if (!_loc_9)
                    {
                        _loc_9 = "_dummyGS";
                    }
                }
                if (_totalTime != 0 || _duration == 0)
                {
                    if (!param2)
                    {
                        if (vars.onStart)
                        {
                            vars.onStart.apply(null, vars.onStartParams);
                        }
                        if (_dispatcher)
                        {
                            _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                        }
                    }
                }
            }
            _loc_10 = _firstPT;
            while (_loc_10)
            {
                
                if (_loc_10.f)
                {
                    var _loc_15:* = _loc_10.t;
                    _loc_15[_loc_10.p](_loc_10.c * ratio + _loc_10.s);
                }
                else
                {
                    _loc_15[_loc_10.p] = _loc_10.c * ratio + _loc_10.s;
                }
                _loc_10 = _loc_10._next;
            }
            if (_onUpdate != null)
            {
                if (param1 < 0 && _startAt != null)
                {
                    _startAt.render(param1, param2, param3);
                }
                if (!param2)
                {
                    _onUpdate.apply(null, vars.onUpdateParams);
                }
            }
            if (_hasUpdateListener)
            {
                if (param1 < 0 && _startAt != null && _onUpdate == null)
                {
                    _startAt.render(param1, param2, param3);
                }
                if (!param2)
                {
                    _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                }
            }
            if (_cycle != _loc_7)
            {
                if (!param2)
                {
                    if (!_gc)
                    {
                        if (vars.onRepeat)
                        {
                            vars.onRepeat.apply(null, vars.onRepeatParams);
                        }
                        if (_dispatcher)
                        {
                            _dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                        }
                    }
                }
            }
            if (_loc_9)
            {
                if (!_gc)
                {
                    if (param1 < 0 && _startAt != null && _onUpdate == null && !_hasUpdateListener)
                    {
                        _startAt.render(param1, param2, true);
                    }
                    if (_loc_8)
                    {
                        if (_timeline.autoRemoveChildren)
                        {
                            _enabled(false, false);
                        }
                        _active = false;
                    }
                    if (!param2)
                    {
                        if (vars[_loc_9])
                        {
                            vars[_loc_9].apply(null, vars[_loc_9 + "Params"]);
                        }
                        if (_dispatcher)
                        {
                            _dispatcher.dispatchEvent(new TweenEvent(_loc_9 == "onComplete" ? (TweenEvent.COMPLETE) : (TweenEvent.REVERSE_COMPLETE)));
                        }
                    }
                }
            }
            return;
        }// end function

        public function totalProgress(param1:Number = NaN)
        {
            return !arguments.length ? (_totalTime / totalDuration()) : (totalTime(totalDuration() * param1, false));
        }// end function

        public function repeat(param1:int = 0)
        {
            if (!arguments.length)
            {
                return _repeat;
            }
            _repeat = param1;
            return _uncache(true);
        }// end function

        public function updateTo(param1:Object, param2:Boolean = false)
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            var _loc_7:* = null;
            var _loc_8:* = NaN;
            var _loc_3:* = ratio;
            if (param2)
            {
                if (timeline != null)
                {
                    if (_startTime < _timeline._time)
                    {
                        _startTime = _timeline._time;
                        _uncache(false);
                        if (_gc)
                        {
                            _enabled(true, false);
                        }
                        else
                        {
                            _timeline.insert(this, _startTime - _delay);
                        }
                    }
                }
            }
            for (_loc_4 in param1)
            {
                
                this.vars[_loc_4] = _loc_10[_loc_4];
            }
            if (_initted)
            {
                if (param2)
                {
                    _initted = false;
                }
                else
                {
                    if (_notifyPluginsOfEnabled)
                    {
                        if (_firstPT != null)
                        {
                            _onPluginEvent("_onDisable", this);
                        }
                    }
                    if (_time / _duration > 0.998)
                    {
                        _loc_5 = _time;
                        render(0, true, false);
                        _initted = false;
                        render(_loc_5, true, false);
                    }
                    else if (_time > 0)
                    {
                        _initted = false;
                        _init();
                        _loc_6 = 1 / (1 - _loc_3);
                        _loc_7 = _firstPT;
                        while (_loc_7)
                        {
                            
                            _loc_8 = _loc_7.s + _loc_7.c;
                            _loc_7.c = _loc_7.c * _loc_6;
                            _loc_7.s = _loc_8 - _loc_7.c;
                            _loc_7 = _loc_7._next;
                        }
                    }
                }
            }
            return this;
        }// end function

        public function repeatDelay(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                return _repeatDelay;
            }
            _repeatDelay = param1;
            return _uncache(true);
        }// end function

        public function yoyo(param1:Boolean = false)
        {
            if (!arguments.length)
            {
                return _yoyo;
            }
            _yoyo = param1;
            return this;
        }// end function

        public function progress(param1:Number = NaN)
        {
            return !arguments.length ? (_time / duration()) : (totalTime(duration() * (_yoyo && (_cycle & 1) !== 0 ? (1 - param1) : (param1)) + _cycle * (_duration + _repeatDelay), false));
        }// end function

        protected function _initDispatcher() : Boolean
        {
            var _loc_2:* = null;
            var _loc_1:* = false;
            for (_loc_2 in _listenerLookup)
            {
                
                if (_loc_2 in vars)
                {
                    if (vars[_loc_2] is Function)
                    {
                        if (_dispatcher == null)
                        {
                            _dispatcher = new EventDispatcher(this);
                        }
                        _dispatcher.addEventListener(_loc_4[_loc_2], vars[_loc_2], false, 0, true);
                        _loc_1 = true;
                    }
                }
            }
            return _loc_1;
        }// end function

        override public function totalDuration(param1:Number = NaN)
        {
            if (!arguments.length)
            {
                if (_dirty)
                {
                    _totalDuration = _repeat == -1 ? (999999999999) : (_duration * (_repeat + 1) + _repeatDelay * _repeat);
                    _dirty = false;
                }
                return _totalDuration;
            }
            return _repeat == -1 ? (this) : (duration((param1 - _repeat * _repeatDelay) / (_repeat + 1)));
        }// end function

        public function hasEventListener(param1:String) : Boolean
        {
            return _dispatcher == null ? (false) : (_dispatcher.hasEventListener(param1));
        }// end function

        public static function resumeAll(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
        {
            _changePause(false, param1, param2, param3);
            return;
        }// end function

        public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenMax
        {
            param4 = _prepVars(param4, false);
            param3 = _prepVars(param3, false);
            param4.startAt = param3;
            param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
            return new TweenMax(param1, param2, param4);
        }// end function

        public static function staggerTo(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
        {
            var copy:Object;
            var i:int;
            var p:String;
            var targets:* = param1;
            var duration:* = param2;
            var vars:* = param3;
            var stagger:* = param4;
            var onCompleteAll:* = param5;
            var onCompleteAllParams:* = param6;
            vars = _prepVars(vars, false);
            var a:Array;
            var l:* = targets.length;
            var delay:* = vars.delay || 0;
            i;
            while (i < l)
            {
                
                copy;
                var _loc_8:* = 0;
                var _loc_9:* = vars;
                while (_loc_9 in _loc_8)
                {
                    
                    p = _loc_9[_loc_8];
                    copy[p] = _loc_9[p];
                }
                copy.delay = delay;
                if (i == (l - 1))
                {
                    if (onCompleteAll != null)
                    {
                        copy.onComplete = function () : void
            {
                if (vars.onComplete)
                {
                    vars.onComplete.apply(null, vars.onCompleteParams);
                }
                onCompleteAll.apply(null, onCompleteAllParams);
                return;
            }// end function
            ;
                    }
                }
                a[i] = new TweenMax(targets[i], duration, copy);
                delay = delay + stagger;
                i = (i + 1);
            }
            return a;
        }// end function

        public static function pauseAll(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true) : void
        {
            _changePause(true, param1, param2, param3);
            return;
        }// end function

        public static function staggerFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6:Function = null, param7:Array = null) : Array
        {
            param4 = _prepVars(param4, false);
            param3 = _prepVars(param3, false);
            param4.startAt = param3;
            param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
            return staggerTo(param1, param2, param4, param5, param6, param7);
        }// end function

        public static function getTweensOf(param1) : Array
        {
            return TweenLite.getTweensOf(param1);
        }// end function

        public static function killTweensOf(param1, param2:Object = null) : void
        {
            TweenLite.killTweensOf(param1, param2);
            return;
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenMax
        {
            return new TweenMax(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, onReverseComplete:param2, onReverseCompleteParams:param3, immediateRender:false, useFrames:param4, overwrite:0});
        }// end function

        public static function isTweening(param1:Object) : Boolean
        {
            var _loc_4:* = null;
            var _loc_2:* = TweenLite.getTweensOf(param1);
            var _loc_3:* = _loc_2.length;
            while (--_loc_3 > -1)
            {
                
                _loc_4 = _loc_2[_loc_3];
                if (_loc_4._active || _loc_4._startTime == _loc_4._timeline._time && _loc_4._timeline._active)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function killAll(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true, param4:Boolean = true) : void
        {
            var _loc_7:* = false;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_5:* = getAllTweens(param4);
            var _loc_6:* = _loc_5.length;
            var _loc_8:* = param2 && param3 && param4;
            _loc_10 = 0;
            while (_loc_10 < _loc_6)
            {
                
                _loc_9 = _loc_5[_loc_10];
                var _loc_11:* = TweenLite(_loc_9).target == TweenLite(_loc_9).vars.onComplete;
                _loc_7 = TweenLite(_loc_9).target == TweenLite(_loc_9).vars.onComplete;
                if (_loc_8 || _loc_9 is SimpleTimeline || _loc_11 && param3 || param2 && !_loc_7)
                {
                    if (param1)
                    {
                        _loc_9.totalTime(_loc_9.totalDuration());
                    }
                    else
                    {
                        _loc_9._enabled(false, false);
                    }
                }
                _loc_10++;
            }
            return;
        }// end function

        public static function killChildTweensOf(param1:DisplayObjectContainer, param2:Boolean = false) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = getAllTweens(false);
            var _loc_6:* = _loc_3.length;
            _loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_4 = _loc_3[_loc_7].target;
                if (_loc_4 is DisplayObject)
                {
                    _loc_5 = _loc_4.parent;
                    while (_loc_5)
                    {
                        
                        if (_loc_5 == param1)
                        {
                            if (param2)
                            {
                                _loc_3[_loc_7].totalTime(_loc_3[_loc_7].totalDuration());
                            }
                            else
                            {
                                _loc_3[_loc_7]._enabled(false, false);
                            }
                        }
                        _loc_5 = _loc_5.parent;
                    }
                }
                _loc_7++;
            }
            return;
        }// end function

        private static function _changePause(param1:Boolean, param2:Boolean = true, param3:Boolean = false, param4:Boolean = true) : void
        {
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_5:* = getAllTweens(param4);
            var _loc_8:* = param2 && param3 && param4;
            var _loc_9:* = _loc_5.length;
            while (--_loc_9 > -1)
            {
                
                _loc_7 = _loc_5[_loc_9];
                _loc_6 = TweenLite(_loc_7).target == _loc_7.vars.onComplete;
                if (_loc_8 || _loc_7 is SimpleTimeline || _loc_6 && param3 || param2 && !_loc_6)
                {
                    _loc_7.paused(param1);
                }
            }
            return;
        }// end function

        public static function set(param1:Object, param2:Object) : TweenMax
        {
            return new TweenMax(param1, 0, param2);
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenMax
        {
            param3 = _prepVars(param3, true);
            param3.runBackwards = true;
            return new TweenMax(param1, param2, param3);
        }// end function

        public static function killDelayedCallsTo(param1:Function) : void
        {
            TweenLite.killTweensOf(param1);
            return;
        }// end function

        public static function globalTimeScale(param1:Number = NaN) : Number
        {
            if (!arguments.length)
            {
                return _rootTimeline == null ? (1) : (_rootTimeline._timeScale);
            }
            param1 = param1 || 0.0001;
            if (_rootTimeline == null)
            {
                TweenLite.to({}, 0, {});
            }
            arguments = _rootTimeline;
            var _loc_4:* = getTimer() / 1000;
            arguments._startTime = _loc_4 - (_loc_4 - arguments._startTime) * arguments._timeScale / param1;
            arguments = _rootFramesTimeline;
            _loc_4 = _rootFrame;
            arguments._startTime = _loc_4 - (_loc_4 - arguments._startTime) * arguments._timeScale / param1;
            var _loc_5:* = param1;
            _rootTimeline._timeScale = param1;
            arguments._timeScale = _loc_5;
            return param1;
        }// end function

        public static function getAllTweens(param1:Boolean = false) : Array
        {
            var _loc_2:* = _getChildrenOf(_rootTimeline, param1);
            return _loc_2.concat(_getChildrenOf(_rootFramesTimeline, param1));
        }// end function

        static function _getChildrenOf(param1:SimpleTimeline, param2:Boolean) : Array
        {
            if (param1 == null)
            {
                return [];
            }
            var _loc_3:* = [];
            var _loc_4:* = 0;
            var _loc_5:* = param1._first;
            while (_loc_5)
            {
                
                if (_loc_5 is TweenLite)
                {
                    _loc_3[++_loc_4] = _loc_5;
                }
                else
                {
                    if (param2)
                    {
                        _loc_3[++_loc_4] = _loc_5;
                    }
                    _loc_3 = _loc_3.concat(_getChildrenOf(SimpleTimeline(_loc_5), param2));
                    _loc_4 = _loc_3.length;
                }
                _loc_5 = _loc_5._next;
            }
            return _loc_3;
        }// end function

        public static function staggerFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
        {
            param3 = _prepVars(param3, true);
            param3.runBackwards = true;
            if (param3.immediateRender != false)
            {
                param3.immediateRender = true;
            }
            return staggerTo(param1, param2, param3, param4, param5, param6);
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenMax
        {
            return new TweenMax(param1, param2, param3);
        }// end function

        TweenPlugin.activate([AutoAlphaPlugin, EndArrayPlugin, FramePlugin, RemoveTintPlugin, TintPlugin, VisiblePlugin, VolumePlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, FrameLabelPlugin, GlowFilterPlugin, HexColorsPlugin, RoundPropsPlugin, ShortRotationPlugin]);
    }
}
