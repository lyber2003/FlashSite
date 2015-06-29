package rabitui.controls.button
{
    import flash.display.*;
    import flash.events.*;
    import rabitui.uicore.*;

    public class SkinButtonBase extends UIObject
    {
        protected var _skinClass:Object;
        protected var _status:String;
        protected var _enabled:Boolean = true;
        protected var _content:DisplayObject;
        public static const UP:String = "up";
        public static const DOWN:String = "down";
        public static const OVER:String = "over";
        public static const DISABLE:String = "disable";

        public function SkinButtonBase(param1:Class, param2:Class = null, param3:Class = null, param4:Class = null)
        {
            if (param2 == null)
            {
                param2 = param1;
            }
            if (param3 == null)
            {
                param3 = param1;
            }
            if (param4 == null)
            {
                param4 = param1;
            }
            this._skinClass = {up:param1, down:param3, over:param2, disable:param4};
            return;
        }// end function

        override protected function createChildren() : void
        {
            return;
        }// end function

        override protected function init() : void
        {
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

        protected function updateStatus() : void
        {
            removeChildren();
            this._content = new this._skinClass[this.status];
            addChild(this._content);
            this.updateDisplay();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            if (this._content)
            {
                this._content.width = preferWidth;
                this._content.height = preferHeight;
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
            }
            return;
        }// end function

    }
}
