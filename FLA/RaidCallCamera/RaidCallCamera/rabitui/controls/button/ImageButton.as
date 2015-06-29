package rabitui.controls.button
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import org.bytearray.display.*;
    import rabitui.model.*;
    import rabitui.uicore.*;

    public class ImageButton extends UIObject
    {
        protected var scaleRect:Rectangle;
        protected var tf:TextField;
        protected var paddingRect:PaddingData;
        protected var _content:ScaleBitmap;
        protected var _skinClass:Object;
        protected var _status:String;
        protected var _enabled:Boolean = true;
        private var _minWidth:int = -1;
        public static const UP:String = "up";
        public static const DOWN:String = "down";
        public static const OVER:String = "over";
        public static const DISABLE:String = "disable";

        public function ImageButton(param1:Class, param2:Rectangle, param3:Class = null, param4:Class = null, param5:Class = null)
        {
            this.paddingRect = new PaddingData(0, 0, 0, 0);
            this._content = new ScaleBitmap(new BitmapData(100, 20));
            this.scaleRect = param2;
            if (param3 == null)
            {
                param3 = param1;
            }
            if (param4 == null)
            {
                param4 = param1;
            }
            if (param5 == null)
            {
                param5 = param1;
            }
            this._skinClass = {up:param1, down:param4, over:param3, disable:param5};
            return;
        }// end function

        public function get minWidth() : int
        {
            return this._minWidth;
        }// end function

        public function set minWidth(param1:int) : void
        {
            this._minWidth = param1;
            _update(true);
            return;
        }// end function

        public function setData(param1:String, param2:TextFormat, param3:PaddingData) : void
        {
            this.tf.defaultTextFormat = param2;
            this.tf.autoSize = TextFieldAutoSize.LEFT;
            this.tf.text = param1;
            this.paddingRect = param3;
            this.tf.x = param3.left;
            this.tf.y = param3.top;
            _update(true);
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.tf = new TextField();
            this.tf.mouseEnabled = false;
            addChild(this.tf);
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this.tf.text = param1;
            _update(true);
            return;
        }// end function

        override protected function init() : void
        {
            buttonMode = true;
            useHandCursor = true;
            addEventListener(MouseEvent.ROLL_OVER, this.onMouseOver);
            addEventListener(MouseEvent.ROLL_OUT, this.onMouseOut);
            addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.status = SkinButtonBase.UP;
            return;
        }// end function

        protected function onMouseDown(event:MouseEvent) : void
        {
            if (this._enabled)
            {
                this.status = SkinButtonBase.DOWN;
            }
            return;
        }// end function

        protected function onMouseOut(event:MouseEvent) : void
        {
            if (this._enabled)
            {
                this.status = SkinButtonBase.UP;
            }
            return;
        }// end function

        protected function onMouseOver(event:MouseEvent) : void
        {
            if (this._enabled)
            {
                this.status = SkinButtonBase.OVER;
            }
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            if (this._status != param1)
            {
                this._status = param1;
                this.updateStatus();
            }
            return;
        }// end function

        public function get enabled() : Boolean
        {
            return this._enabled;
        }// end function

        public function set enabled(param1:Boolean) : void
        {
            if (this._enabled != param1)
            {
                this._enabled = param1;
                this.status = this._enabled ? (var _loc_2:* = SkinButtonBase.UP, this.status = SkinButtonBase.UP, _loc_2) : (SkinButtonBase.DISABLE);
                if (!this._enabled)
                {
                    this.applyGray(this);
                }
                else
                {
                    this.filters = [];
                }
                mouseEnabled = this._enabled;
            }
            return;
        }// end function

        public function applyGray(param1:DisplayObject) : void
        {
            var _loc_2:* = new Array();
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0.21, 0.7, 0.09, 0, 0]);
            _loc_2 = _loc_2.concat([0, 0, 0, 1, 0]);
            this.applyFilter(param1, _loc_2);
            return;
        }// end function

        protected function applyFilter(param1:DisplayObject, param2:Array) : void
        {
            var _loc_3:* = new ColorMatrixFilter(param2);
            var _loc_4:* = new Array();
            _loc_4.push(_loc_3);
            param1.filters = _loc_4;
            return;
        }// end function

        protected function updateStatus() : void
        {
            if (contains(this._content))
            {
                removeChild(this._content);
            }
            if (this._content.bitmapData)
            {
                this._content.bitmapData.dispose();
            }
            this._content.bitmapData = new this._skinClass[this.status];
            if (this.scaleRect)
            {
                this._content.scale9Grid = this.scaleRect;
            }
            addChildAt(this._content, 0);
            this.updateDisplay();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            if (this._content)
            {
                if (this.paddingRect.width == 0)
                {
                    this._content.width = this.tf.textWidth + this.paddingRect.left + this.paddingRect.right;
                }
                else
                {
                    this._content.width = this.paddingRect.width;
                }
                if (this.paddingRect.height == 0)
                {
                    this._content.height = this.tf.textHeight + this.paddingRect.top + this.paddingRect.bottom;
                }
                else
                {
                    this._content.height = this.paddingRect.height;
                }
            }
            if (this._minWidth && this._content.width < this._minWidth)
            {
                this._content.width = this._minWidth;
                this.tf.x = (this._minWidth - this.tf.textWidth) / 2;
            }
            return;
        }// end function

    }
}
