package components.singer
{
    import com.debug.*;
    import components.scollBar.*;
    import flash.text.*;
    import language.*;
    import rabitui.controls.scroll.*;
    import rabitui.uicore.*;

    public class VideoProtoAgree extends UIObject
    {
        private var desBack:AssetDesInfoBack;
        protected var scrollPanel:SimpleScroll;
        private var tipText:TipText;

        public function VideoProtoAgree()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.desBack = new AssetDesInfoBack();
            addChild(this.desBack);
            var _loc_1:* = Lang.getString(10014);
            _loc_1 = _loc_1 + Lang.getString(10031);
            _loc_1 = _loc_1 + Lang.getString(10032);
            this.tipText = new TipText();
            var _loc_2:* = new TextFormat(null, 12, 7766679);
            _loc_2.leading = 10;
            this.tipText.setTextFormat(_loc_2);
            this.tipText.setText(_loc_1);
            addChild(this.tipText);
            this.scrollPanel = new SimpleScroll({drager:new PropScrollBarThumb()});
            addChild(this.scrollPanel);
            this.scrollPanel.content.addChild(this.tipText);
            this.scrollPanel.updateScroll();
            setSize(470, 106, true);
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
            this.tipText.x = 4;
            this.tipText.y = 4;
            this.tipText.setMaxWidth(this.desBack.width - 12);
            this.scrollPanel.setSize(this.desBack.width - 12, this.desBack.height - 8, true);
            DebugX.trace("agree", this.tipText.width, this.tipText.height, this.desBack.width - 12, this.desBack.height - 8);
            this.scrollPanel.updateScroll();
            return;
        }// end function

    }
}
