package components.singer
{
    import language.*;
    import rabitui.uicore.*;

    public class MicModelEmpty extends UIObject
    {
        private var tip:TipText;
        private var icon:AssetComputerIcon;

        public function MicModelEmpty()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.tip = new TipText();
            this.tip.setText(Lang.getString(10012));
            this.tip.setMaxWidth(280);
            addChild(this.tip);
            this.icon = new AssetComputerIcon();
            addChild(this.icon);
            _update(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.icon.x = int((preferWidth - this.icon.width - this.tip.preferWidth) / 2);
            this.icon.y = int((preferHeight - this.icon.height) / 2);
            this.tip.x = this.icon.x + this.icon.width + 2;
            this.tip.y = this.icon.y - 2;
            return;
        }// end function

    }
}
