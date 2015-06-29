package rcbiz.interfaces.proto
{

    public interface IShowProtoCB
    {

        public function IShowProtoCB();

        function RHandshake(param1:Object) : void;

        function RInitShowWidget(param1:Object) : void;

        function RGetUserInfo(param1:Object) : void;

        function RGetSingerInfo(param1:Object) : void;

        function RGetGiftList(param1:Object) : void;

        function RGetGiftPacket(param1:Object) : void;

        function RGetRanking(param1:Object) : void;

        function RSendGift(param1:Object) : void;

        function RGetChanGiftRecord(param1:Object) : void;

        function RSendHeart(param1:Object) : void;

        function RConvertHeart(param1:Object) : void;

        function RGetHeart(param1:Object) : void;

        function RGetShowTool(param1:Object) : void;

        function RGetToolPacket(param1:Object) : void;

        function RSetEffect(param1:Object) : void;

        function RGetToolState(param1:Object) : void;

        function RGetEggInfo(param1:Object) : void;

        function RSmashEgg(param1:Object) : void;

        function RRefreshEgg(param1:Object) : void;

        function RSpeaker(param1:Object) : void;

        function RMakeWish(param1:Object) : void;

        function RGetWish(param1:Object) : void;

        function RGetActivityInfo(param1:Object) : void;

        function RGetDailyPacket(param1:Object) : void;

        function BActivityRankChange(param1:Object) : void;

        function RFollowSinger(param1:Object) : void;

        function RUnfollowSinger(param1:Object) : void;

        function RCallFans(param1:Object) : void;

        function RIsFollow(param1:Object) : void;

        function RGetTaskInfo(param1:Object) : void;

        function RGetTaskReward(param1:Object) : void;

        function RGetTimestamp(param1:Object) : void;

        function RGetRankInfo(param1:Object) : void;

        function RCanCallFans(param1:Object) : void;

        function RGetLoginPacket(param1:Object) : void;

        function RSendLoginPacket(param1:Object) : void;

        function RGetVideoSinger(param1:Object) : void;

        function RLogActiveUser(param1:Object) : void;

        function RGetGuardApplyInfo(param1:Object) : void;

        function RGetSingerGuard(param1:Object) : void;

        function RGetGuardApplyList(param1:Object) : void;

        function RApplySingerGuard(param1:Object) : void;

        function RAcceptGuardApply(param1:Object) : void;

        function BSendGift(param1:Object) : void;

        function RGetChip(param1:Object) : void;

        function RMergeChip(param1:Object) : void;

        function RGetAds(param1:Object) : void;

        function RGetLevelInfo(param1:Object) : void;

        function RInitEnv(param1:Object) : void;

        function RInitUser(param1:Object) : void;

        function RGetLuckyDail(param1:Object) : void;

        function RDrawLuckyDail(param1:Object) : void;

        function RGetLuckySinger(param1:Object) : void;

        function RReadNotice(param1:Object) : void;

        function RFcGetChess(param1:Object) : void;

        function RFcBuyGamePoint(param1:Object) : void;

        function RFcThrowDice(param1:Object) : void;

        function RLuckyShake(param1:Object) : void;

        function BGift(param1:Object) : void;

        function BEffect(param1:Object) : void;

        function BMicOff(param1:Object) : void;

        function BMicOn(param1:Object) : void;

        function BHeart(param1:Object) : void;

        function BSmashEgg(param1:Object) : void;

        function BBroadcast(param1:Object) : void;

        function BSpeaker(param1:Object) : void;

        function BMakeWish(param1:Object) : void;

        function BSingerLevelUp(param1:Object) : void;

        function BFollowSinger(param1:Object) : void;

        function BAcceptGuardApply(param1:Object) : void;

        function BApplySingerGuard(param1:Object) : void;

        function BEnterChannel(param1:Object) : void;

        function BDrawLuckyDail(param1:Object) : void;

        function BLuckyShake(param1:Object) : void;

        function RIkalaVerify(param1:Object) : void;

        function RBuyActivityGiftPacket(param1:Object) : void;

        function RCheckShowCardSpeaker(param1:Object) : void;

        function RGetDailyShowCardGift(param1:Object) : void;

        function RBuyShowCard(param1:Object) : void;

        function RGetActivityHourlyPacket(param1:Object) : void;

        function RStartGame(param1:Object) : void;

        function RGameJoinApply(param1:Object) : void;

        function RSendGameStatus(param1:Object) : void;

        function RGetFaceBookInfo(param1:Object) : void;

        function BStartGame(param1:Object) : void;

    }
}
