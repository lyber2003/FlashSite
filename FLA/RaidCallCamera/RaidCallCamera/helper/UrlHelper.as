package helper
{
    import flash.utils.*;

    public class UrlHelper extends Object
    {
        private var URL_LIST:Array;
        private var postfix_list:Dictionary;
        public static var VERSION:String = UrlHelper.VERSION_TW;
        public static const TYPE_GET_CODE:int = 1;
        public static const TYPE_MODIFY:int = 2;
        public static const TYPE_API:int = 3;
        public static const TYPE_CHECK_USE:int = 4;
        public static const TYPE_SINGER:int = 5;
        public static const TYPE_CHECK_CODE:int = 6;
        public static const TYPE_CODE_IMAGE:int = 7;
        public static const TYPE_IMAGE:int = 8;
        public static const VERSION_TW:String = "zh-tw";
        public static const VERSION_UN:String = "un";
        public static const VERSION_RU:String = "ru";
        public static const VERSION_BR:String = "br";
        private static var _instance:UrlHelper;

        public function UrlHelper()
        {
            this.URL_LIST = [];
            this.postfix_list = new Dictionary();
            this.URL_LIST[VERSION_TW] = new Dictionary();
            this.URL_LIST[VERSION_TW][TYPE_GET_CODE] = "http://api.raidtalk.com.tw/user2/getcode.php";
            this.URL_LIST[VERSION_TW][TYPE_MODIFY] = "http://api.raidtalk.com.tw/user2/modifyinfo.php";
            this.URL_LIST[VERSION_TW][TYPE_API] = "http://www.raidtalk.com.tw/user/ajax/api.php";
            this.URL_LIST[VERSION_TW][TYPE_CHECK_USE] = "http://api.raidtalk.com.tw/user2/checkuser.php";
            this.URL_LIST[VERSION_TW][TYPE_SINGER] = "http://api.raidtalk.com.tw/user2/signup_f.php";
            this.URL_LIST[VERSION_TW][TYPE_CHECK_CODE] = "http://api.raidtalk.com.tw/user2/checkcode.php";
            this.URL_LIST[VERSION_TW][TYPE_CODE_IMAGE] = "http://api.raidtalk.com.tw/user2/imgcode.php";
            this.URL_LIST[VERSION_TW][TYPE_IMAGE] = "http://api2.raidtalk.com.tw/user/getimg.php";
            this.URL_LIST[VERSION_UN] = new Dictionary();
            this.URL_LIST[VERSION_UN][TYPE_GET_CODE] = "http://api.raidtalk.com/user2/getcode.php";
            this.URL_LIST[VERSION_UN][TYPE_MODIFY] = "http://api.raidtalk.com/user2/modifyinfo.php";
            this.URL_LIST[VERSION_UN][TYPE_API] = "http://www.raidcall.com/user/ajax/api.php";
            this.URL_LIST[VERSION_UN][TYPE_CHECK_USE] = "http://api.raidtalk.com/user2/checkuser.php";
            this.URL_LIST[VERSION_UN][TYPE_SINGER] = "http://api.raidtalk.com/user2/signup_f.php";
            this.URL_LIST[VERSION_UN][TYPE_CHECK_CODE] = "http://api.raidtalk.com/user2/checkcode.php";
            this.URL_LIST[VERSION_UN][TYPE_CODE_IMAGE] = "http://api.raidtalk.com/user2/imgcode.php";
            this.URL_LIST[VERSION_UN][TYPE_IMAGE] = "http://api.raidtalk.com/user2/getimg_new.php";
            this.URL_LIST[VERSION_RU] = new Dictionary();
            this.URL_LIST[VERSION_RU][TYPE_GET_CODE] = "http://api1.raidcall.com.ru/user/getcode.php";
            this.URL_LIST[VERSION_RU][TYPE_MODIFY] = "http://api1.raidcall.com.ru/user/modifyinfo.php";
            this.URL_LIST[VERSION_RU][TYPE_API] = "http://www.raidcall.com.ru/user/ajax/api.php";
            this.URL_LIST[VERSION_RU][TYPE_CHECK_USE] = "http://api1.raidcall.com.ru/user/checkuser.php";
            this.URL_LIST[VERSION_RU][TYPE_SINGER] = "http://api1.raidcall.com.ru/user/signup_f.php";
            this.URL_LIST[VERSION_RU][TYPE_CHECK_CODE] = "http://api1.raidcall.com.ru/user/checkcode.php";
            this.URL_LIST[VERSION_RU][TYPE_CODE_IMAGE] = "http://api1.raidcall.com.ru/user/imgcode.php";
            this.URL_LIST[VERSION_RU][TYPE_IMAGE] = "http://api1.raidcall.com.ru/user/getimg_new.php";
            this.URL_LIST[VERSION_BR] = new Dictionary();
            this.URL_LIST[VERSION_BR][TYPE_GET_CODE] = "http://api1.raidcall.com.br/user/getcode.php";
            this.URL_LIST[VERSION_BR][TYPE_MODIFY] = "http://api1.raidcall.com.br/user/modifyinfo.php";
            this.URL_LIST[VERSION_BR][TYPE_API] = "http://www.raidcall.com.br/user/ajax/api.php";
            this.URL_LIST[VERSION_BR][TYPE_CHECK_USE] = "http://api1.raidcall.com.br/user/checkuser.php";
            this.URL_LIST[VERSION_BR][TYPE_SINGER] = "http://api1.raidcall.com.br/user/signup_f.php";
            this.URL_LIST[VERSION_BR][TYPE_CHECK_CODE] = "http://api1.raidcall.com.br/user/checkcode.php";
            this.URL_LIST[VERSION_BR][TYPE_CODE_IMAGE] = "http://api1.raidcall.com.br/user/imgcode.php";
            this.URL_LIST[VERSION_BR][TYPE_IMAGE] = "http://api1.raidcall.com.br/user/getimg_new.php";
            this.postfix_list[VERSION_TW] = "@raidcall.com.tw";
            this.postfix_list[VERSION_UN] = "@raidcall.com";
            this.postfix_list[VERSION_RU] = "@raidcall.com";
            this.postfix_list[VERSION_BR] = "@raidcall.com";
            return;
        }// end function

        public function getUrlByType(param1:int) : String
        {
            return this.URL_LIST[VERSION][param1];
        }// end function

        public function isTwVersion() : Boolean
        {
            return VERSION == VERSION_TW;
        }// end function

        public function getPostfix() : String
        {
            return this.postfix_list[UrlHelper.VERSION];
        }// end function

        public static function getInstance() : UrlHelper
        {
            if (_instance == null)
            {
                _instance = new UrlHelper;
            }
            return _instance;
        }// end function

    }
}
