package helper
{
    import flash.net.*;

    public class GetURLHelper extends Object
    {
        public static const URL_RCSHOW:String = "http://rcshow.tv/index.php?c=showroom&a=baseInfo&uid=";

        public function GetURLHelper()
        {
            return;
        }// end function

        public static function goToRCShow(param1:int, param2:String) : void
        {
            navigateToURL(new URLRequest(URL_RCSHOW + param1 + "&param=" + param2));
            return;
        }// end function

        public static function getAvator(param1:int) : String
        {
            var _loc_2:* = UrlHelper.getInstance().getUrlByType(UrlHelper.TYPE_IMAGE) + "?uid=" + param1 + "&type=100";
            return _loc_2;
        }// end function

    }
}
