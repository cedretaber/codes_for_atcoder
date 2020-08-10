import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias A = Tuple!(int, "i", long, "v");

void main()
{
    auto N = readln.chomp.to!int;
    A[] AS;
    foreach (i, a; readln.split.to!(long[])) AS ~= A(i.to!int, a);
    sort!"a.v < b.v"(AS);
    auto BS = readln.split.to!(long[]);
    sort(BS);

    auto CS = new long[](N);
    CS[0] = max(AS[0].v - BS[0], 0);
    foreach (i; 1..N) CS[i] = max(CS[i-1], AS[i].v - BS[i]);

    auto DS = new long[](N);
    DS[N-1] = max(AS[N].v - BS[N-1], 0);
    foreach_reverse (i; 1..N) DS[i-1] = max(DS[i], AS[i].v - BS[i-1]);

    auto rs = new long[](N+1);
    rs[AS[0].i] = DS[0];
    foreach (i; 1..N) rs[AS[i].i] = max(CS[i-1], DS[i]);
    rs[AS[N].i] = CS[N-1];
    writeln(rs.to!(string[]).join(" "));
}