package rabitui.component
{
    import flash.events.*;
    import rabitui.uicore.*;

    public class ModalBackground extends UIObject
    {

        public function ModalBackground()
        {
            return;
        }// end function

        override protected function onAddedToStage(event:Event) : void
        {
            stage.addEventListener(Event.RESIZE, this.onResize, false, 0, true);
            this.updateDisplay();
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            this.updateDisplay();
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            graphics.clear();
            graphics.beginFill(0, 0.1);
            graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
            graphics.endFill();
            cacheAsBitmap = true;
            return;
        }// end function

        override protected function onRemovedFromStage(event:Event) : void
        {
            stage.removeEventListener(Event.RESIZE, this.onResize, false);
            return;
        }// end function

    }
}
