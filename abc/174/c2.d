import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto K = readln.chomp.to!long;
    long r = 1, k;
    foreach (_; 0..10^^7+1) {
        k = (k*10+7) % K;
        if (k == 0) {
            writeln(r);
            return;
        }
        ++r;
    }
    writeln(-1);
}