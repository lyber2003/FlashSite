package rcbiz.events
{
    import flash.events.*;

    public class ShowEvent extends Event
    {
        public var data:Object;
        public static const INIT_SHOW_WIDGET:String = "INIT_SHOW_WIDGET";
        public static const SEND_HEART_RESULT:String = "SendHeartResult";
        public static const CONVERT_HEART_RESULT:String = "ConvertHeartResult";
        public static const HEART_NOTIFY:String = "HeartNotify";
        public static const ON_GET_GIFT_LIST:String = "OnGetGiftList";
        public static const ON_GET_PACKET:String = "OnGetPacket";
        public static const ON_DEL_PACKET_ITEM:String = "OnDelPacketItem";
        public static const ON_PACKET_CHANGE:String = "OnGiftPacketChange";
        public static const ON_PACKET_ADD:String = "OnGiftPacketAdd";
        public static const ON_GET_CHAN_RECORD:String = "OnGetChanRecord";
        public static const ON_SEND_GIFT_RESULT:String = "OnSendGiftResult";
        public static const GIFT_NOTIFY:String = "OnGiftNotify";
        public static const GIFT_NOTIFY_NEW:String = "GIFT_NOTIFY_NEW";
        public static const ON_BROADCAST_NOTIFY:String = "ON_BROADCAST_NOTIFY";
        public static const SINGER_INFO_UPDATE:String = "onSingerInfoUpdate";
        public static const MYINFO_UPDATE:String = "onMyInfoUpdate";
        public static const ON_GET_RANKING:String = "ON_GET_RANKING";
        public static const SINGER_LEVEL_UP:String = "SINGER_LEVEL_UP";
        public static const ON_BALANCE_CHANGE:String = "ON_BALANCE_CHANGE";
        public static const ON_R_LEVEL_INFO:String = "ON_R_LEVEL_INFO";
        public static const ON_GET_CHAN_ATTR:String = "OnGetChanAttr";
        public static const EFFECT_CHANGE:String = "EffectChange";
        public static const ON_GET_SHOW_LIST:String = "OnGetShowList";
        public static const ON_GET_TOOLPACKET:String = "OnGetToolPacket";
        public static const ON_B_EFFECT:String = "OnBEffect";
        public static const ON_SET_EFFECT:String = "OnSetEffect";
        public static const ON_ERROR:String = "ON_ERROR";
        public static const ON_GET_TOOL_STATE:String = "OnGetTollState";
        public static const BACKGROUND_CHANGE:String = "BackgroundChange";
        public static const ON_GET_DEVICE_LIST:String = "OnGetDeviceList";
        public static const ON_DEVICE_ITEM_CHANGE:String = "OnDeviceItemChange";
        public static const ON_B_PERM:String = "BPerm";
        public static const ON_SET_PERM:String = "OnSetPerm";
        public static const INIT_DEVICE:String = "InitDevice";
        public static const LUCKY_DRAW_SUCCESS:String = "LUCKY_DRAW_SUCCESS";
        public static const LUCKY_DRAW_FAILED:String = "LUCKY_DRAW_FAILED";
        public static const LUCKY_DRAW_REMAIN_UPDATE:String = "LUCKY_DRAW_UPDATE";
        public static const ON_B_LUCKY_DRAW:String = "ON_B_LUCKY_DRAW";
        public static const ON_B_LUCKY_DRAW_DAILY:String = "ON_B_LUCKY_DRAW_DAILY";
        public static const ON_B_SPEAKER:String = "ON_B_SPEAKER";
        public static const ON_B_MakeWish:String = "ON_B_MakeWish";
        public static const ON_R_SPEAKER:String = "ON_R_SPEAKER";
        public static const ON_R_MakeWish:String = "ON_R_MakeWish";
        public static const ON_R_GetWish:String = "ON_R_GetWish";
        public static const ON_R_SPEAKER_INFO:String = "ON_R_SPEAKER_INFO";
        public static const ON_B_FS_RANKING_CHANGE:String = "ON_B_FS_RANKING_CHANGE";
        public static const ON_R_FS_INFO:String = "ON_R_FS_INFO";
        public static const ON_R_GET_DAY_PACKET:String = "ON_R_GET_DAY_PACKET";
        public static const ON_R_FS_INFO_TWO:String = "ON_R_FS_INFO_TWO";
        public static const ON_FS_TIME_ARRIVE:String = "ON_FS_TIME_ARRIVE";
        public static const ON_R_GROUP_INFO:String = "ON_R_GROUP_INFO";
        public static const ON_MERGE_SCORE_CHANGE:String = "ON_MERGE_SCORE_CHANGE";
        public static const ON_R_FOLLOW:String = "ON_R_FOLLOW";
        public static const ON_R_UN_FOLLOW:String = "ON_R_UN_FOLLOW";
        public static const ON_R_CALL_FANS:String = "ON_R_CALL_FANS";
        public static const ON_R_IS_FOLLOW:String = "ON_R_IS_FOLLOW";
        public static const ON_R_CAN_CALL_FANS:String = "ON_R_CAN_CALL_FANS";
        public static const ON_B_FOLLOW_SINGER:String = "ON_B_FOLLOW_SINGER";
        public static const ON_VIDEO_SINGER:String = "ON_VIDEO_SINGER";
        public static const on_R_TASK_IFNO:String = "on_R_TASK_IFNO";
        public static const ON_R_TASK_REWARD:String = "ON_R_TASK_REWARD";
        public static const ON_R_SERVER_TIME:String = "ON_R_SERVER_TIME";
        public static const ON_R_GIFT_RANKING:String = "ON_R_GIFT_RANKING";
        public static const STATE_CHANGE:String = "STATE_CHANGE";
        public static const HANDLE_SHARK_SUCESS:String = "HANDLE_SHARK_SUCESS";
        public static const GET_LOGIN:String = "GET_LOGIN";
        public static const SEND_LOGIN:String = "SEND_LOGIN";
        public static const ON_R_ADS:String = "ON_R_ADS";
        public static const ON_R_READ_NOTICE:String = "ON_R_READ_NOTICE";
        public static const SHOW_GIFT_HELP:String = "SHOW_GIFT_HELP";
        public static const ON_R_GET_CHESS:String = "ON_R_GET_CHESS";
        public static const ON_FC_BUY_POINT:String = "ON_FC_BUY_POINT";
        public static const ON_FC_THROW_DICE:String = "ON_FC_THROW_DICE";
        public static const ON_R_SHARK:String = "ON_R_SHARK";
        public static const ON_B_LUCKY_SHAKE:String = "ON_B_LUCKY_SHAKE";
        public static const ON_R_ACTIVE_DAY_PACKET:String = "ON_R_ACTIVE_DAY_PACKET";
        public static const ON_R_BUY_ACTIVE_GIFT:String = "ON_R_BUY_ACTIVE_GIFT";
        public static const ON_R_CHECK_CARD_SPEAKER:String = "ON_R_CHECK_CARD_SPEAKER";
        public static const ON_R_IKALA:String = "ON_R_IKALA";

        public function ShowEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
