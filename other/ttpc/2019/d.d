import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    bool[] ps;
    ps.length = 10^^6+1;
    ps[] = true;
    ps[0] = false;
    ps[1] = false;
    foreach (i; 2..10^^6+1) {
        if (ps[i]) {
            for (int j = i*2; j <= 10^^6; j += i) ps[j] = false;
        }
    }

    auto N = readln.chomp.to!int;
    int X;
    foreach (x; readln.split.to!(int[])) {
        if (x == 7) {
            X ^= 3;
        } else if (ps[x-2]) {
            X ^= 2;
        } else {
            X ^= 1;
        }
    }
    writeln(X == 0 ? "Ai" : "An");
}