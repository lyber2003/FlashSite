package utils
{
    import flash.display.*;
    import flash.events.*;
    import rabitui.uicore.*;

    public class ClientFlashApp extends UIObject
    {

        public function ClientFlashApp()
        {
            return;
        }// end function

        override protected function preinit() : void
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.frameRate = 24;
            return;
        }// end function

        override protected function onAddedToStage(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.onStageResize);
            super.onAddedToStage(event);
            setSize(stage.stageWidth, stage.stageHeight, true);
            return;
        }// end function

        override protected function createChildren() : void
        {
            return;
        }// end function

        override protected function init() : void
        {
            return;
        }// end function

        protected function onStageResize(event:Event) : void
        {
            setSize(stage.stageWidth, stage.stageHeight, true);
            return;
        }// end function

    }
}
