package rcbiz.events
{
    import flash.events.*;

    public class ClientEvent extends Event
    {
        public var data:Object;
        public static const SWITCH_CHANNEL:String = "switch_channel";
        public static const CHANNEL_INITED:String = "channel_inited";
        public static const MIC_MODE_CHANGE:String = "mic_mode_change";
        public static const CHANNEL_MODE_CHANGE:String = "channel_mode_change";
        public static const RECONNECT:String = "reconnect";
        public static const INIT_COMPELETE:String = "init_compelete";
        public static const SINGER_CHANGE:String = "mic_user_change";
        public static const DESTORY:String = "Destory";
        public static const SET_VIDEO_ENABLE:String = "SET_VIDEO_ENABLE";
        public static const VIDEO_ENABLE_CHNAGE:String = "VIDEO_ENABLE_CHNAGE";
        public static const CPU_VALUE_CHNAGE:String = "CPU_VALUE_CHNAGE";
        public static const R_ONLINE:String = "R_ONLINE";

        public function ClientEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
