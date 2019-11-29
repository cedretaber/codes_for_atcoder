import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range;

void main()
{
    auto s = readln.chomp;

    string ret;

    foreach (c; s) {
        switch (c) {
            case 'B':
                if (!ret.empty)
                    ret = ret[0..$-1];
                break;
            default:
                ret ~= c;
        }
    }

    writeln(ret);
}