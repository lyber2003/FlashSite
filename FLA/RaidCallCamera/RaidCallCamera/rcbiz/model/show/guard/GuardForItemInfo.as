package rcbiz.model.show.guard
{

    public class GuardForItemInfo extends Object
    {
        public var type:int;
        public var nick:String = "";
        public var uid:int;
        public var closeLevel:int;
        public var closeValue:int;
        public var authTime:int;
        public var endTime:int;
        public var dayLeft:int;

        public function GuardForItemInfo(param1:Object = null)
        {
            this.updateData(param1);
            return;
        }// end function

        public function updateData(param1:Object) : void
        {
            var _loc_2:* = null;
            if (param1)
            {
                for (_loc_2 in param1)
                {
                    
                    if (this.hasOwnProperty(_loc_2))
                    {
                        this[_loc_2] = _loc_4[_loc_2];
                    }
                }
            }
            return;
        }// end function

    }
}
