package rcbiz.widget.proto
{
    import rcbiz.interfaces.proto.*;

    public class ShowProtoApi extends Object implements IShowProtoApi
    {
        private var api:IClientProtoApi;
        private var id:int;

        public function ShowProtoApi(param1:IClientProtoApi, param2:int)
        {
            this.api = param1;
            this.id = param2;
            return;
        }// end function

        public function PHandshake() : void
        {
            this.callServer("PHandshake", {version:RCShow.version});
            return;
        }// end function

        public function PInitShowWidget() : void
        {
            this.callServer("PInitShowWidget");
            return;
        }// end function

        public function PGetUserInfo() : void
        {
            this.callServer("PGetUserInfo");
            return;
        }// end function

        public function PGetSingerInfo() : void
        {
            this.callServer("PGetSingerInfo");
            return;
        }// end function

        public function PGetGiftList() : void
        {
            this.callServer("PGetGiftList");
            return;
        }// end function

        public function PGetGiftPacket() : void
        {
            this.callServer("PGetGiftPacket");
            return;
        }// end function

        public function PGetRanking() : void
        {
            this.callServer("PGetRanking");
            return;
        }// end function

        public function PSendGift(param1:int, param2:int, param3:int, param4:int) : void
        {
            this.callServer("PSendGift", {id:param1, num:param2, buy:param3, videoOpen:param4});
            return;
        }// end function

        public function PGetChanGiftRecord() : void
        {
            this.callServer("PGetChanGiftRecord");
            return;
        }// end function

        public function PSendHeart() : void
        {
            this.callServer("PSendHeart", {num:1});
            return;
        }// end function

        public function PConvertHeart(param1:int) : void
        {
            this.callServer("PConvertHeart", {num:param1});
            return;
        }// end function

        public function PGetHeart() : void
        {
            this.callServer("PGetHeart");
            return;
        }// end function

        public function PGetShowTool() : void
        {
            this.callServer("PGetShowTool");
            return;
        }// end function

        public function PGetToolPacket() : void
        {
            this.callServer("PGetToolPacket");
            return;
        }// end function

        public function PGetChanAttr() : void
        {
            this.callServer("PGetChanAttr");
            return;
        }// end function

        public function PSetEffect(param1:int, param2:int, param3:int) : void
        {
            this.callServer("PSetEffect", {type:param1, id:param2, buy:param3});
            return;
        }// end function

        public function PLuckydraw() : void
        {
            this.callServer("PLuckydraw");
            return;
        }// end function

        public function PGetLuckySinger() : void
        {
            this.callServer("PGetLuckySinger");
            return;
        }// end function

        public function PGetLuckydrawRemain() : void
        {
            this.callServer("PGetLuckydrawRemain");
            return;
        }// end function

        public function PLuckydrawBySilver() : void
        {
            this.callServer("PLuckydrawBySilver");
            return;
        }// end function

        public function PGetToolState() : void
        {
            this.callServer("PGetToolState");
            return;
        }// end function

        public function PSmashEgg(param1:String) : void
        {
            this.callServer("PSmashEgg", {egg:param1});
            return;
        }// end function

        public function PRefreshEgg(param1:int = 0) : void
        {
            this.callServer("PRefreshEgg", {force:param1});
            return;
        }// end function

        public function PSpeaker(param1:String) : void
        {
            this.callServer("PSpeaker", {message:param1});
            return;
        }// end function

        public function PMakeWish(param1:String) : void
        {
            this.callServer("PMakeWish", {message:param1});
            return;
        }// end function

        public function PGetWish() : void
        {
            this.callServer("PGetWish");
            return;
        }// end function

        public function POpenGiftBox(param1:int, param2:int) : void
        {
            this.callServer("POpenGiftBox", {box:param1, singer:param2});
            return;
        }// end function

        public function PGetActivityInfo() : void
        {
            this.callServer("PGetActivityInfo");
            return;
        }// end function

        public function PGetActivityInfo2() : void
        {
            this.callServer("PGetActivityInfo2");
            return;
        }// end function

        public function PGetDailyPacket() : void
        {
            this.callServer("PGetDailyPacket");
            return;
        }// end function

        public function PUnfollowSinger() : void
        {
            this.callServer("PUnfollowSinger");
            return;
        }// end function

        public function PFollowSinger() : void
        {
            this.callServer("PFollowSinger");
            return;
        }// end function

        public function PCallFans() : void
        {
            this.callServer("PCallFans");
            return;
        }// end function

        public function PCanCallFans() : void
        {
            this.callServer("PCanCallFans");
            return;
        }// end function

        public function PIsFollow() : void
        {
            this.callServer("PIsFollow");
            return;
        }// end function

        public function PGetTaskReward(param1:int) : void
        {
            this.callServer("PGetTaskReward", {id:param1});
            return;
        }// end function

        public function PGetTaskInfo() : void
        {
            this.callServer("PGetTaskInfo");
            return;
        }// end function

        public function PGetTimestamp() : void
        {
            this.callServer("PGetTimestamp");
            return;
        }// end function

        public function PGetRankInfo() : void
        {
            this.callServer("PGetRankInfo");
            return;
        }// end function

        public function PGetLoginPacket() : void
        {
            this.callServer("PGetLoginPacket");
            return;
        }// end function

        public function PSendLoginPacket() : void
        {
            this.callServer("PSendLoginPacket");
            return;
        }// end function

        public function PGetGroupInfo() : void
        {
            this.callServer("PGetGroupInfo");
            return;
        }// end function

        public function PGetVideoSinger() : void
        {
            this.callServer("PGetVideoSinger");
            return;
        }// end function

        public function PLogActiveUser() : void
        {
            this.callServer("PLogActiveUser", {version:RCShow.version});
            return;
        }// end function

        public function PGetGuardApplyInfo() : void
        {
            this.callServer("PGetGuardApplyInfo");
            return;
        }// end function

        public function PGetSingerGuard() : void
        {
            this.callServer("PGetSingerGuard");
            return;
        }// end function

        public function PGetGuardApplyList() : void
        {
            this.callServer("PGetGuardApplyList");
            return;
        }// end function

        public function PApplySingerGuard(param1:int, param2:int) : void
        {
            this.callServer("PApplySingerGuard", {duration:param2, singerUid:param1});
            return;
        }// end function

        public function PAcceptGuardApply(param1:int) : void
        {
            this.callServer("PAcceptGuardApply", {id:param1});
            return;
        }// end function

        public function PEnterChannel() : void
        {
            this.callServer("PEnterChannel");
            return;
        }// end function

        public function PGetChip() : void
        {
            this.callServer("PGetChip");
            return;
        }// end function

        public function PMergeChip(param1:int) : void
        {
            this.callServer("PMergeChip", {id:param1});
            return;
        }// end function

        public function PGetAds() : void
        {
            this.callServer("PGetAds");
            return;
        }// end function

        public function PGetLevelInfo() : void
        {
            this.callServer("PGetLevelInfo");
            return;
        }// end function

        public function PInitEnv(param1:int) : void
        {
            this.callServer("PInitEnv", {toolVersion:param1});
            return;
        }// end function

        public function PInitUser() : void
        {
            this.callServer("PInitUser");
            return;
        }// end function

        public function PReadNotice() : void
        {
            this.callServer("PReadNotice");
            return;
        }// end function

        public function PGetLuckyDail() : void
        {
            this.callServer("PGetLuckyDail");
            return;
        }// end function

        public function PDrawLuckyDail() : void
        {
            this.callServer("PDrawLuckyDail");
            return;
        }// end function

        public function PFcGetChess() : void
        {
            this.callServer("PFcGetChess");
            return;
        }// end function

        public function PFcBuyGamePoint(param1:int) : void
        {
            this.callServer("PFcBuyGamePoint", {point:param1});
            return;
        }// end function

        public function PFcThrowDice() : void
        {
            this.callServer("PFcThrowDice");
            return;
        }// end function

        public function PLuckyShake() : void
        {
            this.callServer("PLuckyShake");
            return;
        }// end function

        public function PIkalaVerify() : void
        {
            this.callServer("PIkalaVerify");
            return;
        }// end function

        public function PGetActivityDailyPacket() : void
        {
            this.callServer("PGetActivityDailyPacket");
            return;
        }// end function

        public function PBuyActivityGiftPacket() : void
        {
            this.callServer("PBuyActivityGiftPacket");
            return;
        }// end function

        public function PCheckShowCardSpeaker() : void
        {
            this.callServer("PCheckShowCardSpeaker");
            return;
        }// end function

        public function PGetDailyShowCardGift(param1:int = 0) : void
        {
            this.callServer("PGetDailyShowCardGift", {check:param1});
            return;
        }// end function

        public function PBuyShowCard(param1:uint) : void
        {
            this.callServer("PBuyShowCard", {time:param1});
            return;
        }// end function

        public function PGetActivityHourlyPacket() : void
        {
            this.callServer("PGetActivityHourlyPacket");
            return;
        }// end function

        public function PStartGame() : void
        {
            this.callServer("PStartGame");
            return;
        }// end function

        public function PGameJoinApply() : void
        {
            this.callServer("PGameJoinApply");
            return;
        }// end function

        public function PSendGameStatus(param1:int = 0) : void
        {
            this.callServer("PSendGameStatus", {gameResult:param1});
            return;
        }// end function

        public function PGetFaceBookInfo() : void
        {
            this.callServer("PGetFaceBookInfo");
            return;
        }// end function

        private function callServer(param1:String, param2:Object = null) : void
        {
            if (param2 == null)
            {
                param2 = new Object();
            }
            param2.cmd = param1;
            this.api.SecCallServer(this.id, JSON.stringify(param2));
            return;
        }// end function

    }
}
