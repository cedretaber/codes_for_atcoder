import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long[32] WS;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    long X = nx[1];
    foreach (i; 0..N) WS[i] = readln.chomp.to!long;

    auto ns = [0L], nss = [0L];
    foreach (i; 0..N/2) {
        foreach (j; 0..ns.length) ns ~= ns[j] + WS[i];
    }
    foreach (i; N/2..N) {
        foreach (j; 0..nss.length) nss ~= nss[j] + WS[i];
    }
    int[long] ND;
    foreach (n; nss) {
        if (n in ND) {
            ++ND[n];
        } else {
            ND[n] = 1;
        }
    }

    int res;
    foreach (n; ns) {
        auto x = X - n;
        if (x in ND) {
            res += ND[x];
        }
    }

    writeln(res);
}