package rcbiz.model.show.guard
{

    public class GuardApplyItemInfo extends Object
    {
        public var type:int;
        public var nick:String = "";
        public var price:int;
        public var id:int;
        public var singerUid:int;
        public var status:int;
        public var uid:int;
        public var applyTime:int;
        public var singerNick:String;

        public function GuardApplyItemInfo(param1:Object = null)
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
