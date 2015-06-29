package components.singer.video
{
    import flash.events.*;

    public class CameraSelectEvent extends Event
    {
        public var selectcamera:String;
        public static const SELECT:String = "cameraselect";

        public function CameraSelectEvent(param1:String)
        {
            this.selectcamera = param1;
            super(CameraSelectEvent.SELECT);
            return;
        }// end function

    }
}
