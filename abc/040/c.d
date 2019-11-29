import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[100000] AS;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    foreach_reverse (i, a; as) {
        if (i == N-1) {
            AS[i] = 0;
        } else {
            auto r = AS[i+1] + abs(a - as[i+1]);
            if (i+2 < N) r = min(r, AS[i+2] + abs(a - as[i+2]));
            AS[i] = r;
        }
    }
    
    writeln(AS[0]);
}