package components
{
    import components.heartAndFlower.*;
    import components.singer.*;
    import flash.text.*;
    import rabitui.uicore.*;

    final public class MainStage extends UIObject
    {
        private var singerBack:SingerBackPanel;
        public var singerPanel:SingerPanel;
        public var heartAndFlower:HeartAndFlowerPanel;
        public var notMicModelPanel:NotMicModel;
        public var micModelEmpty:MicModelEmpty;
        public var micNodelNoLive:MicModelNoLive;
        private var versionTf:TextField;
        public static const STATUS_MIC_MODEL_NO_LIVE:String = "STATUS_MIC_MODEL_NO_LIVE";
        public static const STATUS_NOT_MIC_MODEL:String = "STATUS_NOT_MIC_MODEL";
        public static const STATUS_MIC_MODEL_EMPTY:String = "STATUS_MIC_MODEL_EMPTY";
        public static const STATUS_MIC_MODEL_LIVE:String = "MIC_MODEL_ONLIE_LIVE";

        public function MainStage()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.singerBack = new SingerBackPanel();
            addChild(this.singerBack);
            this.singerPanel = new SingerPanel();
            this.singerPanel.setSize(320, 240);
            addChild(this.singerPanel);
            this.notMicModelPanel = new NotMicModel();
            this.notMicModelPanel.setSize(320, 240);
            addChild(this.notMicModelPanel);
            this.micModelEmpty = new MicModelEmpty();
            this.micModelEmpty.setSize(320, 240);
            addChild(this.micModelEmpty);
            this.micNodelNoLive = new MicModelNoLive();
            this.micNodelNoLive.setSize(320, 240);
            addChild(this.micNodelNoLive);
            this.heartAndFlower = new HeartAndFlowerPanel();
            addChild(this.heartAndFlower);
            this.versionTf = new TextField();
            this.versionTf.mouseEnabled = false;
            this.versionTf.autoSize = TextFieldAutoSize.LEFT;
            this.versionTf.text = RCShow.version;
            addChild(this.versionTf);
            this.singerBack.setSize(320, 240);
            return;
        }// end function

        public function updateStatus(param1:String) : void
        {
            this.notMicModelPanel.visible = param1 == STATUS_NOT_MIC_MODEL;
            this.singerPanel.visible = param1 == STATUS_MIC_MODEL_LIVE;
            this.micModelEmpty.visible = param1 == STATUS_MIC_MODEL_EMPTY;
            this.micNodelNoLive.visible = param1 == STATUS_MIC_MODEL_NO_LIVE;
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.singerPanel.x = 10;
            this.singerPanel.y = int((preferHeight - this.singerPanel.preferHeight) / 2);
            this.heartAndFlower.x = this.singerPanel.x + this.singerPanel.preferWidth + 10;
            this.heartAndFlower.y = this.singerPanel.y + 4;
            this.notMicModelPanel.x = this.singerPanel.x;
            this.notMicModelPanel.y = this.singerPanel.y;
            this.micModelEmpty.x = this.singerPanel.x;
            this.micModelEmpty.y = this.singerPanel.y;
            this.singerBack.x = this.singerPanel.x;
            this.singerBack.y = this.singerPanel.y;
            this.micNodelNoLive.x = this.singerPanel.x;
            this.micNodelNoLive.y = this.singerPanel.y;
            this.versionTf.x = preferWidth - this.versionTf.textWidth;
            return;
        }// end function

    }
}
