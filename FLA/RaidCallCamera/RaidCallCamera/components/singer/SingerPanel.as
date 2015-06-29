package components.singer
{
    import components.singer.video.*;
    import rabitui.uicore.*;

    public class SingerPanel extends UIObject
    {
        public var back:LoaddingPanel;
        public var video:VideoPanel;
        public var videoConver:VideoConver;

        public function SingerPanel()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.back = new LoaddingPanel();
            addChild(this.back);
            this.video = new VideoPanel();
            addChild(this.video);
            this.videoConver = new VideoConver();
            addChild(this.videoConver);
            setSize(320, 240, true);
            return;
        }// end function

        public function setVideoStatus(param1:String) : void
        {
            this.bShowLoadding = param1 == VideoConver.STATUS_PLAY;
            this.videoConver.status = param1;
            return;
        }// end function

        public function set bShowLoadding(param1:Boolean) : void
        {
            this.back.bShowLoadding = param1;
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.video.setSize(preferWidth, preferHeight, true);
            this.videoConver.setSize(preferWidth, preferHeight, true);
            this.back.setSize(preferWidth, preferHeight, true);
            return;
        }// end function

    }
}
