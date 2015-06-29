package com.greensock
{
    import com.greensock.core.*;
    import com.greensock.easing.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class TweenLite extends Animation
    {
        protected var _targets:Array;
        public var ratio:Number;
        protected var _overwrite:int;
        public var _ease:Ease;
        protected var _siblings:Array;
        public var target:Object;
        protected var _overwrittenProps:Object;
        public var _propLookup:Object;
        protected var _easeType:int;
        protected var _notifyPluginsOfEnabled:Boolean;
        public var _firstPT:PropTween;
        protected var _startAt:TweenLite;
        protected var _easePower:int;
        static var _tweenLookup:Dictionary = new Dictionary(false);
        public static var _onPluginEvent:Function;
        public static var ticker:Shape = Animation.ticker;
        public static var defaultEase:Ease = new Ease(null, null, 1, 1);
        public static var defaultOverwrite:String = "auto";
        public static const version:String = "12.0.5";
        public static var _plugins:Object = {};
        static var _overwriteLookup:Object;
        static var _reservedProps:Object = {ease:1, delay:1, overwrite:1, onComplete:1, onCompleteParams:1, onCompleteScope:1, useFrames:1, runBackwards:1, startAt:1, onUpdate:1, onUpdateParams:1, onUpdateScope:1, onStart:1, onStartParams:1, onStartScope:1, onReverseComplete:1, onReverseCompleteParams:1, onReverseCompleteScope:1, onRepeat:1, onRepeatParams:1, onRepeatScope:1, easeParams:1, yoyo:1, onCompleteListener:1, onUpdateListener:1, onStartListener:1, onReverseCompleteListener:1, onRepeatListener:1, orientToBezier:1, immediateRender:1, repeat:1, repeatDelay:1, data:1, paused:1, reversed:1};

        public function TweenLite(param1:Object, param2:Number, param3:Object)
        {
            var _loc_4:* = 0;
            super(param2, param3);
            if (param1 == null)
            {
                throw new Error("Cannot tween a null object. Duration: " + param2 + ", data: " + this.data);
            }
            if (!_overwriteLookup)
            {
                _overwriteLookup = {none:0, all:1, auto:2, concurrent:3, allOnStart:4, preexisting:5, true:1, false:0};
                ticker.addEventListener("enterFrame", _dumpGarbage, false, -1, true);
            }
            ratio = 0;
            this.target = param1;
            _ease = defaultEase;
            _overwrite = !("overwrite" in this.vars) ? (_overwriteLookup[defaultOverwrite]) : (typeof(this.vars.overwrite) === "number" ? (this.vars.overwrite >> 0) : (_overwriteLookup[this.vars.overwrite]));
            if (this.target is Array && typeof(this.target[0]) === "object")
            {
                _targets = this.target.concat();
                _propLookup = [];
                _siblings = [];
                _loc_4 = _targets.length;
                while (--_loc_4 > -1)
                {
                    
                    _siblings[_loc_4] = _register(_targets[_loc_4], this, false);
                    if (_overwrite == 1)
                    {
                        if (_siblings[_loc_4].length > 1)
                        {
                            _applyOverwrite(_targets[_loc_4], this, null, 1, _siblings[_loc_4]);
                        }
                    }
                }
            }
            else
            {
                _propLookup = {};
                _siblings = _tweenLookup[param1];
                if (_siblings == null)
                {
                    var _loc_5:* = [this];
                    _tweenLookup[param1] = [this];
                    _siblings = _loc_5;
                }
                else
                {
                    _siblings[_siblings.length] = this;
                    if (_overwrite == 1)
                    {
                        _applyOverwrite(param1, this, null, 1, _siblings);
                    }
                }
            }
            if (this.vars.immediateRender || param2 == 0 && _delay == 0 && this.vars.immediateRender != false)
            {
                render(-_delay, false, true);
            }
            return;
        }// end function

        protected function _initProps(param1:Object, param2:Object, param3:Array, param4:Object) : Boolean
        {
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (param1 == null)
            {
                return false;
            }
            for (_loc_5 in vars)
            {
                
                if (_loc_5 in _reservedProps)
                {
                    if (_loc_5 === "onStartParams" || _loc_5 === "onUpdateParams" || _loc_5 === "onCompleteParams" || _loc_5 === "onReverseCompleteParams" || _loc_5 === "onRepeatParams")
                    {
                        _loc_9 = _loc_11[_loc_5];
                        if (_loc_9 != null)
                        {
                            _loc_6 = _loc_9.length;
                            while (--_loc_6 > -1)
                            {
                                
                                if (_loc_9[_loc_6] === "{self}")
                                {
                                    var _loc_12:* = _loc_9.concat();
                                    _loc_11[_loc_5] = _loc_9.concat();
                                    _loc_9 = _loc_12;
                                    _loc_9[_loc_6] = this;
                                }
                            }
                        }
                    }
                    continue;
                }
                var _loc_12:* = new _plugins[_loc_5];
                _loc_8 = new _plugins[_loc_5];
                if (_loc_5 in _plugins && _loc_12._onInitTween(param1, _loc_11[_loc_5], this))
                {
                    _firstPT = new PropTween(_loc_8, "setRatio", 0, 1, _loc_5, true, _firstPT, _loc_8._priority);
                    --_loc_6 = _loc_8._overwriteProps.length;
                    while (--_loc_6 > -1)
                    {
                        
                        param2[_loc_8._overwriteProps[--_loc_6]] = _firstPT;
                    }
                    if (_loc_8._priority || "_onInitAllProps" in _loc_8)
                    {
                        _loc_7 = true;
                    }
                    if ("_onDisable" in _loc_8 || "_onEnable" in _loc_8)
                    {
                        _notifyPluginsOfEnabled = true;
                    }
                    continue;
                }
                var _loc_12:* = new PropTween(param1, _loc_5, 0, 1, _loc_5, false, _firstPT);
                param2[_loc_5] = new PropTween(param1, _loc_5, 0, 1, _loc_5, false, _firstPT);
                _firstPT = _loc_12;
                _firstPT.s = !_firstPT.f ? (Number(param1[_loc_5])) : (var _loc_12:* = param1, _loc_12[_loc_5.indexOf("set") || !("get" + _loc_5.substr(3) in param1) ? (_loc_5) : ("get" + _loc_5.substr(3))]());
                _firstPT.c = Number(_loc_11[_loc_5]) - _firstPT.s || (typeof(_loc_11[_loc_5]) === "number" ? (int(_loc_11[_loc_5].charAt(0) + "1") * Number(_loc_11[_loc_5].substr(2))) : (typeof(_loc_11[_loc_5]) === "string" && _loc_11[_loc_5].charAt(1) === "=" ? (Number(_loc_11[_loc_5])) : (0)));
            }
            if (param4)
            {
                if (_kill(param4, param1))
                {
                    return _initProps(param1, param2, param3, param4);
                }
            }
            if (_overwrite > 1)
            {
                if (_firstPT != null)
                {
                    if (param3.length > 1)
                    {
                        if (_applyOverwrite(param1, this, param2, _overwrite, param3))
                        {
                            _kill(param2, param1);
                            return _initProps(param1, param2, param3, param4);
                        }
                    }
                }
            }
            return _loc_7;
        }// end function

        override public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
        {
            var _loc_3:* = 0;
            if (param1 && _gc)
            {
                if (_targets)
                {
                    _loc_3 = _targets.length;
                    while (--_loc_3 > -1)
                    {
                        
                        _siblings[_loc_3] = _register(_targets[_loc_3], this, true);
                    }
                }
                else
                {
                    _siblings = _register(target, this, true);
                }
            }
            super._enabled(param1, param2);
            if (_notifyPluginsOfEnabled)
            {
                if (_firstPT != null)
                {
                    return _onPluginEvent(param1 ? ("_onEnable") : ("_onDisable"), this);
                }
            }
            return false;
        }// end function

        override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
        {
            var _loc_4:* = false;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_8:* = NaN;
            var _loc_7:* = _time;
            if (param1 >= _duration)
            {
                var _loc_9:* = _duration;
                _time = _duration;
                _totalTime = _loc_9;
                ratio = _ease._calcEnd ? (_ease.getRatio(1)) : (1);
                if (!_reversed)
                {
                    _loc_4 = true;
                    _loc_5 = "onComplete";
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
                var _loc_9:* = 0;
                _time = 0;
                _totalTime = _loc_9;
                ratio = _ease._calcEnd ? (_ease.getRatio(0)) : (0);
                if (_loc_7 != 0 || _duration == 0 && _rawPrevTime > 0)
                {
                    _loc_5 = "onReverseComplete";
                    _loc_4 = _reversed;
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
                var _loc_9:* = param1;
                _time = param1;
                _totalTime = _loc_9;
                if (_easeType)
                {
                    _loc_8 = param1 / _duration;
                    if (_easeType == 1 || _easeType == 3 && _loc_8 >= 0.5)
                    {
                        _loc_8 = 1 - _loc_8;
                    }
                    if (_easeType == 3)
                    {
                        _loc_8 = _loc_8 * 2;
                    }
                    if (_easePower == 1)
                    {
                        _loc_8 = _loc_8 * _loc_8;
                    }
                    else if (_easePower == 2)
                    {
                        _loc_8 = _loc_8 * (_loc_8 * _loc_8);
                    }
                    else if (_easePower == 3)
                    {
                        _loc_8 = _loc_8 * (_loc_8 * _loc_8 * _loc_8);
                    }
                    else if (_easePower == 4)
                    {
                        _loc_8 = _loc_8 * (_loc_8 * _loc_8 * _loc_8 * _loc_8);
                    }
                    if (_easeType == 1)
                    {
                        ratio = 1 - _loc_8;
                    }
                    else if (_easeType == 2)
                    {
                        ratio = _loc_8;
                    }
                    else if (param1 / _duration < 0.5)
                    {
                        ratio = _loc_8 / 2;
                    }
                    else
                    {
                        ratio = 1 - _loc_8 / 2;
                    }
                }
                else
                {
                    ratio = _ease.getRatio(param1 / _duration);
                }
            }
            if (_time == _loc_7 && !param3)
            {
                return;
            }
            if (!_initted)
            {
                _init();
                if (!_initted)
                {
                    return;
                }
                if (_time && !_loc_4)
                {
                    ratio = _ease.getRatio(_time / _duration);
                }
                else if (_loc_4 && _ease._calcEnd)
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
            if (_loc_7 == 0)
            {
                if (_startAt != null)
                {
                    if (param1 >= 0)
                    {
                        _startAt.render(param1, param2, param3);
                    }
                    else if (!_loc_5)
                    {
                        _loc_5 = "_dummyGS";
                    }
                }
                if (vars.onStart)
                {
                    if (_time != 0 || _duration == 0)
                    {
                        if (!param2)
                        {
                            vars.onStart.apply(null, vars.onStartParams);
                        }
                    }
                }
            }
            _loc_6 = _firstPT;
            while (_loc_6)
            {
                
                if (_loc_6.f)
                {
                    var _loc_9:* = _loc_6.t;
                    _loc_9[_loc_6.p](_loc_6.c * ratio + _loc_6.s);
                }
                else
                {
                    _loc_9[_loc_6.p] = _loc_6.c * ratio + _loc_6.s;
                }
                _loc_6 = _loc_6._next;
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
            if (_loc_5)
            {
                if (!_gc)
                {
                    if (param1 < 0 && _startAt != null && _onUpdate == null)
                    {
                        _startAt.render(param1, param2, param3);
                    }
                    if (_loc_4)
                    {
                        if (_timeline.autoRemoveChildren)
                        {
                            _enabled(false, false);
                        }
                        _active = false;
                    }
                    if (!param2)
                    {
                        if (vars[_loc_5])
                        {
                            vars[_loc_5].apply(null, vars[_loc_5 + "Params"]);
                        }
                    }
                }
            }
            return;
        }// end function

        protected function _init() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = false;
            var _loc_3:* = null;
            if (vars.startAt)
            {
                vars.startAt.overwrite = 0;
                vars.startAt.immediateRender = true;
                _startAt = new TweenLite(target, 0, vars.startAt);
                if (vars.immediateRender)
                {
                    _startAt = null;
                    if (_time === 0 && _duration !== 0)
                    {
                        return;
                    }
                }
            }
            else if (vars.runBackwards && vars.immediateRender && _duration !== 0)
            {
                if (_startAt != null)
                {
                    _startAt.render(-1, true);
                    _startAt = null;
                }
                else if (_time === 0)
                {
                    var _loc_4:* = 0;
                    vars.delay = 0;
                    vars.overwrite = _loc_4;
                    vars.runBackwards = false;
                    _startAt = new TweenLite(target, 0, vars);
                    vars.overwrite = _overwrite;
                    vars.runBackwards = true;
                    vars.delay = _delay;
                    return;
                }
            }
            if (vars.ease is Ease)
            {
                _ease = vars.easeParams is Array ? (vars.ease.config.apply(vars.ease, vars.easeParams)) : (vars.ease);
            }
            else if (typeof(vars.ease) === "function")
            {
                _ease = new Ease(vars.ease, vars.easeParams);
            }
            else
            {
                _ease = defaultEase;
            }
            _easeType = _ease._type;
            _easePower = _ease._power;
            _firstPT = null;
            if (_targets)
            {
                _loc_1 = _targets.length;
                while (--_loc_1 > -1)
                {
                    
                    var _loc_4:* = {};
                    _propLookup[_loc_1] = {};
                    if (_initProps(_targets[_loc_1], _loc_4, _siblings[_loc_1], _overwrittenProps ? (_overwrittenProps[_loc_1]) : (null)))
                    {
                        _loc_2 = true;
                    }
                }
            }
            else
            {
                _loc_2 = _initProps(target, _propLookup, _siblings, _overwrittenProps);
            }
            if (_loc_2)
            {
                _onPluginEvent("_onInitAllProps", this);
            }
            if (_overwrittenProps)
            {
                if (_firstPT == null)
                {
                    if (typeof(target) !== "function")
                    {
                        _enabled(false, false);
                    }
                }
            }
            if (vars.runBackwards)
            {
                _loc_3 = _firstPT;
                while (_loc_3)
                {
                    
                    _loc_3.s = _loc_3.s + _loc_3.c;
                    _loc_3.c = -_loc_3.c;
                    _loc_3 = _loc_3._next;
                }
            }
            _onUpdate = vars.onUpdate;
            _initted = true;
            return;
        }// end function

        override public function invalidate()
        {
            if (_notifyPluginsOfEnabled)
            {
                _onPluginEvent("_onDisable", this);
            }
            _firstPT = null;
            _overwrittenProps = null;
            _onUpdate = null;
            _startAt = null;
            var _loc_1:* = false;
            _notifyPluginsOfEnabled = false;
            _active = _loc_1;
            _initted = _loc_1;
            _propLookup = _targets ? ({}) : ([]);
            return this;
        }// end function

        override public function _kill(param1:Object = null, param2:Object = null) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = false;
            var _loc_9:* = null;
            var _loc_10:* = false;
            if (param1 === "all")
            {
                param1 = null;
            }
            if (param1 == null)
            {
                if (param2 == null || param2 == this.target)
                {
                    return _enabled(false, false);
                }
            }
            param2 = param2 || _targets || this.target;
            if (param2 is Array && typeof(param2[0]) === "object")
            {
                _loc_3 = param2.length;
                while (--_loc_3 > -1)
                {
                    
                    if (_kill(param1, param2[_loc_3]))
                    {
                        _loc_8 = true;
                    }
                }
            }
            else
            {
                if (_targets)
                {
                    --_loc_3 = _targets.length;
                    while (--_loc_3 > -1)
                    {
                        
                        if (param2 === _targets[--_loc_3])
                        {
                            _loc_7 = _propLookup[_loc_3] || {};
                            _overwrittenProps = _overwrittenProps || [];
                            var _loc_11:* = param1 ? (_overwrittenProps[_loc_3] || {}) : ("all");
                            _overwrittenProps[_loc_3] = param1 ? (_overwrittenProps[_loc_3] || {}) : ("all");
                            _loc_4 = _loc_11;
                            break;
                        }
                    }
                }
                else
                {
                    if (param2 !== this.target)
                    {
                        return false;
                    }
                    _loc_7 = _propLookup;
                    var _loc_11:* = param1 ? (_overwrittenProps || {}) : ("all");
                    _overwrittenProps = param1 ? (_overwrittenProps || {}) : ("all");
                    _loc_4 = _loc_11;
                }
                if (_loc_7)
                {
                    _loc_9 = param1 || _loc_7;
                    _loc_10 = param1 != _loc_4 && _loc_4 != "all" && param1 != _loc_7 && (param1 == null || param1._tempKill != true);
                    for (_loc_5 in _loc_9)
                    {
                        
                        _loc_6 = _loc_7[_loc_5];
                        if (_loc_6 != null)
                        {
                            if (_loc_6.pg && _loc_6.t._kill(_loc_9))
                            {
                                _loc_8 = true;
                            }
                            if (!_loc_6.pg || _loc_6.t._overwriteProps.length === 0)
                            {
                                if (_loc_6._prev)
                                {
                                    _loc_6._prev._next = _loc_6._next;
                                }
                                else if (_loc_6 == _firstPT)
                                {
                                    _firstPT = _loc_6._next;
                                }
                                if (_loc_6._next)
                                {
                                    _loc_6._next._prev = _loc_6._prev;
                                }
                                var _loc_13:* = null;
                                _loc_6._prev = null;
                                _loc_6._next = _loc_13;
                            }
                            delete _loc_7[_loc_5];
                        }
                        if (_loc_10)
                        {
                            _loc_4[_loc_5] = 1;
                        }
                    }
                    if (_firstPT == null)
                    {
                        _enabled(false, false);
                    }
                }
            }
            return _loc_8;
        }// end function

        public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenLite
        {
            param4 = _prepVars(param4, true);
            param3 = _prepVars(param3);
            param4.startAt = param3;
            param4.immediateRender = param4.immediateRender != false && param3.immediateRender != false;
            return new TweenLite(param1, param2, param4);
        }// end function

        public static function getTweensOf(param1) : Array
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            if (param1 is Array && typeof(param1[0]) != "string" && typeof(param1[0]) != "number")
            {
                _loc_2 = param1.length;
                _loc_3 = [];
                while (--_loc_2 > -1)
                {
                    
                    _loc_3 = _loc_3.concat(getTweensOf(param1[_loc_2]));
                }
                --_loc_2 = _loc_3.length;
                while (--_loc_2 > -1)
                {
                    
                    _loc_5 = _loc_3[--_loc_2];
                    _loc_4 = _loc_2;
                    while (--_loc_4 > -1)
                    {
                        
                        if (_loc_5 === _loc_3[_loc_4])
                        {
                            _loc_3.splice(_loc_2, 1);
                        }
                    }
                }
            }
            else
            {
                _loc_3 = _register(param1).concat();
                --_loc_2 = _loc_3.length;
                while (--_loc_2 > -1)
                {
                    
                    if (_loc_5._gc)
                    {
                        _loc_3.splice(_loc_2, 1);
                    }
                }
            }
            return _loc_3;
        }// end function

        static function _register(param1:Object, param2:TweenLite = null, param3:Boolean = false) : Array
        {
            var _loc_5:* = 0;
            var _loc_4:* = _tweenLookup[param1];
            if (_tweenLookup[param1] == null)
            {
                var _loc_6:* = [];
                _tweenLookup[param1] = [];
                _loc_4 = _loc_6;
            }
            if (param2)
            {
                _loc_5 = _loc_4.length;
                _loc_4[_loc_5] = param2;
                if (param3)
                {
                    while (--_loc_5 > -1)
                    {
                        
                        if (_loc_4[_loc_5] === param2)
                        {
                            _loc_4.splice(_loc_5, 1);
                        }
                    }
                }
            }
            return _loc_4;
        }// end function

        static function _applyOverwrite(param1:Object, param2:TweenLite, param3:Object, param4:int, param5:Array) : Boolean
        {
            var _loc_6:* = 0;
            var _loc_7:* = false;
            var _loc_8:* = null;
            var _loc_13:* = NaN;
            var _loc_14:* = 0;
            if (param4 == 1 || param4 >= 4)
            {
                _loc_14 = param5.length;
                _loc_6 = 0;
                while (_loc_6 < _loc_14)
                {
                    
                    _loc_8 = param5[_loc_6];
                    if (_loc_8 != param2)
                    {
                        if (!_loc_8._gc)
                        {
                            if (_loc_8._enabled(false, false))
                            {
                                _loc_7 = true;
                            }
                        }
                    }
                    else if (param4 == 5)
                    {
                        break;
                    }
                    _loc_6++;
                }
                return _loc_7;
            }
            var _loc_9:* = param2._startTime + 1e-010;
            var _loc_10:* = [];
            var _loc_11:* = 0;
            var _loc_12:* = param2._duration == 0;
            _loc_6 = param5.length;
            while (--_loc_6 > -1)
            {
                
                _loc_8 = param5[_loc_6];
                if (_loc_8 === param2 || _loc_8._gc || _loc_8._paused)
                {
                    continue;
                }
                if (_loc_8._timeline != param2._timeline)
                {
                    _loc_13 = _loc_13 || _checkOverlap(param2, 0, _loc_12);
                    if (_checkOverlap(_loc_8, _loc_13, _loc_12) === 0)
                    {
                        _loc_10[++_loc_11] = _loc_8;
                    }
                    continue;
                }
                if (_loc_8._startTime <= _loc_9)
                {
                    if (_loc_8._startTime + _loc_8.totalDuration() / _loc_8._timeScale + 1e-010 > _loc_9)
                    {
                        if (!((_loc_12 || !_loc_8._initted) && _loc_9 - _loc_8._startTime <= 2e-010))
                        {
                            _loc_10[++_loc_11] = _loc_8;
                        }
                    }
                }
            }
            --_loc_6 = _loc_11;
            while (--_loc_6 > -1)
            {
                
                _loc_8 = _loc_10[--_loc_6];
                if (param4 == 2)
                {
                    if (_loc_8._kill(param3, param1))
                    {
                        _loc_7 = true;
                    }
                }
                if (param4 !== 2 || !_loc_8._firstPT && _loc_8._initted)
                {
                    if (_loc_8._enabled(false, false))
                    {
                        _loc_7 = true;
                    }
                }
            }
            return _loc_7;
        }// end function

        public static function killTweensOf(param1, param2:Object = null) : void
        {
            var _loc_3:* = getTweensOf(param1);
            var _loc_4:* = _loc_3.length;
            while (--_loc_4 > -1)
            {
                
                TweenLite.TweenLite(_loc_3[_loc_4])._kill(param2, param1);
            }
            return;
        }// end function

        static function _prepVars(param1:Object, param2:Boolean = false) : Object
        {
            if (param1._isGSVars)
            {
                param1 = param1.vars;
            }
            if (param2 && !("immediateRender" in param1))
            {
                param1.immediateRender = true;
            }
            return param1;
        }// end function

        public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenLite
        {
            return new TweenLite(param2, 0, {delay:param1, onComplete:param2, onCompleteParams:param3, onReverseComplete:param2, onReverseCompleteParams:param3, immediateRender:false, useFrames:param4, overwrite:0});
        }// end function

        public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            param3 = _prepVars(param3, true);
            param3.runBackwards = true;
            return new TweenLite(param1, param2, param3);
        }// end function

        public static function killDelayedCallsTo(param1:Function) : void
        {
            killTweensOf(param1);
            return;
        }// end function

        public static function set(param1:Object, param2:Object) : TweenLite
        {
            return new TweenLite(param1, 0, param2);
        }// end function

        private static function _dumpGarbage(event:Event) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (_rootFrame / 60 >> 0 === _rootFrame / 60)
            {
                for (_loc_4 in _tweenLookup)
                {
                    
                    _loc_3 = _loc_6[_loc_4];
                    _loc_2 = _loc_3.length;
                    while (--_loc_2 > -1)
                    {
                        
                        if (_loc_3[_loc_2]._gc)
                        {
                            _loc_3.splice(_loc_2, 1);
                        }
                    }
                    if (_loc_3.length === 0)
                    {
                        delete _loc_6[_loc_4];
                    }
                }
            }
            return;
        }// end function

        public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
        {
            return new TweenLite(param1, param2, param3);
        }// end function

        private static function _checkOverlap(param1:Animation, param2:Number, param3:Boolean) : Number
        {
            var _loc_4:* = param1._timeline;
            var _loc_5:* = _loc_4._timeScale;
            var _loc_6:* = param1._startTime;
            while (_loc_4._timeline)
            {
                
                _loc_6 = _loc_6 + _loc_4._startTime;
                _loc_5 = _loc_5 * _loc_4._timeScale;
                if (_loc_4._paused)
                {
                    return -100;
                }
                _loc_4 = _loc_4._timeline;
            }
            _loc_6 = _loc_6 / _loc_5;
            return _loc_6 > param2 ? (_loc_6 - param2) : (param3 && _loc_6 == param2 || !param1._initted && _loc_6 - param2 < 2e-010 ? (1e-010) : (var _loc_7:* = _loc_6 + param1.totalDuration() / param1._timeScale / _loc_5, _loc_6 = _loc_6 + param1.totalDuration() / param1._timeScale / _loc_5, _loc_7 > param2 ? (0) : (_loc_6 - param2 - 1e-010)));
        }// end function

    }
}
