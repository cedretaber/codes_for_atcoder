import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] bs, cs;
    bs.length = N;
    cs.length = N;
    foreach (i, a; readln.split.to!(int[])) {
        bs[i] = a;
        ++cs[a];
    }
    bs = bs.sort().uniq().array;
    auto small = bs[0];
    if (bs.length == 1) {
        writeln(small <= N/2 || small == N-1 ? "Yes" : "No");
        return;
    } else if (bs.length > 2) {
        writeln("No");
        return;
    } else if (bs[0]+1 != bs[1]) {
        writeln("No");
        return;
    }
    writeln(cs[small] <= small && small-cs[small]+1 <= cs[small+1]/2 ? "Yes" : "No");
}