package components.singer
{
    import com.carlcalderon.arthropod.*;
    import rabitui.controls.image.*;
    import rabitui.uicore.*;

    public class UserPhoto extends UIObject
    {
        private var assetDefault:AssetUserPhoto;
        public var avator:Image;

        public function UserPhoto()
        {
            return;
        }// end function

        override protected function createChildren() : void
        {
            this.assetDefault = new AssetUserPhoto();
            addChild(this.assetDefault);
            this.avator = new Image();
            this.avator.x = 3;
            this.avator.y = 3;
            this.avator.setSize(54, 54);
            addChild(this.avator);
            setSize(54, 54);
            return;
        }// end function

        public function setUrl(param1:String) : void
        {
            Debug.log("setUrl:" + param1);
            this.avator.load(param1);
            return;
        }// end function

    }
}
