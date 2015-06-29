package org.bytearray.display
{
    import flash.display.*;
    import flash.geom.*;

    public class ScaleBitmap extends Bitmap
    {
        protected var _originalBitmap:BitmapData;
        protected var _scale9Grid:Rectangle = null;

        public function ScaleBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
        {
            super(param1, param2, param3);
            this._originalBitmap = param1.clone();
            return;
        }// end function

        override public function set bitmapData(param1:BitmapData) : void
        {
            this._originalBitmap = param1.clone();
            if (this._scale9Grid != null)
            {
                if (!this.validGrid(this._scale9Grid))
                {
                    this._scale9Grid = null;
                }
                this.setSize(param1.width, param1.height);
            }
            else
            {
                this.assignBitmapData(this._originalBitmap.clone());
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            if (param1 != width)
            {
                this.setSize(param1, height);
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (param1 != height)
            {
                this.setSize(width, param1);
            }
            return;
        }// end function

        override public function set scale9Grid(param1:Rectangle) : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            if (this._scale9Grid == null && param1 != null || this._scale9Grid != null && !this._scale9Grid.equals(param1))
            {
                if (param1 == null)
                {
                    _loc_2 = width;
                    _loc_3 = height;
                    this._scale9Grid = null;
                    this.assignBitmapData(this._originalBitmap.clone());
                    this.setSize(_loc_2, _loc_3);
                }
                else
                {
                    if (!this.validGrid(param1))
                    {
                        throw new Error("#001 - The _scale9Grid does not match the original BitmapData");
                    }
                    this._scale9Grid = param1.clone();
                    this.resizeBitmap(width, height);
                    scaleX = 1;
                    scaleY = 1;
                }
            }
            return;
        }// end function

        private function assignBitmapData(param1:BitmapData) : void
        {
            super.bitmapData.dispose();
            super.bitmapData = param1;
            return;
        }// end function

        private function validGrid(param1:Rectangle) : Boolean
        {
            return param1.right <= this._originalBitmap.width && param1.bottom <= this._originalBitmap.height;
        }// end function

        override public function get scale9Grid() : Rectangle
        {
            return this._scale9Grid;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            if (this._scale9Grid == null)
            {
                super.width = param1;
                super.height = param2;
            }
            else
            {
                param1 = Math.max(param1, this._originalBitmap.width - this._scale9Grid.width);
                param2 = Math.max(param2, this._originalBitmap.height - this._scale9Grid.height);
                this.resizeBitmap(param1, param2);
            }
            return;
        }// end function

        public function getOriginalBitmapData() : BitmapData
        {
            return this._originalBitmap;
        }// end function

        protected function resizeBitmap(param1:Number, param2:Number) : void
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_12:* = 0;
            var _loc_3:* = new BitmapData(param1, param2, true, 0);
            var _loc_4:* = [0, this._scale9Grid.top, this._scale9Grid.bottom, this._originalBitmap.height];
            var _loc_5:* = [0, this._scale9Grid.left, this._scale9Grid.right, this._originalBitmap.width];
            var _loc_6:* = [0, this._scale9Grid.top, param2 - (this._originalBitmap.height - this._scale9Grid.bottom), param2];
            var _loc_7:* = [0, this._scale9Grid.left, param1 - (this._originalBitmap.width - this._scale9Grid.right), param1];
            var _loc_10:* = new Matrix();
            var _loc_11:* = 0;
            while (_loc_11 < 3)
            {
                
                _loc_12 = 0;
                while (_loc_12 < 3)
                {
                    
                    _loc_8 = new Rectangle(_loc_5[_loc_11], _loc_4[_loc_12], _loc_5[(_loc_11 + 1)] - _loc_5[_loc_11], _loc_4[(_loc_12 + 1)] - _loc_4[_loc_12]);
                    _loc_9 = new Rectangle(_loc_7[_loc_11], _loc_6[_loc_12], _loc_7[(_loc_11 + 1)] - _loc_7[_loc_11], _loc_6[(_loc_12 + 1)] - _loc_6[_loc_12]);
                    _loc_10.identity();
                    _loc_10.a = _loc_9.width / _loc_8.width;
                    _loc_10.d = _loc_9.height / _loc_8.height;
                    _loc_10.tx = _loc_9.x - _loc_8.x * _loc_10.a;
                    _loc_10.ty = _loc_9.y - _loc_8.y * _loc_10.d;
                    _loc_3.draw(this._originalBitmap, _loc_10, null, null, _loc_9, smoothing);
                    _loc_12++;
                }
                _loc_11++;
            }
            this.assignBitmapData(_loc_3);
            return;
        }// end function

    }
}
