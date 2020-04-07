import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];

    long[51] as, ps;
    as[0] = 1;
    ps[0] = 1;
    foreach (i; 1..51) {
        as[i] = as[i-1] * 2 + 3;
        ps[i] = ps[i-1] * 2 + 1;
    }

    long r;
    while (X > 0 && N >= 0) {
        if (N == 0) {
            r += 1;
            break;
        }
        if (X >= as[N]/2+1) {
            r += ps[N-1] + 1;
            X -= as[N-1] + 2;
        } else {
            X -= 1;
        }
        --N;
    }
    writeln(r);
}