import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    P[] RS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        RS ~= P(ab[0], ab[1]);
    }
    foreach (_; 0..N) {
        auto cd = readln.split.to!(int[]);
        BS ~= P(cd[0], cd[1]);
    }
    sort!"a.x > b.x"(RS);
    sort!"a.y < b.y"(BS);
    auto rb = new bool[](N);
    int res;
    foreach (b; BS) {
        foreach (j, r; RS) {
            if (!rb[j] && r.x < b.x && r.y < b.y) {
                rb[j] = true;
                ++res;
                break;
            }
        }
    }
    writeln(res);
}