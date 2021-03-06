/+ ------------------------------------------------------------ +
 + Author : aoitofu <aoitofu@dr.com>                            +
 + This is part of CAFE ( https://github.com/aoitofu/CAFE ).    +
 + ------------------------------------------------------------ +
 + Please see /LICENSE.                                         +
 + ------------------------------------------------------------ +/
module cafe.config;
import std.format;
import dlangui.core.settings;

/+ バージョン文字列について              +
 + a.b.c [Stable/Beta/Alpha/Pre-Alpha]   +
 + a : メジャーバージョン                +
 + b : マイナーバージョン                +
 + c : 累積バージョン                    +/
enum AppName = "CAFEditor";
enum AppVer  = "0.0.4 Alpha";
enum AppText = "%s %s".format( AppName, AppVer );
enum AppURL  = "https://aoitofu.github.io/CAFE";

enum License    = "GNU General Public License 3.0";
enum LicenseURL = "https://github.com/aoitofu/CAFE/blob/master/LICENSE";

class Config : SettingsFile
{
    static __gshared Config instance = new Config;

    public:
        this ()
        {
            super();
        }
}
alias CafeConf = Config.instance;

@property config ( string path )
{
    return CafeConf.setting.objectByPath( path, true );
}
