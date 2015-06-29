package components.singer
{
    import flash.text.*;
    import rabitui.uicore.*;

    public class TipText extends UIObject
    {
        private var text:TextField;
        private var maxWidth:int;

        public function TipText()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.text = new TextField();
            this.text.wordWrap = true;
            this.text.multiline = true;
            this.text.mouseEnabled = false;
            this.text.autoSize = TextFieldAutoSize.LEFT;
            this.text.defaultTextFormat = new TextFormat("tahoma", 12, 2238255);
            addChild(this.text);
            return;
        }// end function

        public function setTextFormat(param1:TextFormat) : void
        {
            this.text.defaultTextFormat = param1;
            return;
        }// end function

        public function setMaxWidth(param1:int) : void
        {
            this.maxWidth = param1;
            this.text.width = param1;
            return;
        }// end function

        public function setText(param1:String) : void
        {
            this.text.text = param1;
            _update(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            preferWidth = this.text.textWidth;
            preferHeight = this.text.textHeight;
            return;
        }// end function

    }
}
