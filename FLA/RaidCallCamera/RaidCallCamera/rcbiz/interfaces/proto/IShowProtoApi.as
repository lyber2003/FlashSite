package rcbiz.interfaces.proto
{

    public interface IShowProtoApi
    {

        public function IShowProtoApi();

        function PHandshake() : void;

        function PInitShowWidget() : void;

        function PGetUserInfo() : void;

        function PGetSingerInfo() : void;

        function PGetGiftList() : void;

        function PGetGiftPacket() : void;

        function PGetRanking() : void;

        function PSendGift(param1:int, param2:int, param3:int, param4:int) : void;

        function PGetChanGiftRecord() : void;

        function PSendHeart() : void;

        function PConvertHeart(param1:int) : void;

        function PGetHeart() : void;

        function PGetShowTool() : void;

        function PGetToolPacket() : void;

        function PGetChanAttr() : void;

        function PSetEffect(param1:int, param2:int, param3:int) : void;

        function PLuckydraw() : void;

        function PGetLuckydrawRemain() : void;

        function PLuckydrawBySilver() : void;

        function PGetToolState() : void;

        function PSmashEgg(param1:String) : void;

        function PRefreshEgg(param1:int = 0) : void;

        function PSpeaker(param1:String) : void;

        function PMakeWish(param1:String) : void;

        function PGetWish() : void;

        function PGetActivityInfo() : void;

        function PGetActivityInfo2() : void;

        function PGetDailyPacket() : void;

        function PFollowSinger() : void;

        function PUnfollowSinger() : void;

        function PCallFans() : void;

        function PIsFollow() : void;

        function PGetTaskReward(param1:int) : void;

        function PGetTaskInfo() : void;

        function PGetTimestamp() : void;

        function PGetRankInfo() : void;

        function PCanCallFans() : void;

        function PGetVideoSinger() : void;

        function PGetGroupInfo() : void;

        function POpenGiftBox(param1:int, param2:int) : void;

        function PGetLoginPacket() : void;

        function PSendLoginPacket() : void;

        function PLogActiveUser() : void;

        function PGetGuardApplyInfo() : void;

        function PGetSingerGuard() : void;

        function PGetGuardApplyList() : void;

        function PApplySingerGuard(param1:int, param2:int) : void;

        function PAcceptGuardApply(param1:int) : void;

        function PEnterChannel() : void;

        function PGetChip() : void;

        function PMergeChip(param1:int) : void;

        function PGetAds() : void;

        function PGetLevelInfo() : void;

        function PGetLuckyDail() : void;

        function PDrawLuckyDail() : void;

        function PGetLuckySinger() : void;

        function PInitEnv(param1:int) : void;

        function PInitUser() : void;

        function PReadNotice() : void;

        function PFcGetChess() : void;

        function PFcBuyGamePoint(param1:int) : void;

        function PFcThrowDice() : void;

        function PLuckyShake() : void;

        function PBuyActivityGiftPacket() : void;

        function PIkalaVerify() : void;

        function PGetActivityDailyPacket() : void;

        function PCheckShowCardSpeaker() : void;

        function PGetDailyShowCardGift(param1:int = 0) : void;

        function PBuyShowCard(param1:uint) : void;

        function PGetActivityHourlyPacket() : void;

        function PStartGame() : void;

        function PGameJoinApply() : void;

        function PSendGameStatus(param1:int = 0) : void;

        function PGetFaceBookInfo() : void;

    }
}
