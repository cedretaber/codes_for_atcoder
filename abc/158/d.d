import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(dchar[]);
    auto Q = readln.chomp.to!int;

    dchar[] as, bs;
    int f;
    foreach (_; 0..Q) {
        auto q = readln;
        if (q[0] == '1') {
            ++f;
        } else {
            auto c = q[4].to!dchar;
            if ((q[2] == '1' && f%2 == 0) || (q[2] == '2' && f%2 == 1)) {
                as ~= c;
            } else {
                bs ~= c;
            }
        }
    }
    if (f%2 == 1) {
        S.reverse();
        bs.reverse();
        writeln(bs ~ S ~ as);
    } else {
        as.reverse();
        writeln(as ~ S ~ bs);
    }
}