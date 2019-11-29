import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[int] NS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto A = readln.chomp.to!int;
        if (A in NS)
            ++NS[A];
        else
            NS[A] = 1;
    }
    int ret;
    foreach (a; NS.byValue) if (a & 1) ++ret;
    writeln(ret);
}