import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto now = "indeednow".to!(dchar[]);
    sort(now);
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto S = readln.chomp.to!(dchar[]);
        sort(S);
        writeln(now == S ? "YES" : "NO");
    }
}