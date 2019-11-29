import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    dchar[][] dic;
    dic.length = N;
    foreach (i; 0..N) {
        auto w = readln.chomp.to!(dchar[]);
        reverse(w);
        dic[i] = w;
    }
    sort(dic);
    foreach (w; dic) {
        reverse(w);
        writeln(w);
    }
}