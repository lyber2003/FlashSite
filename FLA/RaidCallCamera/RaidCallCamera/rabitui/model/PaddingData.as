package rabitui.model
{

    public class PaddingData extends Object
    {
        public var left:int;
        public var right:int;
        public var top:int;
        public var bottom:int;
        public var height:int;
        public var width:int;

        public function PaddingData(param1:int, param2:int, param3:int, param4:int, param5:int = 0, param6:int = 0) : void
        {
            this.left = param1;
            this.right = param2;
            this.top = param3;
            this.bottom = param4;
            this.height = param5;
            this.width = param6;
            return;
        }// end function

    }
}
