package components.events
{
    import flash.events.*;

    public class CompomentEvent extends Event
    {
        public var data:Object;
        public static const RANKING_NAME_CLICK:String = "RANKING_NAME_CLICK";
        public static const SHOW_USER_INFO:String = "SHOW_USER_INFO";
        public static const BROAD_NEWS_CLICK:String = "BROAD_NEWS_CLICK";
        public static const LINK_NEWS_CLICK:String = "LINK_NEWS_CLICK";
        public static const AGREE_VIDEO_RULE:String = "AGREE_VIDEO_RULE";
        public static const SHOW_GIFT_VIEW:String = "SHOW_GIFT_VIEW";
        public static const SHOW_SPEAKER_VIEW:String = "SHOW_SPEAKER_VIEW";
        public static const SHOW_EGG_VIEW:String = "SHOW_EGG_VIEW";
        public static const STORE_MONEY:String = "STORE_MONEY";
        public static const GET_DUMP:String = "GET_DUMP";
        public static const RECEIVED_REWARD:String = "RECEIVED_REWARD";
        public static const ON_SHOW_CARD_TIP:String = "ON_SHOW_CARD_TIP";
        public static const ON_THROW_DICE:String = "ON_THROW_DICE";
        public static const ON_BUY_GAME_POINT:String = "ON_BUY_GAME_POINT";
        public static const ON_FREE_GET:String = "ON_FREE_GET";
        public static const SHOW_RANK:String = "ON_SHOW_RANK";
        public static const SHOW_TIP:String = "SHOW_TIP";
        public static const CLOSE_TIP:String = "CLOSE_TIP";
        public static const SINGER_PHOTO_CLICK:String = "SINGER_PHOTO_CLICK";
        public static const MODE_CHANGE:String = "MODE_CHANGE";

        public function CompomentEvent(param1:String, param2:Object = null)
        {
            this.data = param2;
            super(param1);
            return;
        }// end function

    }
}
