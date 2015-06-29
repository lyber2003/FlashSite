package components.singer
{
    import rabitui.uicore.*;

    public class LoaddingPanel extends UIObject
    {
        private var loadingIcon:AssetLoaddingIcon;

        public function LoaddingPanel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.loadingIcon = new AssetLoaddingIcon();
            addChild(this.loadingIcon);
            _update(true);
            return;
        }// end function

        public function set bShowLoadding(param1:Boolean) : void
        {
            this.loadingIcon.visible = param1;
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.loadingIcon.x = int(preferWidth / 2);
            this.loadingIcon.y = int(preferHeight / 2);
            return;
        }// end function

    }
}
