import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long sum_k;
    foreach (_; 0..N) {
        auto wh = readln.split.to!(long[]);
        sum_k += min(wh[0]/2, wh[1]);
    }
    writeln(sum_k);
}