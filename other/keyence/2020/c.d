import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
 
void main()
{
    auto nks = readln.split.to!(long[]);
    auto N = nks[0];
    auto K = nks[1];
    auto S = nks[2];

    auto rs = new long[](N);
    foreach (i; 0..K) {
        rs[i] = S;
    }
    auto x = S == 10^^9 ? 1 : 10^^9;
    foreach (i; K..N) {
        rs[i] = x;
    }
    writeln(rs.to!(string[]).join(" "));
}