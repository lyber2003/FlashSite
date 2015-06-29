package com.greensock.plugins
{
    import com.greensock.*;
    import flash.geom.*;

    public class BezierPlugin extends TweenPlugin
    {
        protected var _beziers:Object;
        protected var _length:Number;
        protected var _autoRotate:Array;
        protected var _s2:Number;
        protected var _lengths:Array;
        protected var _round:Object;
        protected var _curSeg:Array;
        protected var _prec:Number;
        protected var _segCount:int;
        protected var _timeRes:int;
        protected var _li:Number;
        protected var _func:Object;
        protected var _l1:Number;
        protected var _l2:Number;
        protected var _target:Object;
        protected var _props:Array;
        protected var _si:Number;
        protected var _s1:Number;
        protected var _segments:Array;
        static var _r3:Array = [];
        static var _r1:Array = [];
        static var _corProps:Object = {};
        static const _RAD2DEG:Number = 57.2958;
        public static const API:Number = 2;
        static var _r2:Array = [];

        public function BezierPlugin()
        {
            super("bezier");
            this._overwriteProps.pop();
            this._func = {};
            this._round = {};
            return;
        }// end function

        override public function _kill(param1:Object) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_2:* = this._props;
            for (_loc_3 in _beziers)
            {
                
                if (_loc_3 in param1)
                {
                    delete _loc_6[_loc_3];
                    delete _func[_loc_3];
                    _loc_4 = _loc_2.length;
                    while (--_loc_4 > -1)
                    {
                        
                        if (_loc_2[_loc_4] === _loc_3)
                        {
                            _loc_2.splice(_loc_4, 1);
                        }
                    }
                }
            }
            return super._kill(param1);
        }// end function

        override public function setRatio(param1:Number) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = 0;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_17:* = NaN;
            var _loc_18:* = NaN;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_22:* = NaN;
            var _loc_2:* = this._segCount;
            var _loc_3:* = this._func;
            var _loc_4:* = this._target;
            if (this._timeRes == 0)
            {
                _loc_5 = param1 < 0 ? (0) : (param1 >= 1 ? ((_loc_2 - 1)) : (_loc_2 * param1 >> 0));
                _loc_10 = (param1 - _loc_5 * (1 / _loc_2)) * _loc_2;
            }
            else
            {
                _loc_13 = this._lengths;
                _loc_14 = this._curSeg;
                param1 = param1 * this._length;
                _loc_7 = this._li;
                if (param1 > this._l2 && _loc_7 < (_loc_2 - 1))
                {
                    _loc_12 = _loc_2 - 1;
                    do
                    {
                        
                        var _loc_23:* = _loc_13[++_loc_7];
                        this._l2 = _loc_13[++_loc_7];
                    }while (_loc_7 < _loc_12 && _loc_23 <= param1)
                    this._l1 = _loc_13[++_loc_7 - 1];
                    this._li = _loc_7;
                    var _loc_23:* = this._segments[_loc_7];
                    _loc_14 = this._segments[_loc_7];
                    this._curSeg = _loc_23;
                    var _loc_23:* = 0;
                    this._si = 0;
                    this._s1 = _loc_23;
                    this._s2 = _loc_14[_loc_23];
                }
                else if (param1 < this._l1 && _loc_7 > 0)
                {
                    do
                    {
                        
                        var _loc_23:* = _loc_13[--_loc_7];
                        this._l1 = _loc_13[--_loc_7];
                    }while (_loc_7 > 0 && _loc_23 >= param1)
                    if (--_loc_7 === 0 && param1 < this._l1)
                    {
                        this._l1 = 0;
                    }
                    else
                    {
                        _loc_7++;
                    }
                    this._l2 = _loc_13[_loc_7];
                    this._li = _loc_7;
                    var _loc_23:* = this._segments[_loc_7];
                    _loc_14 = this._segments[_loc_7];
                    this._curSeg = _loc_23;
                    _loc_14.length = (_loc_14.length - 1);
                    this._si = _loc_14.length - 1;
                    this._s1 = _loc_14[_loc_14.length - 1] || 0;
                    this._s2 = _loc_14[this._si];
                }
                _loc_5 = _loc_7;
                param1 = param1 - this._l1;
                _loc_7 = this._si;
                if (param1 > this._s2 && _loc_7 < (_loc_14.length - 1))
                {
                    _loc_12 = _loc_14.length - 1;
                    do
                    {
                        
                        var _loc_23:* = _loc_14[++_loc_7];
                        this._s2 = _loc_14[++_loc_7];
                    }while (_loc_7 < _loc_12 && _loc_23 <= param1)
                    this._s1 = _loc_14[++_loc_7 - 1];
                    this._si = _loc_7;
                }
                else if (param1 < this._s1 && _loc_7 > 0)
                {
                    do
                    {
                        
                        var _loc_23:* = _loc_14[--_loc_7];
                        this._s1 = _loc_14[--_loc_7];
                    }while (_loc_7 > 0 && _loc_23 >= param1)
                    if (--_loc_7 === 0 && param1 < this._s1)
                    {
                        this._s1 = 0;
                    }
                    else
                    {
                        _loc_7++;
                    }
                    this._s2 = _loc_14[_loc_7];
                    this._si = _loc_7;
                }
                _loc_10 = (_loc_7 + (param1 - this._s1) / (this._s2 - this._s1)) * this._prec;
            }
            _loc_6 = 1 - _loc_10;
            _loc_7 = this._props.length;
            while (--_loc_7 > -1)
            {
                
                _loc_8 = this._props[_loc_7];
                _loc_9 = this._beziers[_loc_8][_loc_5];
                _loc_11 = (_loc_10 * _loc_10 * _loc_9.da + 3 * _loc_6 * (_loc_10 * _loc_9.ca + _loc_6 * _loc_9.ba)) * _loc_10 + _loc_9.a;
                if (this._round[_loc_8])
                {
                    _loc_11 = _loc_11 + (_loc_11 > 0 ? (0.5) : (-0.5)) >> 0;
                }
                if (_loc_3[_loc_8])
                {
                    var _loc_23:* = _loc_4;
                    _loc_23[_loc_8](_loc_11);
                    continue;
                }
                _loc_4[_loc_8] = _loc_11;
            }
            if (this._autoRotate != null)
            {
                _loc_15 = this._autoRotate;
                --_loc_7 = _loc_15.length;
                while (--_loc_7 > -1)
                {
                    
                    _loc_8 = _loc_15[--_loc_7][2];
                    _loc_21 = _loc_15[_loc_7][3] || 0;
                    _loc_22 = _loc_15[_loc_7][4] == true ? (1) : (_RAD2DEG);
                    _loc_9 = this._beziers[_loc_15[_loc_7][0]][_loc_5];
                    _loc_16 = this._beziers[_loc_15[_loc_7][1]][_loc_5];
                    _loc_17 = _loc_9.a + (_loc_9.b - _loc_9.a) * _loc_10;
                    _loc_19 = _loc_9.b + (_loc_9.c - _loc_9.b) * _loc_10;
                    _loc_17 = _loc_17 + (_loc_19 - _loc_17) * _loc_10;
                    _loc_19 = _loc_19 + (_loc_9.c + (_loc_9.d - _loc_9.c) * _loc_10 - _loc_19) * _loc_10;
                    _loc_18 = _loc_16.a + (_loc_16.b - _loc_16.a) * _loc_10;
                    _loc_20 = _loc_16.b + (_loc_16.c - _loc_16.b) * _loc_10;
                    _loc_18 = _loc_18 + (_loc_20 - _loc_18) * _loc_10;
                    _loc_20 = _loc_20 + (_loc_16.c + (_loc_16.d - _loc_16.c) * _loc_10 - _loc_20) * _loc_10;
                    _loc_11 = Math.atan2(_loc_20 - _loc_18, _loc_19 - _loc_17) * _loc_22 + _loc_21;
                    if (_loc_3[_loc_8])
                    {
                        var _loc_23:* = _loc_4;
                        _loc_23[_loc_8](_loc_11);
                        continue;
                    }
                    _loc_4[_loc_8] = _loc_11;
                }
            }
            return;
        }// end function

        override public function _onInitTween(param1:Object, param2, param3:TweenLite) : Boolean
        {
            var _loc_9:* = null;
            var _loc_10:* = false;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            this._target = param1;
            var _loc_4:* = param2 is Array ? ({values:param2}) : (param2);
            this._props = [];
            this._timeRes = _loc_4.timeResolution == null ? (6) : (int(_loc_4.timeResolution));
            var _loc_5:* = _loc_4.values || [];
            var _loc_6:* = {};
            var _loc_7:* = _loc_5[0];
            var _loc_8:* = _loc_4.autoRotate || param3.vars.orientToBezier;
            this._autoRotate = _loc_8 ? (_loc_8 is Array ? (_loc_8 as Array) : ([["x", "y", "rotation", _loc_8 === true ? (0) : (Number(_loc_8))]])) : (null);
            if (_loc_7 is Point)
            {
                this._props = ["x", "y"];
            }
            else
            {
                for (_loc_9 in _loc_7)
                {
                    
                    this._props.push(_loc_9);
                }
            }
            _loc_11 = this._props.length;
            while (--_loc_11 > -1)
            {
                
                _loc_9 = this._props[_loc_11];
                this._overwriteProps.push(_loc_9);
                var _loc_16:* = param1[_loc_9] is Function;
                this._func[_loc_9] = param1[_loc_9] is Function;
                _loc_10 = _loc_16;
                _loc_6[_loc_9] = !_loc_10 ? (param1[_loc_9]) : (var _loc_16:* = param1, _loc_16[_loc_9.indexOf("set") || !("get" + _loc_9.substr(3) in param1) ? (_loc_9) : ("get" + _loc_9.substr(3))]());
                if (!_loc_14)
                {
                    if (_loc_6[_loc_9] !== _loc_7[_loc_9])
                    {
                        _loc_14 = _loc_6;
                    }
                }
            }
            this._beziers = _loc_4.type !== "cubic" && _loc_4.type !== "quadratic" && _loc_4.type !== "soft" ? (bezierThrough(_loc_5, isNaN(_loc_4.curviness) ? (1) : (_loc_4.curviness), false, _loc_4.type === "thruBasic", _loc_4.correlate || "x,y,z", _loc_14)) : (_parseBezierData(_loc_5, _loc_4.type, _loc_6));
            this._segCount = this._beziers[_loc_9].length;
            if (this._timeRes)
            {
                _loc_15 = _parseLengthData(this._beziers, this._timeRes);
                this._length = _loc_15.length;
                this._lengths = _loc_15.lengths;
                this._segments = _loc_15.segments;
                var _loc_16:* = 0;
                this._si = 0;
                this._s1 = _loc_16;
                this._li = _loc_16;
                this._l1 = _loc_16;
                this._l2 = this._lengths[0];
                this._curSeg = this._segments[0];
                this._s2 = this._curSeg[0];
                this._prec = 1 / this._curSeg.length;
            }
            var _loc_16:* = this._autoRotate;
            _loc_13 = this._autoRotate;
            if (_loc_16)
            {
                if (!(_loc_13[0] is Array))
                {
                    var _loc_16:* = [_loc_13];
                    _loc_13 = [_loc_13];
                    this._autoRotate = _loc_16;
                }
                --_loc_11 = _loc_13.length;
                while (--_loc_11 > -1)
                {
                    
                    _loc_12 = 0;
                    while (_loc_12 < 3)
                    {
                        
                        _loc_9 = _loc_13[--_loc_11][_loc_12];
                        this._func[_loc_9] = param1[_loc_9] is Function ? (param1[_loc_9.indexOf("set") || !("get" + _loc_9.substr(3) in param1) ? (_loc_9) : ("get" + _loc_9.substr(3))]) : (false);
                        _loc_12++;
                    }
                }
            }
            return true;
        }// end function

        override public function _roundProps(param1:Object, param2:Boolean = true) : void
        {
            var _loc_3:* = this._overwriteProps;
            var _loc_4:* = _loc_3.length;
            while (--_loc_4 > -1)
            {
                
                if (_loc_3[_loc_4] in param1 || "bezier" in param1 || "bezierThrough" in param1)
                {
                    this._round[_loc_3[_loc_4]] = param2;
                }
            }
            return;
        }// end function

        static function _parseLengthData(param1:Object, param2:uint = 6) : Object
        {
            var _loc_10:* = null;
            var _loc_11:* = 0;
            var _loc_12:* = 0;
            var _loc_13:* = NaN;
            var _loc_3:* = [];
            var _loc_4:* = [];
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = param2 - 1;
            var _loc_8:* = [];
            var _loc_9:* = [];
            for (_loc_10 in param1)
            {
                
                _addCubicLengths(_loc_15[_loc_10], _loc_3, param2);
            }
            _loc_12 = _loc_3.length;
            _loc_11 = 0;
            while (_loc_11 < _loc_12)
            {
                
                _loc_5 = _loc_5 + Math.sqrt(_loc_3[_loc_11]);
                _loc_13 = _loc_11 % param2;
                _loc_9[_loc_13] = _loc_5;
                if (_loc_13 == _loc_7)
                {
                    _loc_6 = _loc_6 + _loc_5;
                    _loc_13 = _loc_11 / param2 >> 0;
                    _loc_8[_loc_13] = _loc_9;
                    _loc_4[_loc_13] = _loc_6;
                    _loc_5 = 0;
                    _loc_9 = [];
                }
                _loc_11++;
            }
            return {length:_loc_6, lengths:_loc_4, segments:_loc_8};
        }// end function

        public static function bezierThrough(param1:Array, param2:Number = 1, param3:Boolean = false, param4:Boolean = false, param5:String = "x,y,z", param6:Object = null) : Object
        {
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            var _loc_12:* = 0;
            var _loc_13:* = null;
            var _loc_14:* = 0;
            var _loc_15:* = NaN;
            var _loc_16:* = false;
            var _loc_17:* = null;
            var _loc_7:* = {};
            var _loc_8:* = param6 || param1[0];
            param5 = "," + param5 + ",";
            if (_loc_8 is Point)
            {
                _loc_9 = ["x", "y"];
            }
            else
            {
                _loc_9 = [];
                for (_loc_11 in _loc_8)
                {
                    
                    _loc_9.push(_loc_11);
                }
            }
            if (param1.length > 1)
            {
                _loc_17 = param1[(param1.length - 1)];
                _loc_16 = true;
                _loc_10 = _loc_9.length;
                while (--_loc_10 > -1)
                {
                    
                    _loc_11 = _loc_9[_loc_10];
                    if (Math.abs(_loc_8[_loc_11] - _loc_17[_loc_11]) > 0.05)
                    {
                        _loc_16 = false;
                        break;
                    }
                }
                if (_loc_16)
                {
                    param1 = param1.concat();
                    if (param6)
                    {
                        param1.unshift(param6);
                    }
                    param1.push(param1[1]);
                    param6 = param1[param1.length - 3];
                }
            }
            var _loc_18:* = 0;
            _r3.length = 0;
            _r2.length = _loc_18;
            _r1.length = _loc_18;
            --_loc_10 = _loc_9.length;
            while (--_loc_10 > -1)
            {
                
                _loc_11 = _loc_9[--_loc_10];
                _corProps[_loc_11] = param5.indexOf("," + _loc_11 + ",") !== -1;
                _loc_7[_loc_11] = _parseAnchors(param1, _loc_11, _corProps[_loc_11], param6);
            }
            --_loc_10 = _r1.length;
            while (--_loc_10 > -1)
            {
                
                _r1[--_loc_10] = Math.sqrt(_r1[--_loc_10]);
                _r2[_loc_10] = Math.sqrt(_r2[_loc_10]);
            }
            if (!param4)
            {
                --_loc_10 = _loc_9.length;
                while (--_loc_10 > -1)
                {
                    
                    if (_corProps[_loc_11])
                    {
                        _loc_13 = _loc_7[_loc_9[--_loc_10]];
                        _loc_14 = _loc_13.length - 1;
                        _loc_12 = 0;
                        while (_loc_12 < _loc_14)
                        {
                            
                            _loc_15 = _loc_13[(_loc_12 + 1)].da / _r2[_loc_12] + _loc_13[_loc_12].da / _r1[_loc_12];
                            _r3[_loc_12] = (_r3[_loc_12] || 0) + _loc_15 * _loc_15;
                            _loc_12++;
                        }
                    }
                }
                --_loc_10 = _r3.length;
                while (--_loc_10 > -1)
                {
                    
                    _r3[--_loc_10] = Math.sqrt(_r3[--_loc_10]);
                }
            }
            --_loc_10 = _loc_9.length;
            _loc_12 = param3 ? (4) : (1);
            while (--_loc_10 > -1)
            {
                
                _loc_11 = _loc_9[--_loc_10];
                _loc_13 = _loc_7[_loc_11];
                _calculateControlPoints(_loc_13, param2, param3, param4, _corProps[_loc_11]);
                if (_loc_16)
                {
                    _loc_13.splice(0, _loc_12);
                    _loc_13.splice(_loc_13.length - _loc_12, _loc_12);
                }
            }
            return _loc_7;
        }// end function

        private static function _addCubicLengths(param1:Array, param2:Array, param3:uint = 6) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = 0;
            var _loc_14:* = NaN;
            var _loc_15:* = null;
            var _loc_16:* = 0;
            var _loc_4:* = 1 / param3;
            var _loc_5:* = param1.length;
            while (--_loc_5 > -1)
            {
                
                _loc_15 = param1[_loc_5];
                _loc_8 = _loc_15.a;
                _loc_9 = _loc_15.d - _loc_8;
                _loc_10 = _loc_15.c - _loc_8;
                _loc_11 = _loc_15.b - _loc_8;
                var _loc_17:* = 0;
                _loc_7 = 0;
                _loc_6 = _loc_17;
                _loc_13 = 1;
                while (_loc_13 <= param3)
                {
                    
                    _loc_12 = _loc_4 * _loc_13;
                    _loc_14 = 1 - _loc_12;
                    var _loc_17:* = (_loc_12 * _loc_12 * _loc_9 + 3 * _loc_14 * (_loc_12 * _loc_10 + _loc_14 * _loc_11)) * _loc_12;
                    _loc_7 = (_loc_12 * _loc_12 * _loc_9 + 3 * _loc_14 * (_loc_12 * _loc_10 + _loc_14 * _loc_11)) * _loc_12;
                    _loc_6 = _loc_7 - _loc_17;
                    _loc_16 = _loc_5 * param3 + _loc_13 - 1;
                    param2[_loc_16] = (param2[_loc_16] || 0) + _loc_6 * _loc_6;
                    _loc_13++;
                }
            }
            return;
        }// end function

        static function _parseAnchors(param1:Array, param2:String, param3:Boolean, param4:Object) : Array
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_5:* = [];
            if (param4)
            {
                param1 = [param4].concat(param1);
                _loc_7 = param1.length;
                while (--_loc_7 > -1)
                {
                    
                    var _loc_12:* = param1[_loc_7][param2];
                    _loc_11 = param1[_loc_7][param2];
                    if (typeof(_loc_12) === "string")
                    {
                        if (_loc_11.charAt(1) === "=")
                        {
                            param1[_loc_7][param2] = param4[param2] + Number(_loc_11.charAt(0) + _loc_11.substr(2));
                        }
                    }
                }
            }
            _loc_6 = param1.length - 2;
            if (_loc_6 < 0)
            {
                _loc_5[0] = new Segment(param1[0][param2], 0, 0, param1[_loc_6 < -1 ? (0) : (1)][param2]);
                return _loc_5;
            }
            --_loc_7 = 0;
            while (_loc_7 < _loc_6)
            {
                
                _loc_8 = param1[--_loc_7][param2];
                _loc_9 = param1[(_loc_7 + 1)][param2];
                _loc_5[_loc_7] = new Segment(_loc_8, 0, 0, _loc_9);
                if (param3)
                {
                    _loc_10 = param1[_loc_7 + 2][param2];
                    _r1[_loc_7] = (_r1[_loc_7] || 0) + (_loc_9 - _loc_8) * (_loc_9 - _loc_8);
                    _r2[_loc_7] = (_r2[_loc_7] || 0) + (_loc_10 - _loc_9) * (_loc_10 - _loc_9);
                }
                _loc_7++;
            }
            _loc_5[_loc_7] = new Segment(param1[_loc_7][param2], 0, 0, param1[(_loc_7 + 1)][param2]);
            return _loc_5;
        }// end function

        public static function cubicToQuadratic(param1:Number, param2:Number, param3:Number, param4:Number) : Array
        {
            var _loc_5:* = {a:param1};
            var _loc_6:* = {};
            var _loc_7:* = {};
            var _loc_8:* = {c:param4};
            var _loc_9:* = (param1 + param2) / 2;
            var _loc_10:* = (param2 + param3) / 2;
            var _loc_11:* = (param3 + param4) / 2;
            var _loc_12:* = (_loc_9 + _loc_10) / 2;
            var _loc_13:* = (_loc_10 + _loc_11) / 2;
            var _loc_14:* = ((_loc_10 + _loc_11) / 2 - _loc_12) / 8;
            _loc_5.b = _loc_9 + (param1 - _loc_9) / 4;
            _loc_6.b = _loc_12 + _loc_14;
            var _loc_15:* = (_loc_5.b + _loc_6.b) / 2;
            _loc_6.a = (_loc_5.b + _loc_6.b) / 2;
            _loc_5.c = _loc_15;
            var _loc_15:* = (_loc_12 + _loc_13) / 2;
            _loc_7.a = (_loc_12 + _loc_13) / 2;
            _loc_6.c = _loc_15;
            _loc_7.b = _loc_13 - _loc_14;
            _loc_8.b = _loc_11 + (param4 - _loc_11) / 4;
            var _loc_15:* = (_loc_7.b + _loc_8.b) / 2;
            _loc_8.a = (_loc_7.b + _loc_8.b) / 2;
            _loc_7.c = _loc_15;
            return [_loc_5, _loc_6, _loc_7, _loc_8];
        }// end function

        public static function quadraticToCubic(param1:Number, param2:Number, param3:Number) : Object
        {
            return new Segment(param1, (2 * param2 + param1) / 3, (2 * param2 + param3) / 3, param3);
        }// end function

        static function _calculateControlPoints(param1:Array, param2:Number = 1, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) : void
        {
            var _loc_9:* = 0;
            var _loc_10:* = NaN;
            var _loc_11:* = NaN;
            var _loc_12:* = NaN;
            var _loc_13:* = null;
            var _loc_14:* = NaN;
            var _loc_15:* = NaN;
            var _loc_16:* = NaN;
            var _loc_17:* = NaN;
            var _loc_18:* = null;
            var _loc_19:* = NaN;
            var _loc_20:* = NaN;
            var _loc_21:* = NaN;
            var _loc_6:* = param1.length - 1;
            var _loc_7:* = 0;
            var _loc_8:* = param1[0].a;
            _loc_9 = 0;
            while (_loc_9 < _loc_6)
            {
                
                _loc_13 = param1[_loc_7];
                _loc_10 = _loc_13.a;
                _loc_11 = _loc_13.d;
                _loc_12 = param1[(_loc_7 + 1)].d;
                if (param5)
                {
                    _loc_19 = _r1[_loc_9];
                    _loc_20 = _r2[_loc_9];
                    _loc_21 = (_loc_20 + _loc_19) * param2 * 0.25 / (0.5 || (param4 ? (_r3[_loc_9]) : (0.5)));
                    _loc_14 = _loc_11 - (_loc_11 - _loc_10) * (param4 ? (param2 * 0.5) : (_loc_21 / _loc_19));
                    _loc_15 = _loc_11 + (_loc_12 - _loc_11) * (param4 ? (param2 * 0.5) : (_loc_21 / _loc_20));
                    _loc_16 = _loc_11 - (_loc_14 + (_loc_15 - _loc_14) * (_loc_19 * 3 / (_loc_19 + _loc_20) + 0.5) / 4);
                }
                else
                {
                    _loc_14 = _loc_11 - (_loc_11 - _loc_10) * param2 * 0.5;
                    _loc_15 = _loc_11 + (_loc_12 - _loc_11) * param2 * 0.5;
                    _loc_16 = _loc_11 - (_loc_14 + _loc_15) / 2;
                }
                _loc_14 = _loc_14 + _loc_16;
                _loc_15 = _loc_15 + _loc_16;
                var _loc_22:* = _loc_14;
                _loc_17 = _loc_14;
                _loc_13.c = _loc_22;
                if (_loc_9 != 0)
                {
                    _loc_13.b = _loc_8;
                }
                else
                {
                    var _loc_22:* = _loc_13.a + (_loc_13.c - _loc_13.a) * 0.6;
                    _loc_8 = _loc_13.a + (_loc_13.c - _loc_13.a) * 0.6;
                    _loc_13.b = _loc_22;
                }
                _loc_13.da = _loc_11 - _loc_10;
                _loc_13.ca = _loc_17 - _loc_10;
                _loc_13.ba = _loc_8 - _loc_10;
                if (param3)
                {
                    _loc_18 = cubicToQuadratic(_loc_10, _loc_8, _loc_17, _loc_11);
                    param1.splice(_loc_7, 1, _loc_18[0], _loc_18[1], _loc_18[2], _loc_18[3]);
                    _loc_7 = _loc_7 + 4;
                }
                else
                {
                    _loc_7++;
                }
                _loc_8 = _loc_15;
                _loc_9++;
            }
            _loc_13 = param1[_loc_7];
            _loc_13.b = _loc_8;
            _loc_13.c = _loc_8 + (_loc_13.d - _loc_8) * 0.4;
            _loc_13.da = _loc_13.d - _loc_13.a;
            _loc_13.ca = _loc_13.c - _loc_13.a;
            _loc_13.ba = _loc_8 - _loc_13.a;
            if (param3)
            {
                _loc_18 = cubicToQuadratic(_loc_13.a, _loc_8, _loc_13.c, _loc_13.d);
                param1.splice(_loc_7, 1, _loc_18[0], _loc_18[1], _loc_18[2], _loc_18[3]);
            }
            return;
        }// end function

        public static function _parseBezierData(param1:Array, param2:String, param3:Object = null) : Object
        {
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = 0;
            var _loc_14:* = 0;
            var _loc_15:* = 0;
            var _loc_16:* = null;
            var _loc_17:* = 0;
            var _loc_18:* = null;
            param2 = param2 || "soft";
            var _loc_4:* = {};
            var _loc_5:* = param2 === "cubic" ? (3) : (2);
            var _loc_6:* = param2 === "soft";
            if (param2 === "soft" && param3)
            {
                param1 = [param3].concat(param1);
            }
            if (param1 == null || param1.length < (_loc_5 + 1))
            {
                throw new Error("invalid Bezier data");
            }
            if (param1[1] is Point)
            {
                _loc_12 = ["x", "y"];
            }
            else
            {
                _loc_12 = [];
                for (_loc_16 in param1[0])
                {
                    
                    _loc_12.push(_loc_16);
                }
            }
            _loc_13 = _loc_12.length;
            while (--_loc_13 > -1)
            {
                
                _loc_16 = _loc_12[_loc_13];
                var _loc_19:* = [];
                _loc_11 = [];
                _loc_4[_loc_16] = _loc_19;
                _loc_17 = 0;
                _loc_15 = param1.length;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_7 = param3 == null ? (param1[_loc_14][_loc_16]) : (var _loc_19:* = param1[_loc_14][_loc_16], _loc_18 = param1[_loc_14][_loc_16], typeof(_loc_19) === "string" && _loc_18.charAt(1) === "=" ? (param3[_loc_16] + Number(_loc_18.charAt(0) + _loc_18.substr(2))) : (Number(_loc_18)));
                    if (_loc_6)
                    {
                        if (_loc_14 > 1)
                        {
                            if (_loc_14 < (_loc_15 - 1))
                            {
                                _loc_11[++_loc_17] = (_loc_7 + _loc_11[_loc_17 - 2]) / 2;
                            }
                        }
                    }
                    _loc_11[++_loc_17] = _loc_7;
                    _loc_14++;
                }
                _loc_15 = _loc_17 - _loc_5 + 1;
                _loc_17 = 0;
                _loc_14 = 0;
                while (_loc_14 < _loc_15)
                {
                    
                    _loc_7 = _loc_11[_loc_14];
                    _loc_8 = _loc_11[(_loc_14 + 1)];
                    _loc_9 = _loc_11[_loc_14 + 2];
                    _loc_10 = _loc_5 === 2 ? (0) : (_loc_11[_loc_14 + 3]);
                    _loc_11[++_loc_17] = _loc_5 === 3 ? (new Segment(_loc_7, _loc_8, _loc_9, _loc_10)) : (new Segment(_loc_7, (2 * _loc_8 + _loc_7) / 3, (2 * _loc_8 + _loc_9) / 3, _loc_9));
                    _loc_14 = _loc_14 + _loc_5;
                }
                _loc_11.length = _loc_17;
            }
            return _loc_4;
        }// end function

    }
}

import com.greensock.*;

import flash.geom.*;

class Segment extends Object
{
    public var a:Number;
    public var c:Number;
    public var b:Number;
    public var d:Number;
    public var da:Number;
    public var ca:Number;
    public var ba:Number;

    function Segment(param1:Number, param2:Number, param3:Number, param4:Number)
    {
        this.a = param1;
        this.b = param2;
        this.c = param3;
        this.d = param4;
        this.da = param4 - param1;
        this.ca = param3 - param1;
        this.ba = param2 - param1;
        return;
    }// end function

}

