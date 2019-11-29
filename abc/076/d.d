import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias TV = Tuple!(int, "t", int, "v");

int[200*100*2+2] GP;

void main()
{
    auto N = readln.chomp.to!int;
    auto ts = readln.split.to!(int[]).map!"a * 2".array;
    auto vs = readln.split.to!(int[]).map!"a * 2".array;

    foreach (i; 0..N-1) ts[i+1] += ts[i];

    foreach (ref gp; GP) gp = int.max;

    int i = 1;
    foreach (j, t; ts) {
        --i;
        while (i <= t) {
            GP[i] = min(GP[i], vs[j]);
            ++i;
        }
    }

    foreach (j, t; ts) {
        auto x = j == N-1 ? 1 : vs[j+1]+1;
        foreach_reverse (k; 0..t) {
            if (GP[k] <= x) break;
            GP[k] = x++;
        }
    }

    i = 0;
    double r = 0;
    foreach (j; 0..ts[$-1]) {
        i = min(GP[j], i);
        r += i++;
    }

    writefln("%.12f", r / 4.0);
}