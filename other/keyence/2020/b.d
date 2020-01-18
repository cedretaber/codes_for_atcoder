import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
 
alias R = Tuple!(long, "s", long, "t");
 
void main()
{
    auto N = readln.chomp.to!int;
    R[] rs;
    foreach (_; 0..N) {
        auto xl = readln.split.to!(long[]);
        auto x = xl[0];
        auto l = xl[1];
        rs ~= R(x-l, x+l);
    }
    sort!"a.t == b.t ? a.s < b.s : a.t < b.t"(rs);
    long last = -1, x;
    foreach (r; rs) {
        if (last == -1) {
            ++x;
            last = r.t;
        } else if (last <= r.s) {
            ++x;
            last = r.t;
        }
    }
    writeln(x);
}