import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    readln;
    auto ts = readln.split.to!(long[]);
    auto m = readln.chomp.to!int;

    long d;
    long sum = ts.sum;

    foreach (_; 0..m) {
        auto px = readln.split;
        auto p = px[0].to!int;
        auto x = px[1].to!long;

        sum += d;
        d = ts[p-1] - x;
        writeln(sum -= d);
    }
}