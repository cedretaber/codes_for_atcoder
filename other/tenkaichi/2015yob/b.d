import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    int p;
    if (S == "{}") {
        writeln("dict");
        return;
    }
    foreach (c; S) {
        switch (c) {
            case '{': ++p; break;
            case '}': --p; break;
            case ':':
                if (p == 1) {
                    writeln("dict");
                    return;
                }
                break;
            case ',':
                if (p == 1) {
                    writeln("set");
                    return;
                }
                break;
            default:
        }
    }
    writeln("set");
}