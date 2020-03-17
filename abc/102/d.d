import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] as = [0];
    foreach (i, a; readln.split.to!(long[])) as ~= a + as[i];

    auto pq = new int[](N+1);
    auto rs = new int[](N+1);

    int i = 2, j = 1;
    while (i <= N) {
        while (j+1 < i && abs(as[j]*2 - as[i]) > abs(as[j+1]*2 - as[i])) ++j;
        pq[i++] = j;
    }
    i = N-2, j = N-1;
    while (i >= 0) {
        while (j-1 > i && abs(as[j]*2 - as[i] - as[N]) > abs(as[j-1]*2 - as[i] - as[N])) --j;
        rs[i--] = j;
    }

    long r = long.max;
    foreach (k; 2..N-1) {
        i = pq[k];
        j = rs[k];
        r = min(r, max(as[i], as[k]-as[i], as[j]-as[k], as[N]-as[j]) - min(as[i], as[k]-as[i], as[j]-as[k], as[N]-as[j]));
    }
    writeln(r);
}