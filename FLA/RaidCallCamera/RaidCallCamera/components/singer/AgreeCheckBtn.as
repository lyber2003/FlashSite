package components.singer
{
    import flash.events.*;
    import flash.text.*;
    import language.*;
    import rabitui.uicore.*;

    public class AgreeCheckBtn extends UIObject
    {
        private var checkBtn:AssetCheckBtn;
        private var tipText:TipText;
        private var _bCheck:Boolean;

        public function AgreeCheckBtn()
        {
            return;
        }// end function

        public function get bCheck() : Boolean
        {
            return this._bCheck;
        }// end function

        public function set bCheck(param1:Boolean) : void
        {
            this._bCheck = param1;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.checkBtn = new AssetCheckBtn();
            addChild(this.checkBtn);
            this.tipText = new TipText();
            var _loc_1:* = new TextFormat("tahoma", 12, 16777215);
            this.tipText.setTextFormat(_loc_1);
            this.tipText.setMaxWidth(450);
            this.tipText.setText(Lang.getString(10026));
            addChild(this.tipText);
            _update(true);
            return;
        }// end function

        override protected function init() : void
        {
            this.checkBtn.addEventListener(MouseEvent.CLICK, this.onCheckClick);
            return;
        }// end function

        private function onCheckClick(event:MouseEvent) : void
        {
            if (this.checkBtn.currentFrame == 1)
            {
                this.checkBtn.gotoAndStop(2);
            }
            else
            {
                this.checkBtn.gotoAndStop(1);
            }
            this._bCheck = this.checkBtn.currentFrame == 2;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.tipText.x = this.checkBtn.x + this.checkBtn.width + 2;
            this.checkBtn.y = 2;
            return;
        }// end function

    }
}
