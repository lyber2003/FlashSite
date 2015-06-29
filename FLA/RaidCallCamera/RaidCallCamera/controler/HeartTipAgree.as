package controler
{
    import components.scollBar.*;
    import components.singer.*;
    import flash.text.*;
    import rabitui.controls.scroll.*;
    import rabitui.uicore.*;

    public class HeartTipAgree extends UIObject
    {
        private var desBack:AssetHeartAgreeBack;
        protected var scrollPanel:SimpleScroll;
        private var tipText:TipText;

        public function HeartTipAgree()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.desBack = new AssetHeartAgreeBack();
            addChild(this.desBack);
            this.tipText = new TipText();
            var _loc_1:* = new TextFormat(null, 12, 7766679);
            _loc_1.leading = 10;
            this.tipText.setTextFormat(_loc_1);
            addChild(this.tipText);
            this.scrollPanel = new SimpleScroll({drager:new PropScrollBarThumb()});
            addChild(this.scrollPanel);
            this.scrollPanel.content.addChild(this.tipText);
            this.scrollPanel.updateScroll();
            setSize(430, 99, true);
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this.tipText.setText(param1);
            _update(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.tipText.x = 8;
            this.tipText.y = 8;
            this.tipText.setMaxWidth(this.desBack.width - 12);
            this.scrollPanel.setSize(this.desBack.width - 12, this.desBack.height - 8, true);
            this.scrollPanel.updateScroll();
            return;
        }// end function

    }
}
