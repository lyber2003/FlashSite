package rabitui.controls
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import rabitui.component.*;
    import rabitui.manager.*;
    import rabitui.uicore.*;

    public class AlertWindow extends UIObject
    {
        protected var asset:Asset_AlertWindow;
        protected var back:Sprite;
        protected var closeButton:SimpleButton;
        protected var okButton:SimpleButton;
        protected var titleLabel:TextField;
        protected var infoLabel:TextField;
        public var icon:Sprite;
        private var iconType:int;
        private var showCloseButton:Boolean;
        private var text:String;
        private var title:String;
        private var iconClass:Array;
        private static const TITLE_HEIGHT:int = 26;

        public function AlertWindow(param1:String, param2:int = 0, param3:String = "提示", param4:Boolean = true)
        {
            this.iconClass = [null, AssetAlert, AssetWarn, AssetError, AssetLuckyGiftBig];
            this.iconType = param2;
            this.showCloseButton = param4;
            this.text = param1;
            this.title = param3;
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.asset = new Asset_AlertWindow();
            this.back = this.asset.back;
            this.closeButton = this.asset.closeButton;
            this.closeButton.addEventListener(MouseEvent.CLICK, this.onCloseButtonClick);
            this.okButton = this.asset.okButton;
            this.okButton.addEventListener(MouseEvent.CLICK, this.onOkButtonClick);
            this.titleLabel = this.asset.titleLabel;
            this.infoLabel = this.asset.infoLabel;
            addChild(this.asset);
            if (this.iconType != AlertIconType.NOICON)
            {
                this.icon = new this.iconClass[this.iconType] as Sprite;
                addChild(this.icon);
            }
            return;
        }// end function

        override protected function init() : void
        {
            this.titleLabel.text = this.title;
            this.infoLabel.htmlText = this.text;
            return;
        }// end function

        protected function onCloseButtonClick(event:MouseEvent) : void
        {
            PopUpManager.removePopUp(this);
            dispatchEvent(new Event(Event.CLOSE));
            return;
        }// end function

        protected function onOkButtonClick(event:MouseEvent) : void
        {
            PopUpManager.removePopUp(this);
            dispatchEvent(new Event(Event.CLOSE));
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.back.width = preferWidth;
            this.back.height = preferHeight;
            this.closeButton.x = preferWidth - this.closeButton.width - 1;
            this.titleLabel.x = 6;
            this.titleLabel.width = this.closeButton.x - 10;
            this.okButton.x = (preferWidth - this.okButton.width) / 2;
            this.okButton.y = preferHeight - this.okButton.height - 10;
            if (this.iconType != AlertIconType.NOICON)
            {
                this.icon.x = (preferWidth - this.icon.width - this.infoLabel.textWidth - 10) / 2;
                this.icon.y = TITLE_HEIGHT + (this.okButton.y - TITLE_HEIGHT - this.icon.height) / 2;
                this.infoLabel.x = this.icon.x + this.icon.width + 10;
                this.infoLabel.y = TITLE_HEIGHT + (this.okButton.y - TITLE_HEIGHT - this.infoLabel.textHeight) / 2;
                this.infoLabel.width = preferWidth - this.infoLabel.x - 20;
            }
            else
            {
                this.infoLabel.x = (preferWidth - this.infoLabel.textWidth) / 2;
                this.infoLabel.y = TITLE_HEIGHT + (this.okButton.y - TITLE_HEIGHT - this.infoLabel.textHeight) / 2;
                this.infoLabel.width = preferWidth - 40;
            }
            this.infoLabel.height = this.okButton.y - this.infoLabel.y - 10;
            return;
        }// end function

    }
}
