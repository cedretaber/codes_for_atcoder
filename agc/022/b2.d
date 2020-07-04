import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 3) {
        writeln("2 5 63");
        return;
    }

    int[] ths;
    foreach (i; 1..30001) {
        if (i%2 != 0 && i%3 == 0) ths ~= i;
    }
    int[] res;
    size_t t;
    while (t < ths.length && N > 3) {
        res ~= ths[t++];
        res ~= ths[t++];
        N -= 2;
    }
    int x = 1, s;
    foreach (_; 0..N) {
        res ~= 2*x;
        s += x;
        ++x;
    }
    if (s%3 != 0) {
        res ~= 2*x;
        s += x;
        switch (s%3) {
            case 1:
                res = res[0..t] ~ res[t+1..$];
                break;
            case 2:
                res = res[0..t+1] ~ res[t+2..$];
                break;
            default:
                res = res[0..t+2] ~ res[t+3..$];
        }
    }
    writeln(res.to!(string[]).join(" "));
}