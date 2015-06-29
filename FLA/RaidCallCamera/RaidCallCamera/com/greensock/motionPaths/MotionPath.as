package com.greensock.motionPaths
{
    import flash.display.*;
    import flash.events.*;

    public class MotionPath extends Shape
    {
        protected var _progress:Number;
        protected var _scaleMode:String;
        protected var _redrawLine:Boolean;
        protected var _rawProgress:Number;
        protected var _caps:String;
        protected var _lineAlpha:Number;
        protected var _joints:String;
        protected var _miterLimit:Number;
        protected var _color:uint;
        protected var _pixelHinting:Boolean;
        protected var _thickness:Number;
        protected var _rootFollower:PathFollower;
        static const _RAD2DEG:Number = 57.2958;
        static const _DEG2RAD:Number = 0.0174533;

        public function MotionPath()
        {
            var _loc_1:* = 0;
            _rawProgress = 0;
            _progress = _loc_1;
            lineStyle(1, 6710886, 1, false, "none", null, null, 3, true);
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
            return;
        }// end function

        override public function set y(param1:Number) : void
        {
            super.y = param1;
            update();
            return;
        }// end function

        public function get targets() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = 0;
            var _loc_3:* = _rootFollower;
            while (_loc_3)
            {
                
                _loc_1[++_loc_2] = _loc_3.target;
                _loc_3 = _loc_3.cachedNext;
            }
            return _loc_1;
        }// end function

        public function get rawProgress() : Number
        {
            return _rawProgress;
        }// end function

        public function renderObjectAt(param1:Object, param2:Number, param3:Boolean = false, param4:Number = 0) : void
        {
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            update();
            return;
        }// end function

        public function getFollower(param1:Object) : PathFollower
        {
            if (param1 is PathFollower)
            {
                return param1 as PathFollower;
            }
            var _loc_2:* = _rootFollower;
            while (_loc_2)
            {
                
                if (_loc_2.target == param1)
                {
                    return _loc_2;
                }
                _loc_2 = _loc_2.cachedNext;
            }
            return null;
        }// end function

        protected function _normalize(param1:Number) : Number
        {
            if (param1 > 1)
            {
                param1 = param1 - int(param1);
            }
            else if (param1 < 0)
            {
                param1 = param1 - (int(param1) - 1);
            }
            return param1;
        }// end function

        public function lineStyle(param1:Number = 1, param2:uint = 6710886, param3:Number = 1, param4:Boolean = false, param5:String = "none", param6:String = null, param7:String = null, param8:Number = 3, param9:Boolean = false) : void
        {
            _thickness = param1;
            _color = param2;
            _lineAlpha = param3;
            _pixelHinting = param4;
            _scaleMode = param5;
            _caps = param6;
            _joints = param7;
            _miterLimit = param8;
            _redrawLine = true;
            if (!param9)
            {
                update();
            }
            return;
        }// end function

        override public function set scaleY(param1:Number) : void
        {
            super.scaleY = param1;
            update();
            return;
        }// end function

        public function removeAllFollowers() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = _rootFollower;
            while (_loc_1)
            {
                
                _loc_2 = _loc_1.cachedNext;
                var _loc_3:* = null;
                _loc_1.cachedPrev = null;
                _loc_1.cachedNext = _loc_3;
                _loc_1.path = null;
                _loc_1 = _loc_2;
            }
            _rootFollower = null;
            return;
        }// end function

        protected function onAddedToStage(event:Event) : void
        {
            update();
            return;
        }// end function

        override public function set scaleX(param1:Number) : void
        {
            super.scaleX = param1;
            update();
            return;
        }// end function

        public function get followers() : Array
        {
            var _loc_1:* = [];
            var _loc_2:* = 0;
            var _loc_3:* = _rootFollower;
            while (_loc_3)
            {
                
                _loc_1[++_loc_2] = _loc_3;
                _loc_3 = _loc_3.cachedNext;
            }
            return _loc_1;
        }// end function

        override public function get height() : Number
        {
            return super.height;
        }// end function

        public function get progress() : Number
        {
            return _progress;
        }// end function

        public function removeFollower(param1) : void
        {
            var _loc_2:* = getFollower(param1);
            if (_loc_2 == null)
            {
                return;
            }
            if (_loc_2.cachedNext)
            {
                _loc_2.cachedNext.cachedPrev = _loc_2.cachedPrev;
            }
            if (_loc_2.cachedPrev)
            {
                _loc_2.cachedPrev.cachedNext = _loc_2.cachedNext;
            }
            else if (_rootFollower == _loc_2)
            {
                _rootFollower = _loc_2.cachedNext;
            }
            var _loc_3:* = null;
            _loc_2.cachedPrev = null;
            _loc_2.cachedNext = _loc_3;
            _loc_2.path = null;
            return;
        }// end function

        override public function get width() : Number
        {
            return super.width;
        }// end function

        public function update(event:Event = null) : void
        {
            return;
        }// end function

        override public function get scaleX() : Number
        {
            return super.scaleX;
        }// end function

        override public function get scaleY() : Number
        {
            return super.scaleY;
        }// end function

        public function set progress(param1:Number) : void
        {
            if (param1 > 1)
            {
                _rawProgress = param1;
                param1 = param1 - int(param1);
                if (param1 == 0)
                {
                    param1 = 1;
                }
            }
            else if (param1 < 0)
            {
                _rawProgress = param1;
                param1 = param1 - (int(param1) - 1);
            }
            else
            {
                _rawProgress = int(_rawProgress) + param1;
            }
            var _loc_2:* = param1 - _progress;
            var _loc_3:* = _rootFollower;
            while (_loc_3)
            {
                
                _loc_3.cachedProgress = _loc_3.cachedProgress + _loc_2;
                _loc_3.cachedRawProgress = _loc_3.cachedRawProgress + _loc_2;
                if (_loc_3.cachedProgress > 1)
                {
                    _loc_3.cachedProgress = _loc_3.cachedProgress - int(_loc_3.cachedProgress);
                    if (_loc_3.cachedProgress == 0)
                    {
                        _loc_3.cachedProgress = 1;
                    }
                }
                else if (_loc_3.cachedProgress < 0)
                {
                    _loc_3.cachedProgress = _loc_3.cachedProgress - (int(_loc_3.cachedProgress) - 1);
                }
                _loc_3 = _loc_3.cachedNext;
            }
            _progress = param1;
            update();
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            update();
            return;
        }// end function

        public function addFollower(param1, param2:Number = 0, param3:Boolean = false, param4:Number = 0) : PathFollower
        {
            var _loc_5:* = getFollower(param1);
            if (getFollower(param1) == null)
            {
                _loc_5 = new PathFollower(param1);
            }
            _loc_5.autoRotate = param3;
            _loc_5.rotationOffset = param4;
            if (_loc_5.path != this)
            {
                if (_rootFollower)
                {
                    _rootFollower.cachedPrev = _loc_5;
                }
                _loc_5.cachedNext = _rootFollower;
                _rootFollower = _loc_5;
                _loc_5.path = this;
                _loc_5.progress = param2;
            }
            return _loc_5;
        }// end function

        public function distribute(param1:Array = null, param2:Number = 0, param3:Number = 1, param4:Boolean = false, param5:Number = 0) : void
        {
            var _loc_6:* = null;
            if (param1 == null)
            {
                param1 = this.followers;
            }
            param2 = _normalize(param2);
            param3 = _normalize(param3);
            var _loc_7:* = param1.length;
            var _loc_8:* = param1.length > 1 ? ((param3 - param2) / (_loc_7 - 1)) : (1);
            while (--_loc_7 > -1)
            {
                
                _loc_6 = getFollower(param1[_loc_7]);
                if (_loc_6 == null)
                {
                    _loc_6 = this.addFollower(param1[_loc_7], 0, param4, param5);
                }
                var _loc_9:* = param2 + _loc_8 * _loc_7;
                _loc_6.cachedRawProgress = param2 + _loc_8 * _loc_7;
                _loc_6.cachedProgress = _loc_9;
                this.renderObjectAt(_loc_6.target, _loc_6.cachedProgress, param4, param5);
            }
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            _redrawLine = true;
            update();
            return;
        }// end function

        override public function set x(param1:Number) : void
        {
            super.x = param1;
            update();
            return;
        }// end function

        public function set rawProgress(param1:Number) : void
        {
            this.progress = param1;
            return;
        }// end function

        override public function get visible() : Boolean
        {
            return super.visible;
        }// end function

        override public function get x() : Number
        {
            return super.x;
        }// end function

        override public function get y() : Number
        {
            return super.y;
        }// end function

        override public function set rotation(param1:Number) : void
        {
            super.rotation = param1;
            update();
            return;
        }// end function

        override public function get rotation() : Number
        {
            return super.rotation;
        }// end function

    }
}
