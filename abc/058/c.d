import std.stdio, std.algorithm, std.conv, std.array, std.string, std.range;

string[][50] SS;

void main()
{
    auto n = readln.chomp.to!int;
    foreach (i; 0..n) SS[i] = readln.chomp.split("").sort().array
    ;
    auto ss = SS[0..n];

    if (n == 1) {
        writeln(ss[0].join);
    } else {
        auto ret = setIntersection(ss[0], ss[1]).array;

        if (n > 1)
            foreach (s; ss[2..$]) ret = setIntersection(ret, s).array;

        writeln(ret.join);
    }
}
