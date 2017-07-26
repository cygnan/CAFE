/+ ------------------------------------------------------------ +
 + Author : aoitofu <aoitofu@dr.com>                            +
 + This is part of CAFE ( https://github.com/aoitofu/CAFE ).    +
 + ------------------------------------------------------------ +
 + Please see /LICENSE.                                         +
 + ------------------------------------------------------------ +/
module cafe.gui.controls.timeline.Line;
import cafe.project.timeline.PlaceableObject,
       cafe.project.timeline.property.Property;

/+ タイムラインのライン情報 +/
struct Line
{
    private:
        union Store
        {
            PlaceableObject[] objects;
            Property prop;
        }

        bool is_layer;  // true : Layer, false : property line
        Store store;

        string name;

    public:
        uint  index;    //ラインインデックス
        float height;   // 標準サイズの何倍か

        @property lineName () { return name; }

        this ( uint i, PlaceableObject[] objs, string n, float h = 1 )
        {
            is_layer = true;
            store.objects = objs;
            name = n;
            index = i;
            height = h;
        }

        this ( uint i, Property prop, string n, float h = 1 )
        {
            is_layer = false;
            store.prop = prop;
            name = n;
            index = i;
            height = h;
        }

        /+ オブジェクトレイヤかどうか +/
        @property isLayer ()
        {
            return is_layer;
        }

        /+ プロパティラインかどうか +/
        @property isPropertyLine ()
        {
            return !is_layer;
        }

        @property objects ()
        {
            if ( isLayer ) return store.objects;
            throw new Exception( "This line is not object layer." );
        }

        @property property ()
        {
            if ( isPropertyLine ) return store.prop;
            throw new Exception( "This line is not property line." );
        }
}