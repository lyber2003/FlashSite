package components.singer
{
    import language.*;
    import rabitui.uicore.*;

    public class NotMicModel extends UIObject
    {
        private var tip:TipText;
        private var icon:AssetNoticeIcon;

        public function NotMicModel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.tip = new TipText();
            this.tip.setText(Language.getInstance().getString(10018));
            addChild(this.tip);
            this.icon = new AssetNoticeIcon();
            addChild(this.icon);
            _update(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.tip.x = int((preferWidth - this.tip.preferWidth) / 2);
            this.tip.y = int((preferHeight - this.tip.preferHeight) / 2);
            this.icon.x = this.tip.x - this.icon.width - 2;
            this.icon.y = this.tip.y;
            return;
        }// end function

    }
}
