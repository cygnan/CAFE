/+ ------------------------------------------------------------ +
 + Author : aoitofu <aoitofu@dr.com>                            +
 + This is part of CAFE ( https://github.com/aoitofu/CAFE ).    +
 + ------------------------------------------------------------ +
 + Please see /LICENSE.                                         +
 + ------------------------------------------------------------ +/
module cafe.project.Project;
import cafe.config,
       cafe.json,
       cafe.project.ObjectPlacingInfo,
       cafe.project.ComponentList;
import std.conv,
       std.json;

debug = 0;

/+ プロジェクト全体のデータ +/
class Project
{
    enum DefaultSamplingRate = 44100;
    enum DefaultFPS          = 30;

    private:
        ComponentList component_list;

    public:
        string author;
        string copyright;
        uint   samplingRate = DefaultSamplingRate;
        uint   fps          = DefaultFPS;

        @property componentList () { return component_list; }

        this ( Project src )
        {
            component_list = new ComponentList( src.componentList );
        }

        this ()
        {
            component_list = new ComponentList;
        }

        this ( JSONValue j )
        {
            if ( j["app"].str != AppName || j["ver"].str != AppVer )
                throw new Exception( "Imcompatible Project Version" );
            component_list = new ComponentList( j["components"] );
            author = j["author"].str;
            copyright = j["copyright"].str;
            samplingRate = j["samplingRate"].getUInteger;
            fps = j["fps"].getUInteger;
        }

        @property selectingObject ()
        {
            return componentList.selecting ?
                componentList.selecting.timeline.selecting :
                null ;
        }

        /+ レンダリング結果を返す                                    +
         + フレーム数を指定した場合は必ずrootがレンダリングされます。+/
        auto render ( FrameAt f = null )
        {
            auto comp = componentList.renderTarget( f !is null );
            auto frame = f ? f : new FrameAt( comp.timeline.frame );
            auto w = comp.width;
            auto h = comp.height;
            return comp.render( frame );
        }

        /+ JSON出力 +/
        @property json ()
        {
            JSONValue j;
            j["app"] = JSONValue(AppName);
            j["ver"] = JSONValue(AppVer);
            j["components"]   = JSONValue(componentList.json);
            j["author"]       = JSONValue(author);
            j["copyright"]    = JSONValue(copyright);
            j["samplingRate"] = JSONValue(samplingRate);
            j["fps"]          = JSONValue(fps);
            return j;
        }

        debug (1) unittest {
            auto hoge = new Project;
            auto hoge2 = new Project(hoge.json);
            assert( hoge.json.to!string == hoge2.json.to!string );
        }
}
