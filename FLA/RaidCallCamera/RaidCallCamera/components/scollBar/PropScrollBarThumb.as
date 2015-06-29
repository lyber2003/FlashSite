package components.scollBar
{
    import rabitui.controls.button.*;

    public class PropScrollBarThumb extends SkinButtonBase
    {

        public function PropScrollBarThumb()
        {
            super(Asset_prop_scrollbarthumb_up, Asset_prop_scrollbarthumb_over, Asset_prop_scrollbarthumb_down);
            setSize(10, 50);
            return;
        }// end function

        override protected function updateDisplay() : void
        {
            if (_content)
            {
                _content.x = 1;
                _content.y = 1;
                _content.width = preferWidth - 2;
                _content.height = preferHeight - 2;
            }
            return;
        }// end function

    }
}
