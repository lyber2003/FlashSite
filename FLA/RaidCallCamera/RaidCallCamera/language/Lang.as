package language
{

    public class Lang extends Object
    {

        public function Lang()
        {
            return;
        }// end function

        public static function getString(param1:int) : String
        {
            return Language.getInstance().getString(param1);
        }// end function

        public static function getDulpString(param1:int, ... args) : String
        {
            return Language.getInstance().getLgById(param1, args);
        }// end function

    }
}
