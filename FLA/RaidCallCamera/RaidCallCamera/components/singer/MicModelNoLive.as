package components.singer
{
    import language.*;
    import rabitui.uicore.*;

    public class MicModelNoLive extends UIObject
    {
        private var tip:TipText;
        private var icon:AssetMusicIcon;
        private var userPhoto:UserPhoto;

        public function MicModelNoLive()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.tip = new TipText();
            this.tip.setText(Lang.getString(10013));
            addChild(this.tip);
            this.icon = new AssetMusicIcon();
            addChild(this.icon);
            this.userPhoto = new UserPhoto();
            addChild(this.userPhoto);
            _update(true);
            return;
        }// end function

        public function setUrl(param1:String) : void
        {
            this.userPhoto.setUrl(param1);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.icon.x = int((preferWidth - this.tip.preferWidth - this.icon.width) / 2);
            this.icon.y = int((preferHeight - this.tip.preferHeight + this.userPhoto.preferHeight + 10) / 2);
            this.tip.x = this.icon.x + this.icon.width + 2;
            this.tip.y = this.icon.y - 2;
            this.userPhoto.x = int((preferWidth - this.userPhoto.preferWidth + this.tip.preferHeight) / 2);
            this.userPhoto.y = this.tip.y - this.userPhoto.preferHeight - 10;
            return;
        }// end function

    }
}
