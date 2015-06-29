package rcbiz.model.show.active
{

    public class FsRankingChangeInfo extends Object
    {
        public var rankChange:int;
        public var rank:int;
        public var singerUid:int;
        public var member:int;
        public var type:int;

        public function FsRankingChangeInfo(param1:Object)
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
