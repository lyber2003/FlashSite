package rabitui.controls.scroll
{
    import rabitui.controls.button.*;

    public class SimpleScrollBarThumb extends SkinButtonBase
    {

        public function SimpleScrollBarThumb()
        {
            super(Asset_skin_scrollbarthumb_up, Asset_skin_scrollbarthumb_over, Asset_skin_scrollbarthumb_down, Asset_skin_scrollbarthumb_disable);
            setSize(8, 50);
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
