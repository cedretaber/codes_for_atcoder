import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias N = Tuple!(int, "v", int, "c");

void main()
{
    auto n = readln.chomp.to!int;
    N[] as, bs;
    foreach (i; 0..10^^5+1) {
        as ~= N(i, 0);
        bs ~= N(i, 0);
    }
    foreach (i, v; readln.split.to!(int[])) {
        if (i%2 == 0) {
            ++as[v].c;
        } else {
            ++bs[v].c;
        }
    }
    sort!"a.c > b.c"(as);
    sort!"a.c > b.c"(bs);
    if (as[0].v == bs[0].v) {
        if (as[1].c > bs[1].c) {
            writeln(n - as[1].c - bs[0].c);
        } else {
            writeln(n - as[0].c - bs[1].c);
        }
    } else {
        writeln(n - as[0].c - bs[0].c);
    }
}