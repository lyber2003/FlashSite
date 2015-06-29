package 
{
    import RCShow.*;
    import animation.*;
    import com.debug.*;
    import components.*;
    import controler.*;
    import flash.display.*;
    import particles.*;
    import rabitui.manager.*;
    import rcbiz.*;
    import utils.*;

    public class RCShow extends ClientFlashApp
    {
        private var mainLayer:MainStage;
        private var animationLayer:Sprite;
        private var popupLayer:Sprite;
        private var propLayer:Sprite;
        private var tipLayer:Sprite;
        private var debugLayer:Sprite;
        private var particleLayer:Sprite;
        private var _mainCon:MainStageControler;
        public static const version:String = "1.0.16";

        public function RCShow()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.animationLayer = new Sprite();
            this.popupLayer = new Sprite();
            this.tipLayer = new Sprite();
            this.debugLayer = new Sprite();
            this.propLayer = new Sprite();
            this.tipLayer.mouseChildren = false;
            this.tipLayer.mouseEnabled = false;
            this.particleLayer = new Sprite();
            this.particleLayer.mouseChildren = false;
            this.particleLayer.mouseEnabled = false;
            addChild(this.animationLayer);
            addChild(this.propLayer);
            addChild(this.popupLayer);
            addChild(this.tipLayer);
            addChild(this.particleLayer);
            addChild(this.debugLayer);
            TipManager.init(this.tipLayer);
            PopUpManager.init(this.popupLayer);
            AnimationManager.init(this.animationLayer);
            return;
        }// end function

        override protected function init() : void
        {
            stage.color = 15792125;
            DebugX.init(this.debugLayer);
            DebugX.enable = true;
            ParticleManager.init(this.particleLayer);
            PopUpManager.init(this.popupLayer);
            this.mainLayer = new MainStage();
            addChildAt(this.mainLayer, 0);
            this._mainCon = new MainStageControler(this.mainLayer);
            WidgetBiz.getInstance().init();
            _update(true);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            this.mainLayer.setSize(_preferWidth, _preferHeight);
            return;
        }// end function

    }
}
