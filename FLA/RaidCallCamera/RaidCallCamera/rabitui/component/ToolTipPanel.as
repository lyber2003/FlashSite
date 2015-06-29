package rabitui.component
{
    import flash.display.*;
    import flash.text.*;
    import rabitui.uicore.*;

    public class ToolTipPanel extends UIObject
    {
        protected var toolTipAsset:DisplayObject;
        protected var tf:TextField;
        protected const maxWidth:int = 300;

        public function ToolTipPanel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            mouseEnabled = false;
            mouseChildren = false;
            this.toolTipAsset = new AssetTipBack();
            addChild(this.toolTipAsset);
            var _loc_1:* = new TextFormat("SimSun");
            _loc_1.size = 12;
            _loc_1.leading = 2;
            this.tf = new TextField();
            this.tf.width = this.maxWidth;
            this.tf.defaultTextFormat = _loc_1;
            this.tf.multiline = true;
            this.tf.wordWrap = true;
            addChild(this.tf);
            return;
        }// end function

        public function setTips(param1:String) : void
        {
            this.tf.htmlText = param1;
            this.updateDisplay();
            return;
        }// end function

        public function setAlpha(param1:Number) : void
        {
            this.toolTipAsset.alpha = param1;
            return;
        }// end function

        public function getRealHeight() : int
        {
            return this.toolTipAsset.height;
        }// end function

        public function getRealWidth() : int
        {
            return this.tf.textWidth + 10;
        }// end function

        override protected function updateDisplay() : void
        {
            this.toolTipAsset.width = this.tf.textWidth + 12;
            this.toolTipAsset.height = this.tf.textHeight + 12;
            this.tf.x = 6;
            this.tf.y = 6;
            this.tf.height = this.tf.textHeight + 6;
            return;
        }// end function

    }
}
