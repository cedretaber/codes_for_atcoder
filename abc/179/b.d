import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    int c;
    bool ok;
    foreach (_; 0..N) {
        auto ab = readln.split;
        if (ab[0] == ab[1]) {
            ++c;
            if (c >= 3) ok = true;
        } else {
            c = 0;
        }
    }
    writeln(ok ? "Yes" : "No");
}