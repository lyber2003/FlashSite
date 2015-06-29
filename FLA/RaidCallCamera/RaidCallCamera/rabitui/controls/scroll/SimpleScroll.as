package rabitui.controls.scroll
{
    import com.greensock.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import rabitui.controls.list.*;
    import rabitui.uicore.*;

    public class SimpleScroll extends UIObject
    {
        private var _mask:Sprite;
        private var _content:Sprite;
        public var scrollBarButton:UIObject;
        public var _trackBar:UIObject;
        private var _skin:Object;
        private var _scrollBarAutoHide:Boolean = true;
        private var _conentHeight:Number;
        private var _scrollHeight:Number;
        private var _wheelDelta:Number = -1;
        private var _VPos:Number;
        private var _dy:Number;
        private var _bdraging:Boolean;

        public function SimpleScroll(param1:Object = null)
        {
            if (param1 == null)
            {
                this._skin = {drager:new SimpleScrollBarThumb(), track:new RectangleShape()};
            }
            else
            {
                this._skin = param1;
            }
            return;
        }// end function

        public function addContent(param1:DisplayObject) : void
        {
            this.content.addChild(param1);
            this.updateScrollStatus();
            return;
        }// end function

        private function scrollContentTo(param1:Number) : void
        {
            var _loc_2:* = param1 / (this._conentHeight - preferHeight) * this._scrollHeight;
            this.calScrollAction(_loc_2);
            return;
        }// end function

        private function scrollBarTo(param1:Number) : void
        {
            this.calScrollAction(param1);
            return;
        }// end function

        public function scrollToBottom() : void
        {
            this.calScrollAction(10000000);
            return;
        }// end function

        public function scrollToTop() : void
        {
            this.calScrollAction(0);
            return;
        }// end function

        public function updateScroll() : void
        {
            this.updateScrollStatus();
            return;
        }// end function

        override protected function createChildren() : void
        {
            if (this._skin.hasOwnProperty("track"))
            {
                this._trackBar = this._skin["track"];
                this._trackBar.visible = false;
                addChild(this._trackBar);
            }
            this.scrollBarButton = this._skin["drager"] as UIObject;
            this.scrollBarButton.addEventListener(MouseEvent.MOUSE_DOWN, this.onSBtnMouseDown);
            this.scrollBarButton.visible = false;
            addChild(this.scrollBarButton);
            this._content = new Sprite();
            addChild(this.content);
            this._mask = new Sprite();
            this._mask.graphics.beginFill(0, 1);
            this._mask.graphics.drawRect(0, 0, 100, 100);
            this._mask.graphics.endFill();
            this._mask.visible = false;
            addChild(this._mask);
            this.content.mask = this._mask;
            return;
        }// end function

        override protected function init() : void
        {
            addEventListener(MouseEvent.ROLL_OVER, this.onRFocusIn);
            addEventListener(MouseEvent.ROLL_OUT, this.onRFocusOut);
            return;
        }// end function

        protected function onRFocusOut(event:MouseEvent) : void
        {
            if (stage)
            {
                stage.removeEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            }
            if (this._scrollBarAutoHide && !this._bdraging)
            {
                if (this._trackBar != null)
                {
                    TweenLite.to(this._trackBar, 0.3, {alpha:0});
                }
                if (this.scrollBarButton != null)
                {
                    TweenLite.to(this.scrollBarButton, 0.3, {alpha:0});
                }
            }
            return;
        }// end function

        protected function onRFocusIn(event:MouseEvent) : void
        {
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, this.onMouseWheel);
            if (this._scrollBarAutoHide)
            {
                if (this._trackBar != null)
                {
                    TweenLite.to(this._trackBar, 0.3, {alpha:1});
                }
                TweenLite.to(this.scrollBarButton, 0.3, {alpha:1});
            }
            return;
        }// end function

        protected function onMouseWheel(event:MouseEvent) : void
        {
            var _loc_6:* = NaN;
            if (this._conentHeight <= preferHeight)
            {
                return;
            }
            var _loc_2:* = event.delta * (this._scrollHeight / (3 * 8));
            var _loc_3:* = _loc_2 / this._scrollHeight;
            var _loc_4:* = this._conentHeight - preferHeight;
            var _loc_5:* = _loc_3 * _loc_4;
            if (this.wheelDelta == -1)
            {
                _loc_6 = _loc_2;
            }
            else
            {
                _loc_6 = this.wheelDelta / _loc_4 * event.delta / 3 * this._scrollHeight;
            }
            this.calScrollAction(this.scrollBarButton.y - _loc_6);
            return;
        }// end function

        protected function onSBtnMouseDown(event:MouseEvent) : void
        {
            this._bdraging = true;
            this._dy = globalToLocal(this.scrollBarButton.localToGlobal(new Point(this.scrollBarButton.mouseX, this.scrollBarButton.mouseY))).y - this.scrollBarButton.y;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
            return;
        }// end function

        protected function onStageMouseUp(event:MouseEvent) : void
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onStageMouseMove);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.onStageMouseUp);
            this._bdraging = false;
            if (!hitTestPoint(stage.mouseX, stage.mouseY))
            {
                if (this._trackBar != null)
                {
                    TweenLite.to(this._trackBar, 0.3, {alpha:0});
                }
                TweenLite.to(this.scrollBarButton, 0.3, {alpha:0});
            }
            return;
        }// end function

        protected function onStageMouseMove(event:MouseEvent) : void
        {
            this.calScrollAction(mouseY - this._dy);
            return;
        }// end function

        private function calScrollAction(param1:Number) : void
        {
            if (this._conentHeight <= preferHeight)
            {
                param1 = 0;
            }
            if (param1 < 0)
            {
                param1 = 0;
            }
            if (param1 > this._scrollHeight)
            {
                param1 = this._scrollHeight;
            }
            this.scrollBarButton.y = param1;
            this.updateScrollPos();
            return;
        }// end function

        private function updateScrollPos() : void
        {
            var _loc_1:* = NaN;
            if (this.scrollBarButton.y != 0)
            {
                _loc_1 = this.scrollBarButton.y / this._scrollHeight;
                this.content.y = -int((this._conentHeight - preferHeight) * _loc_1);
            }
            else
            {
                this.content.y = 0;
            }
            dispatchEvent(new ScrollEvent(ScrollEvent.SCROLL));
            return;
        }// end function

        private function updateScrollStatus() : void
        {
            var _loc_4:* = NaN;
            this._conentHeight = this.content.getBounds(this.content).bottom;
            var _loc_1:* = 32;
            var _loc_2:* = preferHeight;
            var _loc_3:* = this.scrollBarButton.y / (_loc_2 - this.scrollBarButton.preferHeight);
            if (this._conentHeight <= _loc_2)
            {
                this.scrollBarButton.visible = false;
                this.scrollBarButton.y = 0;
                this.content.y = 0;
            }
            else
            {
                _loc_4 = Math.max(_loc_1, _loc_2 / this._conentHeight * _loc_2);
                this.scrollBarButton.preferHeight = _loc_4;
                this._scrollHeight = _loc_2 - this.scrollBarButton.preferHeight;
                this.scrollBarButton.y = _loc_3 * this._scrollHeight;
                this.scrollBarButton.visible = true;
            }
            if (this._trackBar != null)
            {
                this._trackBar.visible = this.scrollBarButton.visible;
            }
            this._mask.width = this.scrollBarButton.visible ? (preferWidth - this.scrollBarButton.preferWidth) : (preferWidth);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.updateScrollStatus();
            graphics.clear();
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, preferWidth, preferHeight);
            graphics.endFill();
            this.scrollBarButton.x = preferWidth - this.scrollBarButton.preferWidth;
            if (this._trackBar != null)
            {
                this._trackBar.x = this.scrollBarButton.x;
                this._trackBar.setSize(this.scrollBarButton.preferWidth, preferHeight);
            }
            this._mask.height = preferHeight;
            return;
        }// end function

        public function get wheelDelta() : Number
        {
            return this._wheelDelta;
        }// end function

        public function set wheelDelta(param1:Number) : void
        {
            this._wheelDelta = param1;
            return;
        }// end function

        public function get content() : Sprite
        {
            return this._content;
        }// end function

        public function get VPos() : Number
        {
            return this._VPos;
        }// end function

        public function set VPos(param1:Number) : void
        {
            this._VPos = param1;
            this.scrollContentTo(param1);
            return;
        }// end function

        public function get scrollBarAutoHide() : Boolean
        {
            return this._scrollBarAutoHide;
        }// end function

        public function set scrollBarAutoHide(param1:Boolean) : void
        {
            this._scrollBarAutoHide = param1;
            return;
        }// end function

    }
}
