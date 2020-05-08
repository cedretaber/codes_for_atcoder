import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias W = Tuple!(int, "a", int, "b");

void main()
{
    auto N = readln.chomp.to!int;
    W[] ws;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        ws ~= W(ab[0], ab[1]);
    }
    sort!"a.b > b.b"(ws);
    int last = int.max;
    foreach (w; ws) {
        last = min(last, w.b) - w.a;
    }
    writeln(last >= 0 ? "Yes" : "No");
}