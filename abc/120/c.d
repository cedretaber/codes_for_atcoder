import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    int r, b;
    foreach (c; S) {
        switch (c) {
            case '0':
                ++r;
                break;
            case '1':
                ++b;
                break;
            default:
        }
    }
    writeln(min(r, b) * 2);
}